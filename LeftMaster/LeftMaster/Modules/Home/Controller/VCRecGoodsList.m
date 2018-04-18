//
//  VCCategory.m
//  LeftMaster
//
//  Created by simple on 2018/4/3.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCRecGoodsList.h"
#import "CellRecGoodsList.h"
#import "ViewCategory.h"
#import "HMScannerController.h"
#import "RequestBeanCategoryHome.h"
#import "RequestBeanGoodsList.h"
#import "VCGoods.h"
#import "ViewOrderRecGoodsList.h"

@interface VCRecGoodsList ()<UITableViewDelegate,UITableViewDataSource,ViewCategoryDelegate,AJHubProtocol,UITextFieldDelegate,CommonDelegate,CellRecGoodsListDelegate>
@property(nonatomic,strong)ViewCategory *vCart;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewOrderRecGoodsList *viewOrder;
@property(nonatomic,strong)NSMutableArray *categorys;
@property(nonatomic,strong)NSString *keywords;
@property (nonatomic, assign) NSInteger page;
@end

@implementation VCRecGoodsList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
//    [self loadData];
}

- (void)initMain{
    self.title = @"新品推荐";
    self.view.backgroundColor = RGB3(247);
    _categorys = [NSMutableArray array];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 44)];
    view.backgroundColor = [UIColor redColor];
//    self.navigationItem.titleView = self.vCart;
//    [self.view addSubview:self.vCart];
    
    [self.view addSubview:self.vCart];
    [self.view addSubview:self.viewOrder];
    [self.view addSubview:self.table];
}


- (void)loadData{
    RequestBeanCategoryHome *requestBean = [RequestBeanCategoryHome new];
    requestBean.parent_id = 0;
    requestBean.page_current = 1;
    requestBean.page_size = 100;
    if(self.keywords && self.keywords.length > 0){
        requestBean.search_name = self.keywords;
    }else{
        requestBean.search_name = nil;
    }
    [AJNetworkConfig shareInstance].hubDelegate = self;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        
        if (!err) {
            // 结果处理
            ResponseBeanCategoryHome *response = responseBean;
            [weakself.categorys removeAllObjects];
            [weakself.categorys addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
            [weakself.table reloadData];
        }
    }];
}

- (void)search{
    self.keywords = self.vCart.tfText.text;
    [self loadData];
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
//    return self.goodsList.count;
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellRecGoodsList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellRecGoodsList";
    CellRecGoodsList *cell = (CellRecGoodsList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellRecGoodsList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
        cell.joinCartDelegate = self;
    }
//    NSDictionary *data = [self.goodsList objectAtIndex:indexPath.row];
//    [cell updateData:data];
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
        footer.backgroundColor = APP_Gray_COLOR;
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VCGoods *vc = [[VCGoods alloc]init];
    vc.goods_id = @"674993773267021824";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (CGFloat)topHeight{
    return NAV_STATUS_HEIGHT + [ViewCategory calHeight] + 10*RATIO_WIDHT320;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self search];
    return YES;
}

#pragma mark ViewCategoryDelegate
- (void)clickQR{
    // 实例化控制器，并指定完成回调
    HMScannerController *scanner = [HMScannerController scannerWithCardName:@"" avatar:nil completion:^(NSString *stringValue) {
        
        //        self.scanResultLabel.text = stringValue;
    }];
    
    // 设置导航标题样式
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    
    // 展现扫描控制器
    [self showDetailViewController:scanner sender:nil];
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if (index == 0) {
        [Utils showSuccessToast:@"加入购物车成功" with:self.view withTime:1];
    }
}

#pragma mark - CellRecGoodsListDelegate
- (void)joinCartClick:(CGRect)r withNum:(NSInteger)num{
    self.vCart.count = num;
    [self.vCart startAnimation];
    [Utils showSuccessToast:@"加入购物车成功" with:self.view withTime:1];
}

- (ViewCategory*)vCart{
    if(!_vCart){
        _vCart = [[ViewCategory alloc]initWithFrame:CGRectMake(0, NAV_STATUS_HEIGHT, DEVICEWIDTH, [ViewCategory calHeight])];
        _vCart.delegate = self;
        _vCart.tfText.delegate = self;
        _vCart.tfText.returnKeyType = UIReturnKeySearch;
        [_vCart updateData];
    }
    return _vCart;
}


- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.viewOrder.bottom, DEVICEWIDTH, DEVICEHEIGHT-[ViewOrderRecGoodsList calHeight] - NAV_STATUS_HEIGHT - [ViewCategory calHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor whiteColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        /*
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakself.page = 1;
            [weakself loadData];
        }];
        [_table.mj_header beginRefreshing];
        
        _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakself.page++;
            [weakself loadData];
        }];
        */
    }
    return _table;
}

- (ViewOrderRecGoodsList*)viewOrder{
    if(!_viewOrder){
        _viewOrder = [[ViewOrderRecGoodsList alloc]initWithFrame:CGRectMake(0, self.vCart.bottom, DEVICEWIDTH, [ViewOrderRecGoodsList calHeight])];
    }
    return _viewOrder;
}

@end

