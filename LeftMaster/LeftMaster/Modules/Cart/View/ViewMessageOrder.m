//
//  ViewGoodsList.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewMessageOrder.h"

@interface ViewMessageOrder()

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIView *vListBg;
@property(nonatomic,strong)UITextView *tvText;

@end

@implementation ViewMessageOrder

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB(0, 0, 0);
        _lbTitle.text = @"给供货商留言(可选填)";
        [self addSubview:_lbTitle];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
        
        _tvText = [[UITextView alloc]initWithFrame:CGRectZero];
        _tvText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _tvText.textColor = RGB3(153);
        [self addSubview:_tvText];
        
        
    }
    return self;
}

- (void)updateData{
    self.tvText.text = @"请写留言，30字以内";
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
    
    r = self.tvText.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 42.5*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.vLine.bottom + 10*RATIO_WIDHT320;
    self.tvText.frame = r;
}

+ (CGFloat)calHeight{
    return 42.5*RATIO_WIDHT320 + 10*RATIO_WIDHT320 + 38*RATIO_WIDHT320 + 0.5;
}

@end

