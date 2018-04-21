//
//  VCMine.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCMine.h"
#import "VCLogin.h"
#import "AppDelegate.h"
#import "ViewHeaderMine.h"
#import "CellMine.h"
#import "VCNotice.h"
#import "VCOrderCheckAccount.h"
#import "ViewWithExit.h"

@interface VCMine ()<UITableViewDelegate,UITableViewDataSource,CommonDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewHeaderMine *header;
@property(nonatomic,strong)ViewWithExit *footer;
@end

@implementation VCMine

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    [self.view addSubview:self.table];
}


- (void)exitAction{
    [Utils showHanding:@"退出中..." with:self.view];
    __weak typeof(self) weakself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [Utils hiddenHanding:weakself.view withTime:0.1];
        [Utils removeUserInfo];
        VCLogin *vc = [[VCLogin alloc]init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate restoreRootViewController:[[UINavigationController alloc] initWithRootViewController:vc]];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([AppUser share].isSalesman){
        return 4;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellMine calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellMine";
    CellMine *cell = (CellMine*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellMine alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.row == 0){
        [cell updateData:@"通知消息" with:@""];
    }else if(indexPath.row == 1){
        [cell updateData:@"订单对账" with:@""];
    }else if(indexPath.row == 2){
        [cell updateData:@"联系客服" with:@"400-1696444"];
    }else if(indexPath.row == 3){
        [cell updateData:@"当前客户" with:[AppUser share].CUS_NAME];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
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
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        VCNotice *vc = [[VCNotice alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1){
        VCOrderCheckAccount *vc = [[VCOrderCheckAccount alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - CommonDelete
- (void)clickActionWithIndex:(NSInteger)index{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定退出？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self exitAction];
    }
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = APP_Gray_COLOR;
        _table.tableHeaderView = self.header;
        _table.tableFooterView = self.footer;
    }
    return _table;
}


- (ViewHeaderMine*)header{
    if(!_header){
        _header = [[ViewHeaderMine alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewHeaderMine calHeight])];
        [_header updateData];
        _header.delegate = self;
    }
    return _header;
}

- (ViewWithExit*)footer{
    if(!_footer){
        _footer = [[ViewWithExit alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewWithExit calHeight])];
        _footer.delegate = self;
    }
    return _footer;
}






@end
