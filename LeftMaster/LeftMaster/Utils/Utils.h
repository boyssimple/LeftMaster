//
//  Utils.h
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void)saveUserInfo:(NSDictionary*)dic;

+ (NSData*)getUserInfo;

+ (void)removeUserInfo;


+(void)LabelAttributedString:(UILabel*)label firstW:(NSString *)oneW toSecondW:(NSString *)twoW color:(UIColor *)color size:(CGFloat)size;

+(void)showToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time;

+(void)showToast:(NSString*)text mode:(MBProgressHUDMode)mode with:(UIView*)view withTime:(CGFloat)time;

+(void)showSuccessToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time;
@end
