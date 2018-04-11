//
//  ViewCategory.h
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewCategoryDelegate;
@interface ViewCategory : UIView
@property(nonatomic,strong)UITextField *tfText;
@property(nonatomic,weak)id<ViewCategoryDelegate> delegate;
@end

@protocol ViewCategoryDelegate<NSObject>

- (void)clickQR;

@end
