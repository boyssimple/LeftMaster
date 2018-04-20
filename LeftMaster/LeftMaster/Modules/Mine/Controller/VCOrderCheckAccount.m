//
//  VCOrderCheckAccount.m
//  LeftMaster
//
//  Created by simple on 2018/4/20.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCOrderCheckAccount.h"

@interface VCOrderCheckAccount ()
@property (nonatomic, strong) UIWebView *web;
@end

@implementation VCOrderCheckAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"订单对账";
}

- (UIWebView*)web{
    if (!_web) {
        _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        _web.backgroundColor = [UIColor whiteColor];
        [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.jd.com"]]];
    }
    return _web;
}

@end
