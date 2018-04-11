//
//  VCCategory.m
//  LeftMaster
//
//  Created by simple on 2018/4/3.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCCategory.h"
#import "CellCategory.h"
#import "CollCellCategory.h"
#import "ViewCategory.h"
#import "HMScannerController.h"

@interface VCCategory ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,ViewCategoryDelegate>
@property(nonatomic,strong)ViewCategory *vCart;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UICollectionView *collView;
@end

@implementation VCCategory

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.view.backgroundColor = RGB3(247);
    self.title = @"分类";
    [self.view addSubview:self.vCart];
    [self.view addSubview:self.table];
    [self.view addSubview:self.collView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellCategory calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellCategory";
    CellCategory *cell = (CellCategory*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellCategory alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell updateData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001f;
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
    
}

#pragma mark Collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CollCellCategory";
    CollCellCategory *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell updateData];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(73*RATIO_WIDHT320, [CollCellCategory calHeight]);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)topHeight{
    return NAV_STATUS_HEIGHT + [ViewCategory calHeight] + 10*RATIO_WIDHT320;
}

#pragma mark ViewCategoryDelegate
- (void)clickQR{
    // 实例化控制器，并指定完成回调
    HMScannerController *scanner = [HMScannerController scannerWithCardName:@"" avatar:nil completion:^(NSString *stringValue) {
        
//        self.scanResultLabel.text = stringValue;
    }];
    
    // 设置导航标题样式
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    
    // 展现扫描控制器
    [self showDetailViewController:scanner sender:nil];
}

- (ViewCategory*)vCart{
    if(!_vCart){
        _vCart = [[ViewCategory alloc]initWithFrame:CGRectMake(0, NAV_STATUS_HEIGHT, DEVICEWIDTH, [ViewCategory calHeight])];
        _vCart.delegate = self;
        [_vCart updateData];
    }
    return _vCart;
}


- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, [self topHeight], 73*RATIO_WIDHT320, DEVICEHEIGHT - [self topHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor whiteColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (UICollectionView*)collView{
    if(!_collView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10*RATIO_WIDHT320;
        layout.minimumInteritemSpacing = 3;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collView = [[UICollectionView alloc]initWithFrame:CGRectMake(73*RATIO_WIDHT320+10*RATIO_WIDHT320, [self topHeight], DEVICEWIDTH - 20*RATIO_WIDHT320 - 73*RATIO_WIDHT320, DEVICEHEIGHT - [self topHeight]) collectionViewLayout:layout];
        [_collView registerClass:[CollCellCategory class] forCellWithReuseIdentifier:@"CollCellCategory"];
//        _collView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collView.alwaysBounceVertical = YES;
        _collView.backgroundColor = [UIColor whiteColor];
        _collView.delegate = self;
        _collView.dataSource = self;
    }
    return _collView;
}


@end
