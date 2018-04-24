//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellOrderInfo.h"

@interface CellOrderInfo()
@property(nonatomic,strong)UILabel *lbOrderStatus;
@property(nonatomic,strong)UILabel *lbOrderStatusText;
@property(nonatomic,strong)UILabel *lbOrderAmount;
@property(nonatomic,strong)UILabel *lbOrderAmountText;
@property(nonatomic,strong)UILabel *lbOrderOrderNo;
@property(nonatomic,strong)UILabel *lbOrderOrderNoText;
@property(nonatomic,strong)UILabel *lbOrderDate;
@property(nonatomic,strong)UILabel *lbOrderDateText;
@end
@implementation CellOrderInfo

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGB3(252);
        
        _lbOrderStatus = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderStatus.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbOrderStatus.textColor = RGB(0, 0, 0);
        _lbOrderStatus.text = @"订单状态：";
        [self.contentView addSubview:_lbOrderStatus];
        
        _lbOrderStatusText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderStatusText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbOrderStatusText.textColor = APP_COLOR;
        [self.contentView addSubview:_lbOrderStatusText];
        
        _lbOrderAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbOrderAmount.textColor = RGB(0, 0, 0);
        _lbOrderAmount.text = @"订单金额：";
        [self.contentView addSubview:_lbOrderAmount];
        
        _lbOrderAmountText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderAmountText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbOrderAmountText.textColor = APP_COLOR;
        [self.contentView addSubview:_lbOrderAmountText];
        
        _lbOrderOrderNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderOrderNo.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbOrderOrderNo.textColor = RGB(0, 0, 0);
        _lbOrderOrderNo.text = @"订单号：";
        [self.contentView addSubview:_lbOrderOrderNo];
        
        _lbOrderOrderNoText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderOrderNoText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbOrderOrderNoText.textColor = RGB(0, 0, 0);
        [self.contentView addSubview:_lbOrderOrderNoText];
        
        _lbOrderDate = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderDate.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbOrderDate.textColor = RGB(0, 0, 0);
        _lbOrderDate.text = @"下单时间：";
        [self.contentView addSubview:_lbOrderDate];
        
        _lbOrderDateText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderDateText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbOrderDateText.textColor = RGB(0, 0, 0);
        [self.contentView addSubview:_lbOrderDateText];
    }
    return self;
}

- (void)updateData:(NSDictionary*)data{
    self.lbOrderStatusText.text = [data jk_stringForKey:@"FD_ORDER_STATUS_NAME"];
    self.lbOrderAmountText.text = [NSString stringWithFormat:@"¥%.2f",[data jk_floatForKey:@"FD_TOTAL_PRICE"]];
    self.lbOrderOrderNoText.text = [data jk_stringForKey:@"FD_NO"];
    self.lbOrderDateText.text = [data jk_stringForKey:@"FD_ORDER_DATE"];
}

- (void)updateData{
    self.lbOrderStatusText.text = @"待审核";
    self.lbOrderAmountText.text = @"¥8,954.00";
    self.lbOrderOrderNoText.text = @"DH.20180118.00001";
    self.lbOrderDateText.text = @"2018-01-18 17:35:45";
}


- (void)layoutSubviews{
    [super layoutSubviews];
 
    CGSize size = [self.lbOrderStatus sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    CGRect r = self.lbOrderStatus.frame;
    r.origin.x = 36*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderStatus.frame = r;
    
    size = [self.lbOrderStatusText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbOrderStatusText.frame;
    r.origin.x = self.lbOrderStatus.right;
    r.origin.y = self.lbOrderStatus.top;
    r.size = size;
    self.lbOrderStatusText.frame = r;
    
    size = [self.lbOrderAmount sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbOrderAmount.frame;
    r.origin.x = 36*RATIO_WIDHT320;
    r.origin.y = self.lbOrderStatus.bottom + 10*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderAmount.frame = r;
    
    size = [self.lbOrderAmountText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbOrderAmountText.frame;
    r.origin.x = self.lbOrderAmount.right;
    r.origin.y = self.lbOrderAmount.top;
    r.size = size;
    self.lbOrderAmountText.frame = r;
    
    
    size = [self.lbOrderOrderNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbOrderOrderNo.frame;
    r.origin.x = 36*RATIO_WIDHT320;
    r.origin.y = self.lbOrderAmount.bottom + 10*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderOrderNo.frame = r;
    
    size = [self.lbOrderOrderNoText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbOrderOrderNoText.frame;
    r.origin.x = self.lbOrderOrderNo.right;
    r.origin.y = self.lbOrderOrderNo.top;
    r.size = size;
    self.lbOrderOrderNoText.frame = r;
    
    
    size = [self.lbOrderDate sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbOrderDate.frame;
    r.origin.x = 36*RATIO_WIDHT320;
    r.origin.y = self.lbOrderOrderNo.bottom + 10*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderDate.frame = r;
    
    size = [self.lbOrderDateText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbOrderDateText.frame;
    r.origin.x = self.lbOrderDate.right;
    r.origin.y = self.lbOrderDate.top;
    r.size = size;
    self.lbOrderDateText.frame = r;
}

+ (CGFloat)calHeight{
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    lb.text = @"订单状态：";
    CGSize size = [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    
    return size.height * 4 + 30*RATIO_WIDHT320 + 30*RATIO_WIDHT320;
}

@end





