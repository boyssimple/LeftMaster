//
//  ViewSearchWithHome.h
//  LeftMaster
//
//  Created by simple on 2018/4/22.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewSearchWithHome : UIView
@property (nonatomic, assign) NSInteger count;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,weak)id<CommonDelegate> delegate;
@end
