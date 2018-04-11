//
//  ViewHeaderGoods.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewHeaderGoods.h"
@interface ViewHeaderGoods()
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UILabel *lbNoText;
@property(nonatomic,strong)UILabel *lbTopPrice;
@property(nonatomic,strong)UILabel *lbTopPriceText;
@property(nonatomic,strong)UILabel *lbRole;
@property(nonatomic,strong)UILabel *lbStatus;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UIView  *vCountBg;
@property(nonatomic,strong)UIButton *btnMinus;
@property(nonatomic,strong)UIButton *btnAdd;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,strong)UIView  *vLine;
@property(nonatomic,strong)UILabel *lbDetail;

@end

@implementation ViewHeaderGoods

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.numberOfLines = 0;
        [self addSubview:_lbName];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNo.textColor = RGB3(153);
        _lbNo.text = @"商品编码号";
        [self addSubview:_lbNo];
        
        _lbNoText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNoText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNoText.textColor = RGB3(51);
        [self addSubview:_lbNoText];
        
        _lbTopPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTopPrice.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbTopPrice.textColor = RGB3(153);
        _lbTopPrice.text = @"市场价";
        [self addSubview:_lbTopPrice];
        
        _lbTopPriceText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTopPriceText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbTopPriceText.textColor = RGB3(51);
        [self addSubview:_lbTopPriceText];
        
        
        _lbRole = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbRole.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbRole.textColor = RGB(255, 0, 0);
        [self addSubview:_lbRole];
        
        _lbStatus = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbStatus.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbStatus.textColor = RGB3(153);
        [self addSubview:_lbStatus];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbPrice.textColor = RGB(0, 0, 0);
        [self addSubview:_lbPrice];
        
        _vCountBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vCountBg.layer.borderColor = RGB3(197).CGColor;
        _vCountBg.layer.borderWidth = 0.5f;
        _vCountBg.layer.cornerRadius = 3.f;
        _vCountBg.layer.masksToBounds = YES;
        _vCountBg.clipsToBounds = YES;
        [self addSubview:_vCountBg];
        
        _btnMinus = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnMinus.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnMinus setTitle:@"-" forState:UIControlStateNormal];
        [_btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
        _btnMinus.tag = 103;
        [_btnMinus addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_vCountBg addSubview:_btnMinus];
        
        _btnAdd = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnAdd.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnAdd setTitle:@"+" forState:UIControlStateNormal];
        [_btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnAdd.tag = 104;
        [_btnAdd addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_vCountBg addSubview:_btnAdd];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbCount.textColor = RGB(0, 0, 0);
        _lbCount.textAlignment = NSTextAlignmentCenter;
        _lbCount.text = @"1";
        [_vCountBg addSubview:_lbCount];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(231);
        [self addSubview:_vLine];
        
        _lbDetail = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbDetail.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbDetail.textColor = RGB3(26);
        _lbDetail.text = @"商品详情";
        [self addSubview:_lbDetail];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 101) {
        sender.selected = !sender.selected;
    }else if(tag == 102){
        
    }else if(tag == 103){
        NSString *str = self.lbCount.text;
        if ([str integerValue] > 1) {
            NSInteger c = [str integerValue];
            if(c > 1){
                self.lbCount.text = [NSString stringWithFormat:@"%zi",c-1];
            }
            
            if(c-1 == 1){
                [self.btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
            }
        }
    }else if(tag == 104){
        NSString *str = self.lbCount.text;
        NSInteger c = [str integerValue]+1;
        self.lbCount.text = [NSString stringWithFormat:@"%zi",c];
        if (c > 1) {
            [self.btnMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

- (void)updateData{
    self.lbName.text = @"AP GOLD LF汽车机油";
    self.lbNoText.text = @"1M3ZC1161";
    self.lbTopPriceText.text = @"???/瓶";
    
    self.lbRole.text = @"?起订";
    self.lbStatus.text = @" | 库存充足";
    self.lbPrice.text = @"¥???.00/瓶";
    
    if(self.lbPrice.text.length > 1){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-2)];
        
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*RATIO_WIDHT320] range:NSMakeRange(0, 1)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20*RATIO_WIDHT320] range:NSMakeRange(1, self.lbPrice.text.length - 5)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*RATIO_WIDHT320] range:NSMakeRange(self.lbPrice.text.length - 4, 4)];
        [self.lbPrice setAttributedText:noteStr];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
    CGRect r = self.lbName.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 12*RATIO_WIDHT320;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbName.bottom + 12*RATIO_WIDHT320;
    r.size = size;
    self.lbNo.frame = r;
    
    size = [self.lbNoText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNoText.frame;
    r.origin.x = self.lbNo.right + 20*RATIO_WIDHT320;
    r.origin.y = self.lbNo.top;
    r.size = size;
    self.lbNoText.frame = r;
    
    size = [self.lbTopPrice sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbTopPrice.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbNo.bottom + 12*RATIO_WIDHT320;
    r.size = size;
    self.lbTopPrice.frame = r;
    
    size = [self.lbTopPriceText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbTopPriceText.frame;
    r.origin.x = self.lbTopPrice.right + 20*RATIO_WIDHT320;
    r.origin.y = self.lbTopPrice.top;
    r.size = size;
    self.lbTopPriceText.frame = r;
    
    size = [self.lbRole sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbRole.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbTopPrice.bottom + 18*RATIO_WIDHT320;
    r.size = size;
    self.lbRole.frame = r;
    
    size = [self.lbStatus sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbStatus.frame;
    r.origin.x = self.lbRole.right;
    r.origin.y = self.lbRole.top;
    r.size = size;
    self.lbStatus.frame = r;
    
    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbRole.bottom + 23*RATIO_WIDHT320;
    r.size = size;
    self.lbPrice.frame = r;
    
    r = self.vCountBg.frame;
    r.size.width = 88*RATIO_WIDHT320;
    r.size.height = 22*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbPrice.top + (self.lbPrice.height - r.size.height)/2.0;
    self.vCountBg.frame = r;
    
    r = self.btnMinus.frame;
    r.size.width = 22*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = 0;
    self.btnMinus.frame = r;
    
    r = self.btnAdd.frame;
    r.size.width = 22*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.vCountBg.width - r.size.width;
    r.origin.y = 0;
    self.btnAdd.frame = r;
    
    r = self.lbCount.frame;
    r.size.width = 44*RATIO_WIDHT320;
    r.size.height = self.vCountBg.height;
    r.origin.x = self.btnMinus.right;
    r.origin.y = 0;
    self.lbCount.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 10*RATIO_WIDHT320;
    r.origin.x = 0;
    r.origin.y = self.lbPrice.bottom + 17*RATIO_WIDHT320;
    self.vLine.frame = r;
    
    r = self.lbDetail.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 40*RATIO_WIDHT320;
    r.origin.x = 10;
    r.origin.y = self.vLine.bottom;
    self.lbDetail.frame = r;
}

+ (CGFloat)calHeight{
    CGFloat height = 12*RATIO_WIDHT320;
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
    lb.numberOfLines = 0;
    lb.text = @"AP GOLD LF汽车机油";
    height += [lb sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)].height;
    height += 12*RATIO_WIDHT320;
    
    lb.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"商品编号";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)].height*2;
    
    height += 10*RATIO_WIDHT320;
    
    height += 18*RATIO_WIDHT320;
    lb.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"起订";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)].height;
    
    height += 23*RATIO_WIDHT320;
    
    lb.font = [UIFont systemFontOfSize:20*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"???";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 20*RATIO_WIDHT320)].height;
    height += 17*RATIO_WIDHT320;
    
    
    return height + 50*RATIO_WIDHT320;
}

@end
