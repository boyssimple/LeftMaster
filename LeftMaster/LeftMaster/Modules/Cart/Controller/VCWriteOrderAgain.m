//
//  VCWriteOrder.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCWriteOrderAgain.h"
#import "ViewGoodsList.h"
#import "ViewMessageOrder.h"
#import "ViewTotalOrder.h"
#import "ViewTotalBottomWriteOrder.h"
#import "ViewISBill.h"
#import "RequestBeanBillOrg.h"
#import "WindowCustom.h"
#import "Custom.h"
#import "CartGoods.h"
#import "RequestBaseAddOrder.h"
#import "RequestBeanOrderGoodsList.h"
#import "VCEditGoodList.h"

@interface VCWriteOrderAgain ()<CommonDelegate,WindowCustomDelegate,UIScrollViewDelegate,ViewTotalBottomWriteOrderDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)ViewGoodsList *vGoodsList;
@property(nonatomic,strong)ViewISBill *vBill;
@property(nonatomic,strong)ViewMessageOrder *vMsgOrder;
@property(nonatomic,strong)ViewTotalOrder *vTotalOrder;
@property(nonatomic,strong)ViewTotalBottomWriteOrder *vTotalControl;
@property(nonatomic,strong)WindowCustom *customView;
@property(nonatomic,strong)Custom *cust;
@property(nonatomic,assign)BOOL isBill;
@property(nonatomic,assign)CGFloat totalPrice;
@property(nonatomic,strong)NSString *remark;

@property(nonatomic,strong)NSMutableArray *goodsList;
@end

@implementation VCWriteOrderAgain

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadCustom];
    [self loadData];
}

- (void)initMain{
    self.title = @"填写订单";
    _goodsList = [NSMutableArray array];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.vGoodsList];
    [self.mainView addSubview:self.vBill];
    [self.mainView addSubview:self.vMsgOrder];
    [self.mainView addSubview:self.vTotalOrder];
    
    [self.view addSubview:self.vTotalControl];
}

- (void)loadData{
    RequestBeanOrderGoodsList *requestBean = [RequestBeanOrderGoodsList new];
    requestBean.page_current = 1;
    requestBean.FD_ORDER_ID = self.orderId;
    requestBean.page_size = 1000;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanOrderGoodsList *response = responseBean;
            if(response.success){
                [weakself.goodsList removeAllObjects];
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                for (NSDictionary *data in datas) {
                    CartGoods *c = [[CartGoods alloc]init];
                    c.GOODS_PIC = [data jk_stringForKey:@"GOODS_PIC"];
                    c.FD_NUM = [data jk_integerForKey:@"FD_NUM"];
                    c.GOODS_PRICE = [data jk_stringForKey:@"FD_UNIT_PRICE"];
                    c.GOODS_UNIT = [data jk_stringForKey:@"FD_UNIT_NAME"];
                    c.GOODS_NAME = [data jk_stringForKey:@"GOODS_NAME"];
                    [weakself.goodsList addObject:c];
                }
                [weakself installData];
                
            }
        }
    }];
}

- (void)loadCustom{
    RequestBeanBillOrg *requestBean = [RequestBeanBillOrg new];
    requestBean.cus_id = [AppUser share].CUS_ID;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanBillOrg *response = responseBean;
            if(response.success){
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                NSMutableArray *customs = [NSMutableArray array];
                for (NSDictionary *data in datas) {
                    Custom *custom = [[Custom alloc]init];
                    [custom parse:data];
                    if(custom.fd_default){
                        weakself.cust = custom;
                        [weakself.vBill updateData:custom];
                    }
                    [customs addObject:custom];
                }
            }
        }
    }];
}

- (void)installData{
    
    for (CartGoods *g in self.goodsList) {
        self.totalPrice += g.FD_NUM * [g.GOODS_PRICE floatValue];
    }
    
    [self.vTotalOrder updateData:self.totalPrice];
    [self.vTotalControl updateData:self.totalPrice];
    self.vGoodsList.dataSource = _goodsList;
    
}

- (void)refreshCustom{
    RequestBeanBillOrg *requestBean = [RequestBeanBillOrg new];
    requestBean.cus_id = [AppUser share].CUS_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:weakself.view withTime:0.2];
        if (!err) {
            // 结果处理
            ResponseBeanBillOrg *response = responseBean;
            if(response.success){
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                NSMutableArray *customs = [NSMutableArray array];
                for (NSDictionary *data in datas) {
                    Custom *custom = [[Custom alloc]init];
                    [custom parse:data];
                    [customs addObject:custom];
                }
                weakself.customView = [[WindowCustom alloc]init:customs];
                weakself.customView.delegate = self;
                [weakself.customView show];
            }
        }
    }];
}

- (void)addOrderAction{
    RequestBaseAddOrder *requestBean = [RequestBaseAddOrder new];
    NSMutableDictionary *orderInfo = [[NSMutableDictionary alloc]init];
    [orderInfo setObject:[AppUser share].SYSUSER_ID forKey:@"FD_CREATE_USER_ID"];
    [orderInfo setObject:[AppUser share].CUS_ID forKey:@"FD_ORDER_ORG_ID"];
    [orderInfo setObject:[NSString stringWithFormat:@"%f",self.totalPrice] forKey:@"FD_TOTAL_PRICE"];
    NSMutableArray *goods = [[NSMutableArray alloc]init];
    for (CartGoods *g in self.goodsList) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:g.GOODS_ID forKey:@"FD_GOODS_ID"];
        [dic setObject:g.GOODS_NAME forKey:@"FD_GOODS_ID_LABELS"];
        [dic setObject:[NSString stringWithFormat:@"%zi",g.FD_NUM] forKey:@"FD_NUM"];
        [dic setObject:g.GOODS_PRICE forKey:@"FD_UNIT_PRICE"];
        [dic setObject:[NSString stringWithFormat:@"%f",g.FD_NUM * [g.GOODS_PRICE floatValue]] forKey:@"FD_TOTAL_PRICE"];
        [goods addObject:dic];
    }
    [orderInfo setObject:goods forKey:@"ORDER_DETAIL"];
    
    if (self.isBill) {
        if (!self.cust) {
            [Utils showSuccessToast:@"未选择开票单位" with:self.view withTime:0.8];
            return;
        }else{
            [orderInfo setObject:@(self.isBill) forKey:@"FD_NEED_TICKET"];
            [orderInfo setObject:self.cust.fd_bill_org_id forKey:@"FD_BILL_ORG_ID"];
        }
    }
    
    if(self.remark && self.remark.length > 0){
        [orderInfo setObject:self.remark forKey:@"FD_DESC"];
    }
    
    requestBean.oderInfo = [Utils dictToJsonStr:orderInfo];//[Utils dictToJsonStr:orderInfo];
    NSLog(@"结果:%@",requestBean.oderInfo);
    
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:weakself.view withTime:0.2];
        if (!err) {
            // 结果处理
            ResponseBeanAddOrder *response = responseBean;
            if(response.success){
                [Utils showSuccessToast:@"下单成功" with:self.view withTime:1];
                [self.navigationController popToRootViewControllerAnimated:TRUE];
                [self postNotification:REFRESH_CART_LIST withObject:nil];
            }
        }else{
            [Utils showSuccessToast:@"下单失败" with:self.view withTime:0.8];
            
        }
    }];
}

- (void)reloadDatas:(NSArray*)datas{
    [self.goodsList removeAllObjects];
    [self.goodsList addObjectsFromArray:datas];
    [self installData];
}

- (void)gotoEditGoodList{
    VCEditGoodList *vc = [[VCEditGoodList alloc]init];
    vc.superVC = self;
    vc.goodsList = [self.goodsList mutableCopy];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)changeAction:(id)sender{
    UITextField* target = (UITextField*)sender;
    self.remark = target.text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if(index == 0){
        [self refreshCustom];
    }else if(index == 1){
        self.isBill = TRUE;
    }else{
        self.isBill = FALSE;
    }
    
}

#pragma mark - WindowCustomDelegate
- (void)selectCustom:(Custom *)cust{
    self.cust = cust;
    [self.vBill updateData:self.cust];
}

#pragma mark - ViewTotalBottomWriteOrderDelegate
- (void)clickOrder{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定提交?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 100;
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [self addOrderAction];
        }
    }
}

- (UIScrollView*)mainView{
    if (!_mainView) {
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT - [ViewTotalBottomWriteOrder calHeight])];
        _mainView.backgroundColor = APP_Gray_COLOR;
        _mainView.alwaysBounceVertical = YES;
        _mainView.delegate = self;
    }
    return _mainView;
}

- (ViewGoodsList*)vGoodsList{
    if (!_vGoodsList) {
        _vGoodsList = [[ViewGoodsList alloc]initWithFrame:CGRectMake(0, 10*RATIO_WIDHT320, DEVICEWIDTH, [ViewGoodsList calHeight])];
        _vGoodsList.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoEditGoodList)];
        [_vGoodsList addGestureRecognizer:tap];
        [_vGoodsList updateData];
    }
    return _vGoodsList;
}

- (ViewISBill*)vBill{
    if (!_vBill) {
        _vBill = [[ViewISBill alloc]initWithFrame:CGRectMake(0, self.vGoodsList.bottom + 8*RATIO_WIDHT320, DEVICEWIDTH, [ViewISBill calHeight])];
        _vBill.delegate = self;
        [_vBill updateData];
    }
    return _vBill;
}

- (ViewMessageOrder*)vMsgOrder{
    if (!_vMsgOrder) {
        _vMsgOrder = [[ViewMessageOrder alloc]initWithFrame:CGRectMake(0, self.vBill.bottom + 8*RATIO_WIDHT320, DEVICEWIDTH, [ViewMessageOrder calHeight])];
        [_vMsgOrder.tfText addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    }
    return _vMsgOrder;
}

- (ViewTotalOrder*)vTotalOrder{
    if (!_vTotalOrder) {
        _vTotalOrder = [[ViewTotalOrder alloc]initWithFrame:CGRectMake(0, self.vMsgOrder.bottom + 8*RATIO_WIDHT320, DEVICEWIDTH, [ViewTotalOrder calHeight])];
        [_vTotalOrder updateData];
    }
    return _vTotalOrder;
}

- (ViewTotalBottomWriteOrder*)vTotalControl{
    if (!_vTotalControl) {
        _vTotalControl = [[ViewTotalBottomWriteOrder alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewTotalBottomWriteOrder calHeight], DEVICEWIDTH, [ViewTotalBottomWriteOrder calHeight])];
        _vTotalControl.delegate = self;
        [_vTotalControl updateData];
    }
    return _vTotalControl;
}

@end