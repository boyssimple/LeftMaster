//
//  VCGoods.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCGoods.h"
#import "SDCycleScrollView.h"
#import "ViewHeaderGoods.h"
#import "ViewBtnGoods.h"
#import "RequestBeanGoodsDetail.h"

@interface VCGoods ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,AJHubProtocol,ViewHeaderGoodsDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewHeaderGoods *header;
@property(nonatomic,strong)UIImageView *footer;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)UILabel *lbPicCount;
@property(nonatomic,strong)ViewBtnGoods *bottom;
@property(nonatomic,strong)NSDictionary *data;
@property (nonatomic, assign) NSInteger count;
@end

@implementation VCGoods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.title = @"商品详情";
    [self.view addSubview:self.table];
    [self.view addSubview:self.bottom];
    __weak typeof(self) weakself = self;
    [self.footer sd_setImageWithURL:[NSURL URLWithString:@"https://img20.360buyimg.com/vc/jfs/t8632/279/878329325/1975572/b6953b36/59b0bde0Nb1375bc3.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGSize size = image.size;
        CGFloat r = DEVICEWIDTH/size.width;
        if(DEVICEWIDTH < size.width){
            r = size.width /DEVICEWIDTH;
        }
        weakself.footer.height = size.height / r;
        weakself.table.tableFooterView = weakself.footer;
        [weakself.table reloadData];
    }];
}


- (void)loadData{
    RequestBeanGoodsDetail *requestBean = [RequestBeanGoodsDetail new];
    requestBean.goods_id = self.goods_id;
    [AJNetworkConfig shareInstance].hubDelegate = self;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        
        if (!err) {
            // 结果处理
            ResponseBeanGoodsDetail *response = responseBean;
            weakself.data = response.data;
            [weakself.table reloadData];
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
    return [UITableViewCell calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell updateData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [ViewHeaderGoods calHeight:self.data];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ViewHeaderGoods *header = (ViewHeaderGoods*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[ViewHeaderGoods alloc]init];
    }
    [header updateData:self.data];
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
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.lbPicCount.text = [NSString stringWithFormat:@"%zi/%zi",index+1,self.cycleScrollView.imageURLStringsGroup.count];
}

#pragma mark - ViewHeaderGoodsDelegate
- (void)minusCount{
    self.count--;
}

- (void)addCount{
    self.count++;
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-[ViewBtnGoods calHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.cycleScrollView;
        _table.tableFooterView = self.footer;
    }
    return _table;
}

- (ViewHeaderGoods*)header{
    if(!_header){
        _header = [[ViewHeaderGoods alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _header;
}

- (UIImageView*)footer{
    if(!_footer){
        _footer = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 0)];
    }
    return _footer;
}

- (UILabel*)lbPicCount{
    if(!_lbPicCount){
        _lbPicCount = [[UILabel alloc]initWithFrame:CGRectMake(DEVICEWIDTH - 30*RATIO_WIDHT320 - 10*RATIO_WIDHT320, 320*RATIO_WIDHT320 - 12*RATIO_WIDHT320 -5*RATIO_WIDHT320, 30*RATIO_WIDHT320, 12*RATIO_WIDHT320)];
        _lbPicCount.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbPicCount.textColor = RGB3(254);
        _lbPicCount.backgroundColor = RGB3(153);
        _lbPicCount.textAlignment = NSTextAlignmentCenter;
        _lbPicCount.layer.cornerRadius = _lbPicCount.height/2.0;
        _lbPicCount.layer.masksToBounds = YES;
    }
    return _lbPicCount;
}


- (SDCycleScrollView*)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect frame = CGRectMake(0, 0, DEVICEWIDTH, 320*RATIO_WIDHT320);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
        _cycleScrollView.imageURLStringsGroup = @[@"http://5b0988e595225.cdn.sohucs.com/images/20170710/90d013a24bc043f9bc27f9604c8b77bc.png",
                                                  @"http://pic1.win4000.com/wallpaper/2017-12-19/5a387cb8439ea.jpg",
                                                  @"http://pic97.huitu.com/res/20160724/976_20160724152045497500_1.jpg"];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.showPageControl = NO;
        [_cycleScrollView addSubview:self.lbPicCount];
        _cycleScrollView.autoScroll = NO;
        self.lbPicCount.text = [NSString stringWithFormat:@"%zi/%zi",1,_cycleScrollView.imageURLStringsGroup.count];
    }
    return _cycleScrollView;
}

- (ViewBtnGoods*)bottom{
    if(!_bottom){
        _bottom = [[ViewBtnGoods alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewBtnGoods calHeight], DEVICEWIDTH,[ViewBtnGoods calHeight])];
        [_bottom updateData];
    }
    return _bottom;
}
@end