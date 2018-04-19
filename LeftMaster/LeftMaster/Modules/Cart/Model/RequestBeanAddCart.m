//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanAddCart.h"

@implementation RequestBeanAddCart

-(NSInteger)page_size{
    return 10;
}

- (NSString*)apiPath{
    return net_user_cart_add;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"添加中...";
}

@end

@implementation ResponseBeanAddCart

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end





