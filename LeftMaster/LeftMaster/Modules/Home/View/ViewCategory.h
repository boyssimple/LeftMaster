//
//  ViewCategory.h
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCategory : UIView
@property (nonatomic, assign) NSInteger count;
@property(nonatomic,strong)UITextField *tfText;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,weak)id<CommonDelegate> delegate;
- (void)startAnimation;
@end
