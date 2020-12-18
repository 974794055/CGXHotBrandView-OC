//
//  CGXHotBrandBaseView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"
#import "NSTimer+CGXHotBrandTimer.h"
#import "CGXHotBrandBaseFlowLayout.h"
#import "CGXHotBrandBaseCell.h"
#import "CGXHotBrandModel.h"
@interface CGXHotBrandBaseView ()<CGXHotBrandBaseFlowLayoutDelegate>

/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation CGXHotBrandBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (void)initializeData
{
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.itemSectionCount = 2;
    self.itemRowCount = 4;
}
- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing
{
    _minimumLineSpacing = minimumLineSpacing;
}
- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
{
    _minimumInteritemSpacing = minimumInteritemSpacing;
}
- (void)setItemRowCount:(NSInteger)itemRowCount
{
    _itemRowCount = itemRowCount;
}
- (void)setItemSectionCount:(NSInteger)itemSectionCount
{
    _itemSectionCount = itemSectionCount;
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
}
- (void)initializeViews
{
    [self.collectionView reloadData];
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)next;
            if (@available(iOS 11.0, *)) {
                vc.automaticallyAdjustsScrollViewInsets = NO;
            }
            break;
        }
        next = next.nextResponder;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.collectionView.collectionViewLayout = [self preferredFlowLayout];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self preferredFlowLayout]];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.bounces = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
        [self addSubview:self.collectionView];
    }
    return _collectionView;
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    // 自定义CGXHotBrandFlowlayout布局
    CGXHotBrandBaseFlowLayout *layout = [[CGXHotBrandBaseFlowLayout alloc] init];
    layout.delegate = self;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return  layout;
}
/**
 返回自定义cell的class
 
 @return cell class
 */
- (Class)preferredCellClass
{
    return CGXHotBrandBaseCell.class;
}
- (void)setDelegate:(id<CGXHotBrandBaseViewDelegate>)delegate
{
    _delegate = delegate;
    
    if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellClassForBaseView:)] && [self.delegate gx_hotBrandCellClassForBaseView:self]) {
        [self.collectionView registerClass:[self.delegate gx_hotBrandCellClassForBaseView:self] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    }else if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellNibForBaseView:)] && [self.delegate gx_hotBrandCellNibForBaseView:self]) {
        [self.collectionView registerNib:[self.delegate gx_hotBrandCellNibForBaseView:self] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    }
}
- (NSInteger)hotBrand_collectionView:(UICollectionView *)collectionView
                              layout:(UICollectionViewLayout*)collectionViewLayout
                      SectionAtIndex:(NSInteger)section
{
    return self.itemSectionCount;
}
- (NSInteger)hotBrand_collectionView:(UICollectionView *)collectionView
                              layout:(UICollectionViewLayout*)collectionViewLayout
                          RowAtIndex:(NSInteger)section
{
    return self.itemRowCount;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}


- (void)disableScrollGesture {
    self.collectionView.canCancelContentTouches = NO;
    for (UIGestureRecognizer *gesture in self.collectionView.gestureRecognizers) {
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.collectionView removeGestureRecognizer:gesture];
        }
    }
}

@end
