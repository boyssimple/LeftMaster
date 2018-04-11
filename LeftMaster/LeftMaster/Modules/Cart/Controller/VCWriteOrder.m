//
//  VCWriteOrder.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCWriteOrder.h"
#import "ViewGoodsList.h"
#import "ViewMessageOrder.h"
#import "ViewTotalOrder.h"
#import "ViewTotalBottomWriteOrder.h"

@interface VCWriteOrder ()
@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)ViewGoodsList *vGoodsList;
@property(nonatomic,strong)ViewMessageOrder *vMsgOrder;
@property(nonatomic,strong)ViewTotalOrder *vTotalOrder;
@property(nonatomic,strong)ViewTotalBottomWriteOrder *vTotalControl;
@end

@implementation VCWriteOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"填写订单";
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.vGoodsList];
    [self.mainView addSubview:self.vMsgOrder];
    [self.mainView addSubview:self.vTotalOrder];
    
    [self.view addSubview:self.vTotalControl];
}

- (UIScrollView*)mainView{
    if (!_mainView) {
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT - [ViewTotalBottomWriteOrder calHeight])];
        _mainView.backgroundColor = APP_Gray_COLOR;
    }
    return _mainView;
}

- (ViewGoodsList*)vGoodsList{
    if (!_vGoodsList) {
        _vGoodsList = [[ViewGoodsList alloc]initWithFrame:CGRectMake(0, 10*RATIO_WIDHT320, DEVICEWIDTH, [ViewGoodsList calHeight])];
        [_vGoodsList updateData];
    }
    return _vGoodsList;
}

- (ViewMessageOrder*)vMsgOrder{
    if (!_vMsgOrder) {
        _vMsgOrder = [[ViewMessageOrder alloc]initWithFrame:CGRectMake(0, self.vGoodsList.bottom + 8*RATIO_WIDHT320, DEVICEWIDTH, [ViewMessageOrder calHeight])];
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
        [_vTotalControl updateData];
    }
    return _vTotalControl;
}


@end
