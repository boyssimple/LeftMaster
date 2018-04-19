//
//  VCHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCHome.h"
#import "SectionHeaderHome.h"
#import "CellCategoryHome.h"
#import "CellNewHome.h"
#import <SDCycleScrollView.h>
#import "RequestBeanCategoryHome.h"
#import "RequestBeanGoodsList.h"
#import "VCCategory.h"
#import "VCRecGoodsList.h"

@interface VCHome ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,SectionHeaderHomeDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)NSMutableArray *categorys;
@property(nonatomic,strong)NSMutableArray *goodsList;
@end

@implementation VCHome

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMain];
    [self loadData];
    [self loadGoodsListData];
    
}

- (void)initMain{
    [self.view addSubview:self.table];
    _categorys = [NSMutableArray array];
    _goodsList = [NSMutableArray array];
}


- (void)loadData{
    RequestBeanCategoryHome *requestBean = [RequestBeanCategoryHome new];
    requestBean.parent_id = 0;
    requestBean.page_current = 1;
    requestBean.page_size = 10;
    [AJNetworkConfig shareInstance].hubDelegate = self;
    __weak typeof(self) weakself = self;
    
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        
        if (!err) {
            // 结果处理
            ResponseBeanCategoryHome *response = responseBean;
            [weakself.categorys removeAllObjects];
            [weakself.categorys addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
            [weakself.table reloadData];
        }
    }];
    
    
    
}

- (void)readFromNetwork{
    RequestBeanCategoryHome *requestBean = [RequestBeanCategoryHome new];
    requestBean.parent_id = 0;
    requestBean.page_current = 1;
    requestBean.page_size = 10;
    [AJNetworkConfig shareInstance].hubDelegate = self;
    __weak typeof(self) weakself = self;
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        
        if (!err) {
            // 结果处理
            ResponseBeanCategoryHome *response = responseBean;
            [weakself.categorys removeAllObjects];
            [weakself.categorys addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
            [weakself.table reloadData];
        }
    }];
}

- (void)loadGoodsListData{
    RequestBeanGoodsList *requestBean = [RequestBeanGoodsList new];
    requestBean.new_goods = TRUE;
    requestBean.page_current = 1;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanGoodsList *response = responseBean;
            [weakself.goodsList removeAllObjects];
            [weakself.goodsList addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
            [weakself.table reloadData];
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return [CellCategoryHome calHeight:[self.categorys count]];
    }else{
        return [CellNewHome calHeight];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString*identifier = @"CellCategoryHome";
        CellCategoryHome *cell = (CellCategoryHome*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CellCategoryHome alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.dataSource = self.categorys;
        return cell;
    }else{
        static NSString*identifier = @"CellNewHome";
        CellNewHome *cell = (CellNewHome*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CellNewHome alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.dataSource = self.goodsList;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [SectionHeaderHome calHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f*RATIO_WIDHT320;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeaderHome *header = (SectionHeaderHome*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[SectionHeaderHome alloc]init];
        header.delegate = self;
    }
    if(section == 0){
        [header setTitle:@"商品分类" witIcon:@"home_btn_commodity"];
        header.index = 0;
    }else if(section == 1){
        [header setTitle:@"新品推荐" witIcon:@"home_btn_news"];
        header.index = 1;
    }
    return header;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
    if (!footer) {
        footer = [[UIView alloc]init];
        footer.backgroundColor = RGB3(246);
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[UIViewController alloc]init] animated:TRUE];
}

#pragma mark - SectionHeaderHomeDelegate
- (void)sectionClickShowAll:(NSInteger)index{
    if(index == 0){
        VCCategory *vc = [[VCCategory alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        VCRecGoodsList *vc = [[VCRecGoodsList alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.tableHeaderView = self.cycleScrollView;
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.dataSource = self;
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadData];
            [weakself loadGoodsListData];
        }];
    }
    return _table;
}

- (SDCycleScrollView*)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect frame = CGRectMake(0, 0, DEVICEWIDTH, 103*RATIO_WIDHT320);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
        _cycleScrollView.imageURLStringsGroup = @[@"http://5b0988e595225.cdn.sohucs.com/images/20170710/90d013a24bc043f9bc27f9604c8b77bc.png",
                                                 @"http://pic1.win4000.com/wallpaper/2017-12-19/5a387cb8439ea.jpg",
                                                 @"http://pic97.huitu.com/res/20160724/976_20160724152045497500_1.jpg"];
    }
    return _cycleScrollView;
}
@end
