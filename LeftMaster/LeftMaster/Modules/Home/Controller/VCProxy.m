//
//  VCProxy.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCProxy.h"
#import "VCMain.h"
#import "AppDelegate.h"
#import "CellProxy.h"
#import "RequestBeanCustomer.h"

@interface VCProxy ()<UITableViewDelegate,UITableViewDataSource,AJHubProtocol>
@property(nonatomic,strong)UIView *vBg;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIImageView *ivArrow;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIButton *btnConfirm;
@property(nonatomic,assign)BOOL expland;
@end

@implementation VCProxy

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.title = @"代理客户";
    self.lbName.text = @"客户 001";
    [self.view addSubview:self.vBg];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnConfirm];
}

- (void)clickAction:(UIButton*)sender{
    VCMain *vc = [[VCMain alloc]init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate restoreRootViewController:vc];
}


- (void)loadData{
    RequestBeanCustomer *requestBean = [RequestBeanCustomer new];
    requestBean.user_login_name = @"admin";
    requestBean.customer_name = @"李";
    requestBean.page_current = 1;
    [AJNetworkConfig shareInstance].hubDelegate = self;
    
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        
        if (!err) {
            // 结果处理
            ResponseBeanCustomer *response = responseBean;
            
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

- (void)viewWillLayoutSubviews{
    CGRect r = self.vBg.frame;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = 20*RATIO_WIDHT320 + NAV_STATUS_HEIGHT;
    r.size.width = DEVICEWIDTH - 40*RATIO_WIDHT320;
    r.size.height = 34*RATIO_WIDHT320;
    self.vBg.frame = r;
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, self.vBg.height)];
    r = self.lbName.frame;
    r.size = size;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.vBg.height - r.size.height)/2.0;
    self.lbName.frame = r;
    
    r = self.ivArrow.frame;
    r.size.width = 5*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.vBg.width - r.size.width - 5*RATIO_WIDHT320;
    r.origin.y = (self.vBg.height - r.size.height)/2.0;
    self.ivArrow.frame = r;
    
    r = self.table.frame;
    r.size.width = DEVICEWIDTH - 40*RATIO_WIDHT320;
    r.size.height = 170*RATIO_WIDHT320;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = self.vBg.bottom;
    self.table.frame = r;

    r = self.btnConfirm.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 40*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.vBg.bottom + 170*RATIO_WIDHT320 + 30*RATIO_WIDHT320;
    self.btnConfirm.frame = r;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellProxy calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellProxy";
    CellProxy *cell = (CellProxy*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellProxy alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.expland = !self.expland;
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.layer.borderColor = RGB3(224).CGColor;
        _table.layer.borderWidth = 0.5;
        _table.alpha = 0.f;
    }
    return _table;
}

- (UIView*)vBg{
    if(!_vBg){
        _vBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vBg.layer.borderColor = RGB3(224).CGColor;
        _vBg.layer.borderWidth = 0.5;
        [_vBg addSubview:self.lbName];
        [_vBg addSubview:self.ivArrow];
        __weak typeof(self) weakself = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            weakself.expland = !weakself.expland;
        }];
        
        [_vBg addGestureRecognizer:tap];
    }
    return _vBg;
}

- (void)setExpland:(BOOL)expland{
    _expland = expland;
    if(_expland){
        [UIView animateWithDuration:0.3 animations:^{
            self.table.alpha = 1.f;
        }];
        self.ivArrow.image = [UIImage imageNamed:@"icon_up_normal"];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.table.alpha = 0.f;
        }];
        self.ivArrow.image = [UIImage imageNamed:@"icon_down_normal"];
    }
}

- (UILabel*)lbName{
    if(!_lbName){
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = APP_COLOR;
        _lbName.userInteractionEnabled = YES;
    }
    return _lbName;
}

- (UIImageView*)ivArrow{
    if(!_ivArrow){
        _ivArrow = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivArrow.image = [UIImage imageNamed:@"icon_down_normal"];//icon_up_normal
        _ivArrow.userInteractionEnabled = YES;
    }
    return _ivArrow;
}

- (UIButton*)btnConfirm{
    if(!_btnConfirm){
        _btnConfirm = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        [_btnConfirm addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.backgroundColor = APP_COLOR;
        _btnConfirm.layer.cornerRadius = 6.f;
    }
    return _btnConfirm;
}
@end
