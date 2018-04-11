//
//  VCCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCTopGoods.h"
#import "CellTopGoods.h"
#import "ViewTotalCart.h"
#import "VCWriteOrder.h"
#import "VCWriteOrder.h"

@interface VCTopGoods ()<UITableViewDelegate,UITableViewDataSource,ViewTotalCartDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewTotalCart *vControl;
@end

@implementation VCTopGoods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    [self.view addSubview:self.table];
    [self.view addSubview:self.vControl];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellTopGoods calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellTopGoods";
    CellTopGoods *cell = (CellTopGoods*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellTopGoods alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell updateData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[UIView alloc]init];
    }
    return header;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
    if (!footer) {
        footer = [[UIView alloc]init];
        footer.backgroundColor = APP_Gray_COLOR;
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark ViewTotalCartDelegate
- (void)clickOrder{
    VCWriteOrder *vc = [[VCWriteOrder alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-[ViewTotalCart calHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (ViewTotalCart*)vControl{
    if(!_vControl){
        _vControl = [[ViewTotalCart alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewTotalCart calHeight]-TABBAR_HEIGHT, DEVICEWIDTH, [ViewTotalCart calHeight])];
        [_vControl updateData];
        _vControl.delegate = self;
    }
    return _vControl;
}

@end

