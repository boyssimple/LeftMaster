//
//  CellCategoryHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellNewHome.h"
#import "CollCellNewHome.h"
#import "VCGoods.h"

@interface CellNewHome()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collView;
@end

@implementation CellNewHome



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10*RATIO_WIDHT320;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) collectionViewLayout:layout];
        [_collView registerClass:[CollCellNewHome class] forCellWithReuseIdentifier:@"CollCellNewHome"];
        _collView.contentInset = UIEdgeInsetsMake(0, 10*RATIO_WIDHT320, 0, 10*RATIO_WIDHT320);
        _collView.backgroundColor = [UIColor clearColor];
        _collView.delegate = self;
        _collView.dataSource = self;
//        _collView.scrollEnabled = NO;
        [self.contentView addSubview:_collView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CollCellNewHome";
    CollCellNewHome *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell updateData];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = [CollCellNewHome calHeight];
    return CGSizeMake(135*RATIO_WIDHT320, w);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VCGoods *vc = [[VCGoods alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.collView.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.width;
    r.size.height = self.height;
    self.collView.frame = r;
}

+ (CGFloat)calHeight{
    return [CollCellNewHome calHeight];
}

@end

