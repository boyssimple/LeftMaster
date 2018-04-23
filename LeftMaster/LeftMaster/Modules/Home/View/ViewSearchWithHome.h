//
//  ViewSearchWithHome.h
//  LeftMaster
//
//  Created by simple on 2018/4/22.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewSearchWithHomeDelegate;
@interface ViewSearchWithHome : UIView
@property (nonatomic, assign) NSInteger count;
@property(nonatomic,strong)UITextField *tfText;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,weak)id<ViewSearchWithHomeDelegate> delegate;
- (void)startAnimation;
@end

@protocol ViewSearchWithHomeDelegate<NSObject>

- (void)clickQR;

@end
