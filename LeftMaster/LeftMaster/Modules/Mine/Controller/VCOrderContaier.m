//
//  VCOrderContaier.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCOrderContaier.h"
#import "CellOrderList.h"
#import "VCOrder.h"
#import "ViewTabOrder.h"
#import "ViewSearchOrderList.h"
#import "RequestBeanCartList.h"


@interface VCOrderContaier ()<UITableViewDelegate,UITableViewDataSource,AJHubProtocol>
@property (nonatomic, strong) UITableView *table;
@property(nonatomic,strong)ViewSearchOrderList *searchView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation VCOrderContaier

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.page = 1;
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
}


- (void)loadData{
    RequestBeanCartList *requestBean = [RequestBeanCartList new];
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.page_current = self.page;
    [AJNetworkConfig shareInstance].hubDelegate = self;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanCartList *response = responseBean;
            if(response.success){
                if(self.page == 1){
                    [weakself.dataSource removeAllObjects];
                }
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                if(datas.count < requestBean.page_size){
                    [weakself.table.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakself.table.mj_footer resetNoMoreData];
                }
                [weakself.dataSource addObjectsFromArray:datas];
                [weakself.table reloadData];
            }
        }
    }];
}


/**
 * 显示Hub
 *
 @param tip hub文案
 */
- (void)showHub:(nullable NSString *)tip{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = tip;
    [hud show:YES];
}


/**
 * 隐藏Hub
 */
- (void)dismissHub{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellOrderList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CeCellOrderListll";
    CellOrderList *cell = (CellOrderList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellOrderList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell updateData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[UIView alloc]init];
    }
    return header;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
    if (!footer) {
        footer = [[UIView alloc]init];
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VCOrder *vc = [[VCOrder alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (ViewSearchOrderList*)searchView{
    if(!_searchView){
        _searchView = [[ViewSearchOrderList alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewSearchOrderList calHeight])];
    }
    return _searchView;
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT - [ViewTabOrder calHeight]-NAV_STATUS_HEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.searchView;
        
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakself.page = 1;
            [weakself loadData];
        }];
        
        _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakself.page++;
            [weakself loadData];
        }];
    }
    return _table;
}
@end