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
#import "RequestBeanAddCart.h"
#import "CellGoods.h"

@interface VCGoods ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,ViewHeaderGoodsDelegate,CommonDelegate,
        UIWebViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewHeaderGoods *header;
@property(nonatomic,strong)UIWebView *footer;
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
}


- (void)loadData{
    RequestBeanGoodsDetail *requestBean = [RequestBeanGoodsDetail new];
    requestBean.goods_id = self.goods_id;
    requestBean.cus_id = [AppUser share].CUS_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanGoodsDetail *response = responseBean;
            weakself.data = response.data;
            [weakself installData];
            [weakself.table reloadData];
        }
    }];
}

- (void)addCart{
    RequestBeanAddCart *requestBean = [RequestBeanAddCart new];
    requestBean.goods_id = self.goods_id;
    requestBean.num = self.count;
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
       
        if (!err) {
            // 结果处理
            ResponseBeanAddCart *response = responseBean;
            if (response.success) {
                [self postNotification:REFRESH_CART_LIST withObject:nil];
                [Utils showSuccessToast:@"加入购物车成功" with:weakself.view withTime:1];
            }else{
                [Utils showSuccessToast:@"加入购物车失败" with:weakself.view withTime:1];
            }
        }else{
            [Utils showSuccessToast:@"加入购物车失败" with:weakself.view withTime:1];
        }
    }];
}

- (void)installData{
    if(self.data){
        
        NSString *html = [self.data jk_stringForKey:@"GOODS_INTRODUCTION"];
        [self.footer loadHTMLString:[self installHtml:html] baseURL:nil];
        
        self.cycleScrollView.imageURLStringsGroup = [self.data jk_arrayForKey:@"GOODS_PICS"];
        self.lbPicCount.text = [NSString stringWithFormat:@"%d/%zi",1,self.cycleScrollView.imageURLStringsGroup.count];
        if(self.cycleScrollView.imageURLStringsGroup.count > 0){
            self.lbPicCount.hidden = NO;
        }else{
            self.lbPicCount.hidden = YES;
        }
    }
}

- (NSString*)installHtml:(NSString*)content{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    
//        [html appendString:@"<meta name=\"viewport\" content=\"target-densitydpi=device-dpi,width=640,user-scalable=no\"/>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"style.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#ffffff\">"];
    [html appendString:content];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return html;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.data){
        return [CellGoods calHeight:[self.data jk_arrayForKey:@"GOODS_PARAMJSON"]];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"Cell";
    CellGoods *cell = (CellGoods*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellGoods alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(self.data){
        cell.dataSouce = [self.data jk_arrayForKey:@"GOODS_PARAMJSON"];
    }
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

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if(self.data){
        NSInteger type = [self.data jk_integerForKey:@"OPER_TYPE"];{
            if(type == 0){
                [Utils showSuccessToast:@"您不具备该商品购买权限，请联系左师傅" with:self.view withTime:1];
            }else{
                if (index == 0) {
                    self.bottom.count = self.count;
                    [self.bottom startAnimation];
                    //调用加入购物车接口
                    [self addCart];
                }else{
                    
                }
            }
        }
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat  htmlHeight = [[self.footer stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"]floatValue];
    CGRect r = self.footer.frame;
    r.size.height = htmlHeight;
    self.footer.frame = r;
    self.table.tableFooterView = self.footer;
    [self.table reloadData];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-[ViewBtnGoods calHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.cycleScrollView;
    }
    return _table;
}

- (ViewHeaderGoods*)header{
    if(!_header){
        _header = [[ViewHeaderGoods alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _header;
}

- (UIWebView*)footer{
    if(!_footer){
        _footer = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 100)];
        _footer.delegate = self;
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
        _lbPicCount.hidden = YES;
    }
    return _lbPicCount;
}


- (SDCycleScrollView*)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect frame = CGRectMake(0, 0, DEVICEWIDTH, 320*RATIO_WIDHT320);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.showPageControl = NO;
        [_cycleScrollView addSubview:self.lbPicCount];
        _cycleScrollView.autoScroll = NO;
    }
    return _cycleScrollView;
}

- (ViewBtnGoods*)bottom{
    if(!_bottom){
        _bottom = [[ViewBtnGoods alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewBtnGoods calHeight], DEVICEWIDTH,[ViewBtnGoods calHeight])];
        _bottom.delegate = self;
        [_bottom updateData];
    }
    return _bottom;
}
@end
