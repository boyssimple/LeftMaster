//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellOrderGoodsList.h"

@interface CellOrderGoodsList()
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,strong)UIView *vLine;

@end
@implementation CellOrderGoodsList

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Shopping-Cart_icon_normal
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.image = [UIImage imageNamed:@""];
        _ivImg.userInteractionEnabled = YES;
        _ivImg.layer.cornerRadius = 2;
        _ivImg.layer.masksToBounds = YES;
        _ivImg.clipsToBounds = YES;
        [self.contentView addSubview:_ivImg];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.numberOfLines = 3;
        [self.contentView addSubview:_lbName];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbPrice.textColor = RGB(0, 0, 0);
        [self.contentView addSubview:_lbPrice];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbCount.textColor = RGB(0, 0, 0);
        [self.contentView addSubview:_lbCount];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(245);
        [self.contentView addSubview:_vLine];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
}

- (void)updateData:(NSDictionary*)data{
    if(data){
        [self.ivImg pt_setImage:[data jk_stringForKey:@"GOODS_PIC"]];
        self.lbName.text = [data jk_stringForKey:@"GOODS_NAME"];
        
        self.lbPrice.text = [NSString stringWithFormat:@"¥%zi/%@",[data jk_integerForKey:@"FD_UNIT_PRICE"],[data jk_stringForKey:@"FD_UNIT_NAME"]];
        self.lbCount.text = [NSString stringWithFormat:@"%zi%@",[data jk_integerForKey:@"FD_NUM"],[data jk_stringForKey:@"FD_UNIT_NAME"]];
        
        
        NSInteger length = [data jk_stringForKey:@"FD_UNIT_NAME"].length + 1;
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-length)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10*RATIO_WIDHT320] range:NSMakeRange(self.lbPrice.text.length-length, length)];
        [self.lbPrice setAttributedText:noteStr];
        
        length = [data jk_stringForKey:@"FD_UNIT_NAME"].length;
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:self.lbCount.text];
        // 改变颜色
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbCount.text.length-length)];
        [noteStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10*RATIO_WIDHT320] range:NSMakeRange(self.lbCount.text.length-length, length)];
        [self.lbCount setAttributedText:noteStr2];
    }
}

- (void)updateData{
//    [self.ivImg pt_setImage:@"http://pic1.win4000.com/wallpaper/2017-12-19/5a387cb8439ea.jpg"];
    self.lbName.text = @"275 50 20轮胎 275 50 20轮胎";
    self.lbPrice.text = @"¥???/个";
    self.lbCount.text = @"3个";
    
    if(self.lbPrice.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-2)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10*RATIO_WIDHT320] range:NSMakeRange(self.lbPrice.text.length-2, 2)];
        [self.lbPrice setAttributedText:noteStr];
    }
    
    if(self.lbCount.text.length > 1){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbCount.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbCount.text.length-1)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10*RATIO_WIDHT320] range:NSMakeRange(self.lbCount.text.length-1, 1)];
        [self.lbCount setAttributedText:noteStr];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivImg.frame;
    r.size.width = 80*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    self.ivImg.frame = r;
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(DEVICEWIDTH - 10*RATIO_WIDHT320 -self.ivImg.right - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbName.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.ivImg.top;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = self.ivImg.bottom - size.height;
    r.size = size;
    self.lbPrice.frame = r;
    
    size = [self.lbCount sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbCount.frame;
    r.origin.x = DEVICEWIDTH - size.width - 15*RATIO_WIDHT320;
    r.origin.y = self.ivImg.bottom - size.height;
    r.size = size;
    self.lbCount.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.ivImg.bottom + 10*RATIO_WIDHT320;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 105*RATIO_WIDHT320 + 0.5;
}

@end


