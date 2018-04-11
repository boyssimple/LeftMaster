//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellOrderList.h"

@interface CellOrderList()
@property(nonatomic,strong)UIView *vDot;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UILabel *lbStatus;
@property(nonatomic,strong)UIView *vBg;
@property(nonatomic,strong)UILabel *lbCompany;

@property(nonatomic,strong)UILabel *lbOrderAmount;
@property(nonatomic,strong)UILabel *lbOrderAmountText;

@property(nonatomic,strong)UILabel *lbOrder;
@property(nonatomic,strong)UILabel *lbOrderText;

@property(nonatomic,strong)UILabel *lbGoodsCount;
@property(nonatomic,strong)UILabel *lbGoodsCountText;

@property(nonatomic,strong)UILabel *lbCotact;
@property(nonatomic,strong)UILabel *lbCotactText;

@property(nonatomic,strong)UILabel *lbOrderTime;
@property(nonatomic,strong)UILabel *lbOrderTimeText;


@property(nonatomic,strong)UIView *vLine;
@end
@implementation CellOrderList

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _vDot = [[UIView alloc]initWithFrame:CGRectZero];
        _vDot.backgroundColor = APP_COLOR;
        _vDot.layer.cornerRadius = 3.5*RATIO_WIDHT320*0.5;
        _vDot.layer.masksToBounds = YES;
        [self.contentView addSubview:_vDot];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont boldSystemFontOfSize:15*RATIO_WIDHT320];
        _lbNo.textColor = RGB(0, 0, 0);
        [self addSubview:_lbNo];
        
        _lbStatus = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbStatus.font = [UIFont systemFontOfSize:15*RATIO_WIDHT320];
        _lbStatus.textColor = RGB3(153);
        [self addSubview:_lbStatus];
        
        _vBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vBg.backgroundColor = RGB3(247);
        _vBg.layer.cornerRadius = 3.f;
        _vBg.layer.masksToBounds = YES;
        [self.contentView addSubview:_vBg];
        
        _lbCompany = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCompany.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbCompany.textColor = RGB3(0);
        [_vBg addSubview:_lbCompany];
        
        _lbOrderAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderAmount.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderAmount.textColor = RGB3(102);
        _lbOrderAmount.text = @"订单金额";
        [_vBg addSubview:_lbOrderAmount];
        
        _lbOrderAmountText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderAmountText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderAmountText.textColor = RGB3(102);
        [_vBg addSubview:_lbOrderAmountText];
        
        _lbOrder = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrder.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrder.textColor = RGB3(102);
        _lbOrder.text = @"订单人";
        [_vBg addSubview:_lbOrder];
        
        _lbOrderText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderText.textColor = RGB3(102);
        [_vBg addSubview:_lbOrderText];
        
        _lbGoodsCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbGoodsCount.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbGoodsCount.textColor = RGB3(102);
        _lbGoodsCount.text = @"商品数量";
        [_vBg addSubview:_lbGoodsCount];
        
        _lbGoodsCountText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbGoodsCountText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbGoodsCountText.textColor = RGB3(102);
        [_vBg addSubview:_lbGoodsCountText];
        
        _lbCotact = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCotact.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbCotact.textColor = RGB3(102);
        _lbCotact.text = @"联系方式";
        [_vBg addSubview:_lbCotact];
        
        _lbCotactText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCotactText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbCotactText.textColor = RGB3(102);
        [_vBg addSubview:_lbCotactText];
        
        _lbOrderTime = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderTime.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderTime.textColor = RGB3(102);
        _lbOrderTime.text = @"下单时间";
        [_vBg addSubview:_lbOrderTime];
        
        _lbOrderTimeText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderTimeText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderTimeText.textColor = RGB3(102);
        [_vBg addSubview:_lbOrderTimeText];
        
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self.contentView addSubview:_vLine];
    }
    return self;
}

- (void)updateData{
    self.lbNo.text = @"DH.20180118.001";
    self.lbStatus.text = @"待审核";
    self.lbCompany.text = @"重庆江北机械有限公司";
    
    self.lbOrderAmountText.text = @"¥???.00";
    self.lbOrderText.text = @"管理员";
    self.lbGoodsCountText.text = @"10个";
    self.lbCotactText.text = @"15909327516";
    self.lbOrderTimeText.text = @"2018-01-18";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect r = self.vDot.frame;
    r.size.width = 3.5*RATIO_WIDHT320;
    r.size.height = r.size.width ;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    self.vDot.frame = r;
    
    CGSize size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 15*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.origin.x = self.vDot.right +5*RATIO_WIDHT320;
    r.origin.y = 18*RATIO_WIDHT320;
    r.size = size;
    self.lbNo.frame = r;
    
    self.vDot.top = self.lbNo.top + (self.lbNo.height - self.vDot.height)/2.0;
    
    size = [self.lbStatus sizeThatFits:CGSizeMake(MAXFLOAT, 15*RATIO_WIDHT320)];
    r = self.lbStatus.frame;
    r.origin.x = DEVICEWIDTH - size.width - 20*RATIO_WIDHT320;
    r.origin.y = 18*RATIO_WIDHT320;
    r.size = size;
    self.lbStatus.frame = r;
    
    r = self.vBg.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 100*RATIO_WIDHT320 ;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbNo.bottom + 6*RATIO_WIDHT320;
    self.vBg.frame = r;
    
    size = [self.lbCompany sizeThatFits:CGSizeMake(self.vBg.width - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbCompany.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 10*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = self.vBg.width - 20*RATIO_WIDHT320;
    self.lbCompany.frame = r;
    
    size = [self.lbOrderAmount sizeThatFits:CGSizeMake(55*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbOrderAmount.frame;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = 55*RATIO_WIDHT320;
    self.lbOrderAmount.frame = r;
    
    size = [self.lbOrderAmountText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbOrderAmountText.frame;
    r.origin.x = self.lbOrderAmount.right;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderAmountText.frame = r;
    
    size = [self.lbOrder sizeThatFits:CGSizeMake(self.lbOrderAmount.width, MAXFLOAT)];
    r = self.lbOrder.frame;
    r.size.height = size.height;
    r.size.width = self.lbOrderAmount.width;
    r.origin.x = self.vBg.width - r.size.width - 75*RATIO_WIDHT320;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    self.lbOrder.frame = r;
    
    size = [self.lbOrderText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbOrderText.frame;
    r.origin.x = self.lbOrder.right;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderText.frame = r;
    
    size = [self.lbGoodsCount sizeThatFits:CGSizeMake(self.lbOrderAmount.width, MAXFLOAT)];
    r = self.lbGoodsCount.frame;
    r.size.height = size.height;
    r.size.width = self.lbOrderAmount.width;
    r.origin.x = self.lbOrderAmount.left;
    r.origin.y = self.lbOrderAmount.bottom + 8*RATIO_WIDHT320;
    self.lbGoodsCount.frame = r;
    
    size = [self.lbGoodsCountText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbGoodsCountText.frame;
    r.origin.x = self.lbGoodsCount.right;
    r.origin.y = self.lbOrderAmount.bottom + 8*RATIO_WIDHT320;
    r.size = size;
    self.lbGoodsCountText.frame = r;
    
    size = [self.lbCotact sizeThatFits:CGSizeMake(self.lbOrderAmount.width, MAXFLOAT)];
    r = self.lbCotact.frame;
    r.size.height = size.height;
    r.size.width = self.lbOrderAmount.width;
    r.origin.x = self.vBg.width - r.size.width - 75*RATIO_WIDHT320;
    r.origin.y = self.lbOrder.bottom + 8*RATIO_WIDHT320;
    self.lbCotact.frame = r;
    
    size = [self.lbCotactText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbCotactText.frame;
    r.origin.x = self.lbCotact.right;
    r.origin.y = self.lbOrder.bottom + 8*RATIO_WIDHT320;
    r.size = size;
    self.lbCotactText.frame = r;
    
    size = [self.lbOrderTime sizeThatFits:CGSizeMake(self.lbOrderAmount.width, MAXFLOAT)];
    r = self.lbOrderTime.frame;
    r.size.height = size.height;
    r.size.width = self.lbOrderAmount.width;
    r.origin.x = self.lbOrderAmount.left;
    r.origin.y = self.lbGoodsCount.bottom + 8*RATIO_WIDHT320;
    self.lbOrderTime.frame = r;
    
    size = [self.lbOrderTimeText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbOrderTimeText.frame;
    r.origin.x = self.lbOrderTime.right;
    r.origin.y = self.lbGoodsCount.bottom + 8*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderTimeText.frame = r;
    
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 0.5;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.vBg.bottom + 15*RATIO_WIDHT320;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 150*RATIO_WIDHT320;
}

@end



