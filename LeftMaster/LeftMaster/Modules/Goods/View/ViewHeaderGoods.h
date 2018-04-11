//
//  ViewHeaderGoods.h
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewHeaderGoodsDelegate;

@interface ViewHeaderGoods : UIView
@property (nonatomic, weak) id<ViewHeaderGoodsDelegate> delegate;
- (void)updateData:(NSDictionary*)data;
+ (CGFloat)calHeight:(NSDictionary*)data;
@end

@protocol ViewHeaderGoodsDelegate<NSObject>
- (void)minusCount;
- (void)addCount;
@end
