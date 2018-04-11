//
//  ViewBtnGoods.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewBtnGoods.h"
@interface ViewBtnGoods()

@property(nonatomic,strong)UIImageView *ivCart;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,strong)UIButton *btnJoinCart;
@property(nonatomic,strong)UIButton *btnJoinOrder;
@end


@implementation ViewBtnGoods

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _ivCart = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivCart.image = [UIImage imageNamed:@"classification-icon_Shopping-Cart"];
        _ivCart.userInteractionEnabled = YES;
        [self addSubview:_ivCart];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont systemFontOfSize:8*RATIO_WIDHT320];
        _lbCount.textColor = [UIColor whiteColor];
        _lbCount.numberOfLines = 2;
        _lbCount.backgroundColor = APP_COLOR;
        _lbCount.layer.cornerRadius = 5*RATIO_WIDHT320;
        _lbCount.layer.masksToBounds = YES;
        _lbCount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbCount];
        
        _btnJoinCart = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnJoinCart setTitle:@"加入购物车" forState:UIControlStateNormal];
        _btnJoinCart.backgroundColor = RGB(250,129,0);
        _btnJoinCart.titleLabel.font = [UIFont boldSystemFontOfSize:17*RATIO_WIDHT320];
        [_btnJoinCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnJoinCart addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnJoinCart.tag = 100;
        [self addSubview:_btnJoinCart];
        
        _btnJoinOrder = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnJoinOrder setTitle:@"立即下单" forState:UIControlStateNormal];
        _btnJoinOrder.backgroundColor = APP_COLOR;
        _btnJoinOrder.titleLabel.font = [UIFont boldSystemFontOfSize:17*RATIO_WIDHT320];
        [_btnJoinOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnJoinOrder addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnJoinOrder.tag = 101;
        [self addSubview:_btnJoinOrder];
    }
    return self;
}

- (void)updateData{
    self.count = 10;
}

- (void)setCount:(NSInteger)count{
    _count = count;
    if (_count > 10) {
        self.lbCount.text = [NSString stringWithFormat: @"%zi+",self.count];
    }else{
        self.lbCount.text = [NSString stringWithFormat: @"%zi",self.count];
    }
}

- (void)clickAction:(UIButton*)sender{
    if (sender.tag == 100) {
        self.count = self.count+1;
        [self postNotification:REFRESH_CART_LIST withObject:nil];
        [Utils showSuccessToast:@"加入购物车成功" with:self withTime:1];
    }else{
        
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect r = self.ivCart.frame;
    r.size.width = 23*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 35*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.ivCart.frame = r;
    
    r = self.lbCount.frame;
    r.size.width = 20*RATIO_WIDHT320;
    r.size.height = 10*RATIO_WIDHT320;
    r.origin.x = self.ivCart.right - r.size.width * 0.5;
    r.origin.y = self.ivCart.top;
    self.lbCount.frame = r;
    
    r = self.btnJoinOrder.frame;
    r.size.width = 120*RATIO_WIDHT320;
    r.size.height = self.height;
    r.origin.x = DEVICEWIDTH - r.size.width;
    r.origin.y = 0;
    self.btnJoinOrder.frame = r;
    
    r = self.btnJoinCart.frame;
    r.size.width = 120*RATIO_WIDHT320;
    r.size.height = self.height;
    r.origin.x = self.btnJoinOrder.left - r.size.width;
    r.origin.y = 0;
    self.btnJoinCart.frame = r;
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end
