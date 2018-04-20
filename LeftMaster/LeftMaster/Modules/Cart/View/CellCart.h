//
//  CellCart.h
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellCart : UITableViewCell
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<CommonDelegate> delegate;
- (void)updateData:(NSDictionary*)data;
@end
