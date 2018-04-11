//
//  ViewHeaderMine.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewHeaderMine.h"
#import "ViewBtnHeaderMine.h"
#import "VCOrderList.h"
#import "VCSetPassword.h"

@interface ViewHeaderMine()
@property(nonatomic,strong)UIImageView *ivBg;
@property(nonatomic,strong)UIImageView *ivLogo;
@property(nonatomic,strong)UILabel *lbCompany;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIButton *btnModifyPwd;

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIButton *btnAll;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)ViewBtnHeaderMine *vAudution;
@property(nonatomic,strong)ViewBtnHeaderMine *vUnSend;
@property(nonatomic,strong)ViewBtnHeaderMine *vUnReceive;
@end
@implementation ViewHeaderMine

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _ivBg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivBg.image = [UIImage imageNamed:@"me_bg"];
        _ivBg.userInteractionEnabled = YES;
        [self addSubview:_ivBg];
        
        _ivLogo = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivLogo.image = [UIImage imageNamed:@"logo"];
        _ivLogo.userInteractionEnabled = YES;
        _ivLogo.layer.borderColor = RGB(206, 2, 206).CGColor;
        _ivLogo.layer.borderWidth = 1.f;
        _ivLogo.layer.cornerRadius = 25*RATIO_WIDHT320;
        _ivLogo.backgroundColor = [UIColor whiteColor];
        _ivLogo.clipsToBounds = YES;
        [_ivBg addSubview:_ivLogo];
        
        _lbCompany = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCompany.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbCompany.textColor = [UIColor whiteColor];
        [_ivBg addSubview:_lbCompany];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbName.textColor = [UIColor whiteColor];
        [_ivBg addSubview:_lbName];
        
        _btnModifyPwd = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnModifyPwd setTitle:@"修改密码" forState:UIControlStateNormal];
        [_btnModifyPwd setTitleColor:APP_COLOR forState:UIControlStateNormal];
        _btnModifyPwd.titleLabel.font = [UIFont boldSystemFontOfSize:10*RATIO_WIDHT320];
        _btnModifyPwd.tag = 100;
        [_btnModifyPwd addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnModifyPwd.backgroundColor = [UIColor whiteColor];
        [_ivBg addSubview:_btnModifyPwd];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB3(51);
        _lbTitle.text = @"我的订单";
        [self addSubview:_lbTitle];
        
        _btnAll = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnAll setTitle:@"全部订单" forState:UIControlStateNormal];
        [_btnAll setImage:[UIImage imageNamed:@"home_news_more"] forState:UIControlStateNormal];
        [_btnAll setTitleColor:RGB3(102) forState:UIControlStateNormal];
        _btnAll.titleLabel.font = [UIFont boldSystemFontOfSize:10*RATIO_WIDHT320];
        _btnAll.tag = 101;
        [_btnAll addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnAll];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
        
        
        _vAudution = [[ViewBtnHeaderMine alloc]initWithFrame:CGRectZero];
        [_vAudution updateData:@"me_icon_1" with:@"待审核"];
        [self addSubview:_vAudution];
        
        _vUnSend = [[ViewBtnHeaderMine alloc]initWithFrame:CGRectZero];
        [_vUnSend updateData:@"me_icon_2" with:@"待发货"];
        [self addSubview:_vUnSend];
        
        _vUnReceive = [[ViewBtnHeaderMine alloc]initWithFrame:CGRectZero];
        [_vUnReceive updateData:@"me_icon_3" with:@"待收货"];
        [self addSubview:_vUnReceive];
    }
    return self;
}

- (void)updateData{
    self.lbCompany.text = @"重庆XX菲斯机械有限公司";
    self.lbName.text = @"罗先生";
    [self.vUnReceive update:8];
}

- (void)clickAction:(UIButton*)sender{
    if(sender.tag == 100){
        VCSetPassword *vc = [[VCSetPassword alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        VCOrderList *vc = [[VCOrderList alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivBg.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.width;
    r.size.height = 100*RATIO_WIDHT320;
    self.ivBg.frame = r;
    
    r = self.ivLogo.frame;
    r.size.width = 50*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.ivBg.height - r.size.height)/2.0;
    self.ivLogo.frame = r;
    
    CGSize size = [self.lbCompany sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbCompany.frame;
    r.origin.x = self.ivLogo.right + 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size = size;
    self.lbCompany.frame = r;
    
    size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbName.frame;
    r.origin.x = self.ivLogo.right + 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size = size;
    self.lbName.frame = r;
    
    self.lbCompany.top = self.ivLogo.top + (self.ivLogo.height-(self.lbCompany.height + 10*RATIO_WIDHT320 + self.lbName.height))/2.0;
    self.lbName.top = self.lbCompany.bottom + 10*RATIO_WIDHT320;
    
    
    r = self.btnModifyPwd.frame;
    r.size.width = 50*RATIO_WIDHT320;
    r.size.height = 18*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.ivBg.height - r.size.height)/2.0;
    self.btnModifyPwd.frame = r;
    
    size = [self.lbTitle sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
    r = self.lbTitle.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.ivBg.bottom + 12*RATIO_WIDHT320;
    r.size = size;
    self.lbTitle.frame = r;
    
    size = [self.btnAll.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.btnAll.frame;
    r.size.width = size.width + 10*RATIO_WIDHT320;
    r.size.height = self.lbTitle.height + 24*RATIO_WIDHT320;
    r.origin.y = self.ivBg.bottom;
    r.origin.x = self.width - r.size.width - 10*RATIO_WIDHT320;
    self.btnAll.frame = r;
    
    r = self.btnAll.imageView.frame;
    r.size.width = 10*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnAll.imageView.frame = r;
    
    [self.btnAll setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btnAll.imageView.size.width, 0, self.btnAll.imageView.size.width)];
    [self.btnAll setImageEdgeInsets:UIEdgeInsetsMake(0, size.width, 0, -size.width)];

    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.lbTitle.bottom + 12*RATIO_WIDHT320;
    self.vLine.frame = r;
    
    CGFloat w = DEVICEWIDTH / 3.0;
    r = self.vAudution.frame;
    r.size.width = w;
    r.size.height = [ViewBtnHeaderMine calHeight];
    r.origin.x = 0;
    r.origin.y = self.vLine.bottom;
    self.vAudution.frame = r;
    
    r = self.vUnSend.frame;
    r.size.width = w;
    r.size.height = [ViewBtnHeaderMine calHeight];
    r.origin.x = self.vAudution.right;
    r.origin.y = self.vLine.bottom;
    self.vUnSend.frame = r;
    
    r = self.vUnReceive.frame;
    r.size.width = w;
    r.size.height = [ViewBtnHeaderMine calHeight];
    r.origin.x = self.vUnSend.right;
    r.origin.y = self.vLine.bottom;
    self.vUnReceive.frame = r;
}

+ (CGFloat)calHeight{
    return 100*RATIO_WIDHT320 + 38*RATIO_WIDHT320 + 0.5 + [ViewBtnHeaderMine calHeight];
}

@end
