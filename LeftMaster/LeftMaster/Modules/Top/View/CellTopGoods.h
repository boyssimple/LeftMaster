//
//  CellTopGoods.h
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlwaysBuyGoods.h"

@interface CellTopGoods : UITableViewCell
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,weak)id<CommonDelegate> delegate;
- (void)updateData:(AlwaysBuyGoods*)data;
@end
