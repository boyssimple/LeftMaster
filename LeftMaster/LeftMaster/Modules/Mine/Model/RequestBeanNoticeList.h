//
//  RequestBeanNoticeList.h
//  LeftMaster
//
//  Created by simple on 2018/5/20.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanNoticeList : AJRequestBeanBase
@property(nonatomic,strong)NSString *user_id;     //userID
@property(nonatomic,assign)NSInteger message_type; //消息类型(订单消息:1,系统公告:2,促销提醒:3)
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end

@interface ResponseBeanNoticeList : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
