//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanCategoryHome.h"

@implementation RequestBeanCategoryHome

-(NSInteger)page_size{
    return 10;
}

- (NSString*)apiPath{
    return net_home_category;
}

- (BOOL)isShowHub{
    return FALSE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanCategoryHome

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end


