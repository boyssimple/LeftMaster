//
//  AppDelegate.h
//  LeftMaster
//
//  Created by simple on 2018/3/31.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *appcKey = @"448a1c812ddf22550b7b094c";
static NSString *channel = @"Publish channel";

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic,assign)BOOL isLogin;
@property (strong, nonatomic) UIWindow *window;

- (void)restoreRootViewController:(UIViewController *)rootViewController;
@end

