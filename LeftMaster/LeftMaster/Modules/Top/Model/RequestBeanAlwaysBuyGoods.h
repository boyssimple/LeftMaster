//
//  RequestBeanAlwaysBuyGoods.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanAlwaysBuyGoods : AJRequestBeanBase

@property(nonatomic,strong)NSString *user_id;     //用户ID
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end

@interface ResponseBeanAlwaysBuyGoods : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end


