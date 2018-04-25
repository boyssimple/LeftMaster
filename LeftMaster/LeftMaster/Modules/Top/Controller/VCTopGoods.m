//
//  VCCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCTopGoods.h"
#import "CellTopGoods.h"
#import "ViewTotalCart.h"
#import "VCWriteOrder.h"
#import "VCWriteOrder.h"
#import "RequestBeanAlwaysBuyGoods.h"
#import "AlwaysBuyGoods.h"

@interface VCTopGoods ()<UITableViewDelegate,UITableViewDataSource,ViewTotalCartDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewTotalCart *vControl;
@property(nonatomic,strong)NSMutableArray *goodsList;
@property (nonatomic, assign) NSInteger page;
@end

@implementation VCTopGoods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.page = 1;
    _goodsList = [NSMutableArray array];
    [self.view addSubview:self.table];
    [self.view addSubview:self.vControl];
}

- (void)loadData{
    RequestBeanAlwaysBuyGoods *requestBean = [RequestBeanAlwaysBuyGoods new];
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.cus_id = [AppUser share].CUS_ID;
    requestBean.company_id = [AppUser share].SYSUSER_COMPANYID;
    requestBean.page_current = self.page;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanAlwaysBuyGoods *response = responseBean;
            if(response.success){
                [weakself handleDatas:[response.data jk_arrayForKey:@"rows"] with:requestBean.page_size];
            }
        }
    }];
}


- (void)handleDatas:(NSArray*)datas with:(NSInteger)size{
    if(self.page == 1){
        [self.goodsList removeAllObjects];
    }
    if(datas.count == 0 || datas.count < size){
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.table.mj_footer resetNoMoreData];
    }
    
    for (NSDictionary *data in datas) {
        AlwaysBuyGoods *cart = [[AlwaysBuyGoods alloc]init];
        [cart parse:data];
        [self.goodsList addObject:cart];
    }
    [self.table reloadData];
    [self calTotal];
}

- (void)calTotal{
    NSInteger num = 0;
    CGFloat total = 0;
    for (AlwaysBuyGoods *c in self.goodsList) {
        if(c.selected){
            num += c.GOODS_STOCK;
            total += [c.GOODS_PRICE floatValue]*c.GOODS_STOCK;
        }
    }
    [self.vControl updateData:num withPrice:total];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellTopGoods calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellTopGoods";
    CellTopGoods *cell = (CellTopGoods*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellTopGoods alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    AlwaysBuyGoods *data = [self.goodsList objectAtIndex:indexPath.row];
    [cell updateData:data];
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
        footer.backgroundColor = APP_Gray_COLOR;
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)clickCheck:(BOOL)selected{
    for (AlwaysBuyGoods *c in self.goodsList) {
        c.selected = selected;
    }
    [self.table reloadData];
    [self calTotal];
}

#pragma mark ViewTotalCartDelegate
- (void)clickOrder{
    VCWriteOrder *vc = [[VCWriteOrder alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-[ViewTotalCart calHeight] - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        
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

- (ViewTotalCart*)vControl{
    if(!_vControl){
        _vControl = [[ViewTotalCart alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewTotalCart calHeight]-TABBAR_HEIGHT, DEVICEWIDTH, [ViewTotalCart calHeight])];
        [_vControl updateData];
        _vControl.delegate = self;
    }
    return _vControl;
}

@end

