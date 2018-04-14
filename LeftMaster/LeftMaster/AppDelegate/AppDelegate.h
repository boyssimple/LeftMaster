//
//  AppDelegate.h
//  LeftMaster
//
//  Created by simple on 2018/3/31.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *appcKey = @"d0baae34c1567107f9542ece";
static NSString *channel = @"Publish channel";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)restoreRootViewController:(UIViewController *)rootViewController;
@end

