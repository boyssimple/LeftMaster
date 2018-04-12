//
//  VCForgotPwd.m
//  LeftMaster
//
//  Created by simple on 2018/4/12.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCForgotPwd.h"

@interface VCForgotPwd ()
@property (nonatomic, strong) UILabel *lbText;
@property (nonatomic, strong) UILabel *lbPhone;
@property (nonatomic, strong) UIButton *btnBack;
@end

@implementation VCForgotPwd

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"密码初始化";
    [self.view addSubview:self.lbText];
    [self.view addSubview:self.lbPhone];
    [self.view addSubview:self.btnBack];
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}


- (void)clickAction:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillLayoutSubviews{
    CGSize size = [self.lbText sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
    CGRect r = self.lbText.frame;
    r.size.height = size.height;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 20*RATIO_WIDHT320 +NAV_STATUS_HEIGHT;
    self.lbText.frame = r;
    
    size = [self.lbPhone sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbPhone.frame;
    r.size.height = size.height;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbText.bottom + 10*RATIO_WIDHT320;
    self.lbPhone.frame = r;
    
    r = self.btnBack.frame;
    r.size.height = 45*RATIO_WIDHT320;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbPhone.bottom + 60*RATIO_WIDHT320;
    self.btnBack.frame = r;
}

- (UILabel*)lbText{
    if(!_lbText){
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbText.textColor = RGB3(0);
        _lbText.text = @"请联系左师傅客服进行密码初始化";
    }
    return _lbText;
}

- (UILabel*)lbPhone{
    if(!_lbPhone){
        _lbPhone = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPhone.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbPhone.textColor = RGB3(0);
        _lbPhone.text = @"客服电话：400-7003088";
    }
    return _lbPhone;
}

- (UIButton*)btnBack{
    if(!_btnBack){
        _btnBack = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnBack setTitle:@"返回登录" forState:UIControlStateNormal];
        [_btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnBack addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnBack.backgroundColor = APP_COLOR;
        _btnBack.layer.cornerRadius = 3.f;
    }
    return _btnBack;
}

@end
