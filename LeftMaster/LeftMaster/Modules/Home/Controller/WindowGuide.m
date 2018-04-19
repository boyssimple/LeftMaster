//
//  WindowGuide.m
//  LeftMaster
//
//  Created by simple on 2018/4/19.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "WindowGuide.h"
#import "CollCellGuide.h"

@interface WindowGuide()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) UIButton* dismissButton;
@end

@implementation WindowGuide

- (id)initWith:(NSArray*)images
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        self.dataSource = images;
        self.windowLevel = UIWindowLevelAlert;
        _mainView = [[UIView alloc] initWithFrame:self.frame];
        _mainView.backgroundColor = [UIColor whiteColor];
        guideWindow = self;
        [self addSubview:_mainView];
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.mainView.bounds collectionViewLayout:layout];
    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    if (@available(*,iOS 11)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.collectionView registerClass:[CollCellGuide class] forCellWithReuseIdentifier:GuaidViewCellID];
    
    [self.mainView addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.numberOfPages = self.dataSource.count;
    [self.mainView addSubview:self.pageControl];
    
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    
    self.pageControl.frame = CGRectMake((CGRectGetWidth(self.mainView.frame) - size.width) / 2,
                                        CGRectGetHeight(self.mainView.frame) - size.height,
                                        size.width, size.height);
    
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dismissButton setImage:[UIImage imageNamed:@"hidden"] forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissButton sizeToFit];
    self.dismissButton.hidden = YES;
    
    self.dismissButton.center = CGPointMake(DEVICEWIDTH / 2, DEVICEHEIGHT - 80);
    [self.mainView addSubview:self.dismissButton];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollCellGuide* cell = [collectionView dequeueReusableCellWithReuseIdentifier:GuaidViewCellID forIndexPath:indexPath];
    cell.imageView.image = self.dataSource[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    long current = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    self.pageControl.currentPage = lroundf(current);
    self.dismissButton.hidden = self.dataSource.count != current + 1;
}

- (void)dealloc{
    NSLog(@"[DEBUG] delloc:%@",self);
}

- (void)show {
    [self makeKeyAndVisible];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        guideWindow.alpha = 0;
    } completion:^(BOOL finished) {
        [guideWindow removeAllSubviews];
        guideWindow = nil;
        [self resignKeyWindow];
    }];
    
}

@end
