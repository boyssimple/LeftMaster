//
//  ViewGoodsList.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewISBill.h"

@interface ViewISBill()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIView *vBg;

@property(nonatomic,strong)UILabel *lbIsBill;
@property(nonatomic,strong)UIButton *btnYes;
@property(nonatomic,strong)UIButton *btnNo;
@property(nonatomic,strong)UILabel *lbYes;
@property(nonatomic,strong)UILabel *lbNo;

@end

@implementation ViewISBill

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB(0, 0, 0);
        _lbTitle.text = @"是否开具发票";
        [self addSubview:_lbTitle];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
        
        _vBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vBg.backgroundColor = RGB3(252);
        [self addSubview:_vBg];
        
        _lbIsBill = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbIsBill.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbIsBill.textColor = RGB(0, 0, 0);
        _lbIsBill.text = @"是否开具发票";
        [_vBg addSubview:_lbIsBill];
        
        _btnYes = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnYes setImage:[UIImage imageNamed:@"order_check_normal"] forState:UIControlStateNormal];
        [_btnYes setImage:[UIImage imageNamed:@"order_check_selected"] forState:UIControlStateSelected];
        [_btnYes addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnYes.tag = 100;
        [_vBg addSubview:_btnYes];
        
        _btnNo = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnNo setImage:[UIImage imageNamed:@"order_check_normal"] forState:UIControlStateNormal];
        [_btnNo setImage:[UIImage imageNamed:@"order_check_selected"] forState:UIControlStateSelected];
        [_btnNo addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnNo.tag = 101;
        [_vBg addSubview:_btnNo];
        
        _lbYes = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbYes.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbYes.textColor = RGB3(51);
        _lbYes.text = @"是";
        [_vBg addSubview:_lbYes];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNo.textColor = RGB3(51);//153
        _lbNo.text = @"否";
        [_vBg addSubview:_lbNo];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    self.btnYes.selected = FALSE;
    self.btnNo.selected = FALSE;
    self.lbYes.textColor = RGB3(153);
    self.lbNo.textColor = RGB3(153);
    if(sender.tag == 100){
        self.btnYes.selected = TRUE;
        self.lbYes.textColor = RGB3(51);
    }else{
        self.btnNo.selected = TRUE;
        self.lbNo.textColor = RGB3(51);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)updateData{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbTitle.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 12*RATIO_WIDHT320;
    r.size.width = self.width - 20*RATIO_WIDHT320;
    r.size.height = 14*RATIO_WIDHT320;
    self.lbTitle.frame = r;
    
    r = self.vLine.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbTitle.bottom + 12*RATIO_WIDHT320;
    r.size.width = self.width - 20*RATIO_WIDHT320;
    r.size.height = 0.5;
    self.vLine.frame = r;
    
    r = self.vBg.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = self.height - self.vLine.bottom;
    r.origin.x = 0;
    r.origin.y = self.vLine.bottom;
    self.vBg.frame = r;
    
    CGSize size = [self.lbIsBill sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbIsBill.frame;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    r.size.width = size.width;
    r.size.height = size.height;
    self.lbIsBill.frame = r;
    
    r = self.btnYes.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.lbIsBill.right;
    r.origin.y = self.lbIsBill.top + (self.lbIsBill.height - self.btnYes.height)/2.0;
    self.btnYes.frame = r;
    
    size = [self.lbYes sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbYes.frame;
    r.origin.x = self.btnYes.right + 10*RATIO_WIDHT320;
    r.origin.y = self.btnYes.top + (self.btnYes.height - size.height)/2.0;
    r.size = size;
    self.lbYes.frame = r;
    
    r = self.btnNo.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.lbYes.right + 20*RATIO_WIDHT320;
    r.origin.y = self.btnYes.bottom + 10*RATIO_WIDHT320;
    self.btnNo.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.origin.x = self.btnNo.right + 10*RATIO_WIDHT320;
    r.origin.y = self.btnNo.top + (self.btnNo.height - size.height)/2.0;
    r.size = size;
    self.lbNo.frame = r;
}

+ (CGFloat)calHeight{
    return 40.5*RATIO_WIDHT320 + 70*RATIO_WIDHT320;
}

@end

