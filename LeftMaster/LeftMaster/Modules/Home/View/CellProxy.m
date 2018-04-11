//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellProxy.h"

@interface CellProxy()
@property(nonatomic,strong)UILabel *lbName;

@end
@implementation CellProxy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        [self.contentView addSubview:_lbName];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    
}

- (void)updateData:(NSDictionary*)data{
    self.lbName.text = [data jk_stringForKey:@"customer_name"];
}

- (void)updateData{
    self.lbName.text = @"客户 001";
}

- (void)layoutSubviews{
    [super layoutSubviews];CGRect r = self.lbName.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size.width = DEVICEWIDTH - 60*RATIO_WIDHT320;
    r.size.height = self.height;
    self.lbName.frame = r;
}

+ (CGFloat)calHeight{
    return 34*RATIO_WIDHT320;
}

@end


