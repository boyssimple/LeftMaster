//
//  Utils.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "Utils.h"

@implementation Utils
/**
 改变label文字中某段文字的颜色，大小
 label 传入label（传入前要有文字）
 oneW  从第一个文字开始
 twoW  到最后一个文字结束
 color 颜色
 size 尺寸
 */
+(void)LabelAttributedString:(UILabel*)label firstW:(NSString *)oneW toSecondW:(NSString *)twoW color:(UIColor *)color size:(CGFloat)size{
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:oneW].location;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:twoW].location+1;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:size] range:range];
    // 为label添加Attributed
    [label setAttributedText:noteStr];
}

+(void)showToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    [hud show:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

@end
