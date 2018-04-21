//
//  VCLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/5.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCLogin.h"
#import "VCMain.h"
#import "AppDelegate.h"
#import "VCProxy.h"
#import "RequestBeanLogin.h"
#import "VCForgotPwd.h"
#import "WindowGuide.h"
static NSString* const CFBundleVersion = @"CFBundleVersion";

@interface VCLogin ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *ivLogo;
@property(nonatomic,strong)UIImageView *ivBg;
@property(nonatomic,strong)UIImageView *ivUser;
@property(nonatomic,strong)UITextField *tfUser;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIImageView *ivPwd;
@property(nonatomic,strong)UITextField *tfPwd;
@property(nonatomic,strong)UIView *vTwoLine;
@property(nonatomic,strong)UIImageView *ivLogin;
@property(nonatomic,strong)UIButton *btnForgot;
@end

@implementation VCLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
//    WindowGuide *guide = [[WindowGuide alloc]init];
//    [guide show];
//    save_current_version();
    
     if ([current_version() compare:prev_version()] == NSOrderedDescending) {
         WindowGuide *guide = [[WindowGuide alloc]init];
         [guide show];
         save_current_version();
     }
    
    
    [self.view addSubview:self.ivBg];
    [self.view addSubview:self.ivLogo];
    [self.view addSubview:self.ivUser];
    [self.view addSubview:self.tfUser];
    [self.view addSubview:self.vLine];
    [self.view addSubview:self.ivPwd];
    [self.view addSubview:self.tfPwd];
    [self.view addSubview:self.vTwoLine];
    [self.view addSubview:self.ivLogin];
    [self.view addSubview:self.btnForgot];
    
//    self.tfUser.text = @"wr";
//    self.tfPwd.text = @"123456";
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)clickAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if(tag == 101){
        VCForgotPwd *vc = [[VCForgotPwd alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)loginEvent{
    [self.view endEditing:YES];
    NSString *userName = [self.tfUser.text trim];
    NSString *tfPwd = [self.tfPwd.text trim];
    
    if(userName.length == 0){
        [Utils showToast:@"请输入手机号码" with:self.view withTime:0.8];
        return;
    }
    if(userName.length < 2){
        [Utils showToast:@"手机号码错误" with:self.view withTime:0.8];
        return;
    }
    if(tfPwd.length == 0){
        [Utils showToast:@"请输入密码" with:self.view withTime:0.8];
        return;
    }
    if(tfPwd.length < 6){
        [Utils showToast:@"密码小于6位" with:self.view withTime:0.8];
        return;
    }
    
    RequestBeanLogin *requestBean = [RequestBeanLogin new];
    requestBean.userName = userName;
    requestBean.passWord = tfPwd;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if(!err){
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.2 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // 结果处理
                ResponseBeanLogin *response = responseBean;
                if(response.success){
                    [Utils hiddenHanding:self.view withTime:0.5];
                    //存信息到沙盒
                    [Utils saveUserInfo:response.data];
                    //解析数据
                    [[AppUser share] parse:response.data];
                    
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    
                    if([AppUser share].isSalesman){
                        VCProxy *vc = [[VCProxy alloc]init];
                        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                        [appDelegate restoreRootViewController:nav];
                    }else{
                        VCMain *vc = [[VCMain alloc]init];
                        [appDelegate restoreRootViewController:vc];
                    }
                }
            });
        }else{
            ResponseBeanLogin *response = responseBean;
            if(response && response.msg){
                [Utils showSuccessToast:response.msg with:weakself.view withTime:0.8];
            }else{
                [Utils showSuccessToast:@"登录失败" with:weakself.view withTime:0.8];
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
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}


- (void)viewWillLayoutSubviews{
    CGRect r = self.ivLogo.frame;
    r.size.width = 90*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = (DEVICEWIDTH - r.size.width)/2.0;
    r.origin.y = 90*RATIO_WIDHT320;
    self.ivLogo.frame = r;
    
    r = self.ivBg.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 185*RATIO_WIDHT320;
    r.origin.x = 0;
    r.origin.y = DEVICEHEIGHT - r.size.height;
    self.ivBg.frame = r;
    
    r = self.ivUser.frame;
    r.size.width = 12*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 16;
    r.origin.y = self.ivLogo.bottom +  40*RATIO_WIDHT320;
    self.ivUser.frame = r;
    
    r = self.tfUser.frame;
    r.size.width = DEVICEWIDTH - 32 - 12*RATIO_WIDHT320 - 40;
    r.size.height = 30*RATIO_WIDHT320;
    r.origin.x = self.ivUser.right + 20;
    r.origin.y = self.ivUser.top + (self.ivUser.height - r.size.height)/2.0;
    self.tfUser.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH - 32;
    r.size.height = 0.5;
    r.origin.x = 16;
    r.origin.y = self.ivUser.bottom +  15*RATIO_WIDHT320;
    self.vLine.frame = r;
    
    r = self.ivPwd.frame;
    r.size.width = 12*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 16;
    r.origin.y = self.vLine.bottom +  20*RATIO_WIDHT320;
    self.ivPwd.frame = r;
    
    r = self.tfPwd.frame;
    r.size.width = DEVICEWIDTH - 32 - 12*RATIO_WIDHT320 - 40;
    r.size.height = 30*RATIO_WIDHT320;
    r.origin.x = self.ivPwd.right + 20;
    r.origin.y = self.ivPwd.top + (self.ivPwd.height - r.size.height)/2.0;
    self.tfPwd.frame = r;
    
    r = self.vTwoLine.frame;
    r.size.width = DEVICEWIDTH - 32;
    r.size.height = 0.5;
    r.origin.x = 16;
    r.origin.y = self.ivPwd.bottom +  15*RATIO_WIDHT320;
    self.vTwoLine.frame = r;
    
    r = self.ivLogin.frame;
    r.size.width = DEVICEWIDTH - 32;
    r.size.height = 45*RATIO_WIDHT320;
    r.origin.x = 16;
    r.origin.y = self.vTwoLine.bottom +  40*RATIO_WIDHT320;
    self.ivLogin.frame = r;
    
    CGSize size = [self.btnForgot.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.btnForgot.frame;
    r.origin.x = DEVICEWIDTH - size.width - 21;
    r.origin.y = self.ivLogin.bottom + 15*RATIO_WIDHT320;
    r.size = size;
    self.btnForgot.frame = r;
}


- (UIImageView*)ivBg{
    if (!_ivBg) {
        _ivBg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivBg.image = [UIImage imageNamed:@"Sign-in-bg_"];
    }
    return _ivBg;
}

- (UIImageView*)ivLogo{
    if (!_ivLogo) {
        _ivLogo = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivLogo.image = [UIImage imageNamed:@"logo"];
    }
    return _ivLogo;
}

- (UIImageView*)ivUser{
    if (!_ivUser) {
        _ivUser = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivUser.image = [UIImage imageNamed:@"Sign-in-icon_user"];
    }
    return _ivUser;
}

- (UITextField*)tfUser{
    if (!_tfUser) {
        _tfUser = [[UITextField alloc]initWithFrame:CGRectZero];
        _tfUser.placeholder = @"请输入手机号码";
        _tfUser.delegate = self;
        _tfUser.keyboardType = UIKeyboardTypePhonePad;
    }
    return _tfUser;
}

- (UIView*)vLine{
    if (!_vLine) {
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(232);
    }
    return _vLine;
}

- (UIImageView*)ivPwd{
    if (!_ivPwd) {
        _ivPwd = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivPwd.image = [UIImage imageNamed:@"Sign-in-icon_Password"];
    }
    return _ivPwd;
}

- (UITextField*)tfPwd{
    if (!_tfPwd) {
        _tfPwd = [[UITextField alloc]initWithFrame:CGRectZero];
        _tfPwd.secureTextEntry = YES;
        _tfPwd.delegate = self;
        _tfPwd.placeholder = @"请输入登录密码";
    }
    return _tfPwd;
}

- (UIView*)vTwoLine{
    if (!_vTwoLine) {
        _vTwoLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vTwoLine.backgroundColor = RGB3(232);
    }
    return _vTwoLine;
}

- (UIImageView*)ivLogin{
    if (!_ivLogin) {
        _ivLogin = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivLogin.image = [UIImage imageNamed:@"Sign-in-icon_selected"];//Sign-in-icon_normal
        __weak typeof(self) weakself = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            [weakself loginEvent];
        }];
        _ivLogin.userInteractionEnabled = YES;
        [_ivLogin addGestureRecognizer:tap];
    }
    return _ivLogin;
}

- (UIButton*)btnForgot{
    if (!_btnForgot) {
        _btnForgot = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnForgot setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_btnForgot setTitleColor:RGB(114, 113, 113) forState:UIControlStateNormal];
        [_btnForgot addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnForgot.titleLabel.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _btnForgot.tag = 101;
    }
    return _btnForgot;
}

NS_INLINE
NSString* current_version(){
    return [NSString stringWithFormat:@"%@",[NSBundle mainBundle].infoDictionary[CFBundleVersion]];
}

NS_INLINE
NSString* prev_version(){
    return [NSString stringWithContentsOfFile:version_path() encoding:NSUTF8StringEncoding error:nil];
}

NS_INLINE
void save_current_version(){
    [current_version() writeToFile:version_path() atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

NS_INLINE
NSString* version_path(){
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Version.data"];;
}

@end
