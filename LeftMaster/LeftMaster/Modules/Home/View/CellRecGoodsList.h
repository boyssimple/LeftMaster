//
//  CellRecGoodsList.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellRecGoodsListDelegate;
@interface CellRecGoodsList : UITableViewCell
@property (nonatomic, weak) id<CommonDelegate> delegate;
@property (nonatomic, weak) id<CellRecGoodsListDelegate> joinCartDelegate;
- (void)updateData:(NSDictionary*)data;
@end

@protocol CellRecGoodsListDelegate<NSObject>
- (void)joinCartClick:(CGRect)r withNum:(NSInteger)num;
@end
