//
//  RequestBeanCarouseList.h
//  LeftMaster
//
//  Created by simple on 2018/4/20.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanCarouseList : AJRequestBeanBase

@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end

@interface ResponseBeanCarouseList : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
