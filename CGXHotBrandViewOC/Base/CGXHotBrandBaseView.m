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

#import "UIImage+CGXHotBrand.h"
#import "CGXHotBrandPageSquareView.h"
@interface CGXHotBrandBaseView ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign,readwrite) NSInteger groudInter;

@property (nonatomic, strong) CGXHotBrandPageControl *pageControl;

@property (nonatomic, strong,readwrite) CGXHotBrandCollectionView *collectionView;

@end

@implementation CGXHotBrandBaseView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}
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
    if (!newSuperview) {
        [self invalidateTimer];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.collectionView setNeedsLayout];
    [self.collectionView layoutIfNeeded];
    
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    if (self.isHavePage) {
        NSInteger itemIndex = [self currentIndex];
        if (itemIndex < self.totalInter) {
            self.pageControl.currentPage = itemIndex;
        }
        CGSize pointSize = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
        if (self.pageContolAliment == CGXHotBrandPageAlimentRight) {
            self.pageControl.frame = CGRectMake(CGRectGetWidth(self.frame)-self.pageHorizontalOffset-pointSize.width, CGRectGetHeight(self.frame)-self.pageHeight-self.pageBottomOffset, pointSize.width, self.pageHeight);
        } else if (self.pageContolAliment == CGXHotBrandPageAlimentLeft){
            self.pageControl.frame = CGRectMake(self.pageHorizontalOffset, CGRectGetHeight(self.frame)-self.pageHeight-self.pageBottomOffset, pointSize.width, self.pageHeight);
        } else{
            self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame)-self.pageHeight-self.pageBottomOffset, CGRectGetWidth(self.frame), self.pageHeight);
        }
        self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.pageHeight);
    } else{
        self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
    self.pageControl.hidesPage = !self.isHavePage;
    [self.collectionView reloadData];
}


- (CGXHotBrandCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[CGXHotBrandCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self preferredFlowLayout]];
        _collectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        _collectionView.bounces = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
        //给collectionView注册头分区的Id
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        //给collection注册脚分区的id
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.alwaysBounceVertical = NO;
        [self addSubview:self.collectionView];
    }
    return _collectionView;
}

- (void)setDelegate:(id<CGXHotBrandCustomViewDelegate>)delegate
{
    _delegate = delegate;
    
    if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellClassForBaseView:)] && [self.delegate gx_hotBrandCellClassForBaseView:self]) {
        [self.collectionView registerClass:[self.delegate gx_hotBrandCellClassForBaseView:self] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    }else if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellNibForBaseView:)] && [self.delegate gx_hotBrandCellNibForBaseView:self]) {
        [self.collectionView registerNib:[self.delegate gx_hotBrandCellNibForBaseView:self] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    }
}
- (void)disableScrollGesture
{
    self.collectionView.canCancelContentTouches = NO;
    for (UIGestureRecognizer *gesture in self.collectionView.gestureRecognizers) {
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.collectionView removeGestureRecognizer:gesture];
        }
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self gx_hotBrandNumberOfSectionsInCollectionView:collectionView];
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self gx_hotBrandCollectionView:collectionView numberOfItemsInSection:section];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellClassForBaseView:)] && [self.delegate gx_hotBrandCellClassForBaseView:self] && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:cellForItemAtIndexPath:AtCell:AtModel:)]) {
        [self gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
        return cell;
    }else if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellNibForBaseView:)] && [self.delegate gx_hotBrandCellNibForBaseView:self] && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:cellForItemAtIndexPath:AtCell:AtModel:)]) {
        [self gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
        return cell;
    }
    [self gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [self gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self gx_hotBrandCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        view.backgroundColor = collectionView.backgroundColor;
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        view.backgroundColor = collectionView.backgroundColor;
        return view;
    }
}

- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    self.collectionView.pagingEnabled = pagingEnabled;
}
- (void)setBounces:(BOOL)bounces
{
    _bounces = bounces;
    self.collectionView.bounces = bounces;
}
- (void)setPageSelectColor:(UIColor *)pageSelectColor
{
    _pageSelectColor = pageSelectColor;
    self.pageControl.dotCurrentColor = pageSelectColor;
}
- (void)setPageNormalColor:(UIColor *)pageNormalColor
{
    _pageNormalColor = pageNormalColor;
    self.pageControl.dotColor = pageNormalColor;
}
- (void)setPageSelectImage:(UIImage *)pageSelectImage
{
    _pageSelectImage = pageSelectImage;
    self.pageControl.dotImage = pageSelectImage;
}
- (void)setPageNormalImage:(UIImage *)pageNormalImage
{
    _pageNormalImage = pageNormalImage;
    self.pageControl.dotImage = pageNormalImage;
}
- (void)setPageHeight:(CGFloat)pageHeight
{
    _pageHeight = pageHeight;
}
- (void)setIsHavePage:(BOOL)isHavePage
{
    _isHavePage = isHavePage;
    self.pageControl.hidesPage = !isHavePage;
}
- (void)setPageSize:(CGSize)pageSize
{
    _pageSize = pageSize;
    self.pageControl.dotSize = pageSize;
}
- (void)setHidesPage:(BOOL)hidesPage
{
    _hidesPage = hidesPage;
}
- (void)setPageContolAliment:(CGXHotBrandPageAliment)pageContolAliment
{
    _pageContolAliment = pageContolAliment;
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing
{
    _minimumLineSpacing = minimumLineSpacing;
}
- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
{
    _minimumInteritemSpacing = minimumInteritemSpacing;
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
}
-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    [self invalidateTimer];
    if (_autoScroll) {
        [self setupTimer];
    }
}
- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    if (!infiniteLoop) {
        self.autoScroll = NO;
    }
}
- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}
- (void)setPageBetween:(CGFloat)pageBetween
{
    _pageBetween = pageBetween;
    self.pageControl.dotBetween = pageBetween;
}
- (void)setPageWidthSpace:(CGFloat)pageWidthSpace
{
    _pageWidthSpace= pageWidthSpace;
    self.pageControl.dotWidthSpace = pageWidthSpace;
}
- (void)setPageBorderColor:(UIColor *)pageBorderColor
{
    _pageBorderColor = pageBorderColor;
    self.pageControl.dotBorderColor = pageBorderColor;
}
- (void)setPageBorderSelectColor:(UIColor *)pageBorderSelectColor
{
    _pageBorderSelectColor = pageBorderSelectColor;
    self.pageControl.dotBorderSelectColor = pageBorderSelectColor;
}
- (void)setPageBorderWidth:(CGFloat)pageBorderWidth
{
    _pageBorderWidth = pageBorderWidth;
    self.pageControl.dotBorderWidth = pageBorderWidth;
}
#pragma mark - 定时器
- (void)setupTimer
{
    if (self.timer || self.autoScrollTimeInterval <= 0) {
        return;
    }
    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer gx_hotBrandTimerWithTimeInterval:self.autoScrollTimeInterval repeats:YES callback:^(NSTimer * _Nonnull timer) {
        [weakSelf automaticScroll];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];

    
}
// 停止定时器
- (void)invalidateTimer
{
    if (!self.timer) {
        return;
    }
    [self.timer invalidate];
    self.timer  = nil;
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc
{
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}

@end

@implementation CGXHotBrandBaseView (CGXHotBrand)

- (void)initializeData
{
    self.groudInter = 51;
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.autoScrollTimeInterval = 2;
    self.autoScroll = YES;
    self.infiniteLoop = YES;
    
    self.pageSize = CGSizeMake(8, 8);
    self.pageHeight = 20;
    self.pageSelectColor = [UIColor redColor];
    self.pageNormalColor = [UIColor grayColor];
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.isHavePage = NO;
    self.hidesPage = YES;
    self.pageBottomOffset = 0;
    self.pageHorizontalOffset = 0;
    self.pageContolAliment = CGXHotBrandPageAlimentCenter;
    
    self.pageWidthSpace = 0;
    self.pageBetween = 0;
    self.pageBorderColor = self.pageNormalColor;
    self.pageBorderSelectColor = self.pageSelectColor;
    self.pageBorderWidth = 0;

    
}
- (void)initializeViews
{
    self.pageControl = [[CGXHotBrandPageControl alloc] init];
    [self.pageControl setTransform:CGAffineTransformMakeScale(1, 1)];
    self.pageControl.hidesForSinglePage = true;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.dotSize = self.pageSize;
    [self addSubview:self.pageControl];
    [self bringSubviewToFront:self.pageControl];

    if (self.pageNormalColor) {
        self.pageNormalColor = self.pageNormalColor;
    }
    if (self.pageSelectColor) {
        self.pageSelectColor = self.pageSelectColor;
    }
    self.pageControl.dotStyle = self.dotStyle;
    [self.collectionView reloadData];
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    // 自定义CGXHotBrandFlowlayout布局
    CGXHotBrandBaseFlowLayout *layout = [[CGXHotBrandBaseFlowLayout alloc] init];
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
- (NSInteger)gx_hotBrandNumberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}
- (NSInteger)gx_hotBrandCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  0;
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    BOOL isHave = [cell respondsToSelector:@selector(updateWithHotBrandCellModel:Section:Row:)];
    if (isHave == YES && [cell conformsToProtocol:@protocol(CGXHotBrandUpdateCellDelegate)]) {
        [(UICollectionViewCell<CGXHotBrandUpdateCellDelegate> *)cell updateWithHotBrandCellModel:cellModel Section:indexPath.section Row:indexPath.row];
    }
    if ([cell respondsToSelector:@selector(cellOffsetOnCollectionView:)] && [cell conformsToProtocol:@protocol(CGXHotBrandUpdateCellDelegate)]) {
        [(UICollectionViewCell<CGXHotBrandUpdateCellDelegate> *)cell cellOffsetOnCollectionView:collectionView];
    }
    if (self.hotBrand_loadImageCallback != nil) {
        cellModel.hotBrand_loadImageCallback = weakSelf.hotBrand_loadImageCallback;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:cellForItemAtIndexPath:AtCell:AtModel:)]) {
        [self.delegate gx_hotBrandBaseView:self cellForItemAtIndexPath:indexPath AtCell:cell AtModel:cellModel];
    }
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:didSelectItemAtIndexPath:AtModel:)]) {
        [self.delegate gx_hotBrandBaseView:self didSelectItemAtIndexPath:indexPath AtModel:cellModel];
    }
}
- (void)setPagesNumber:(NSInteger)pagesNumber
{
    _pagesNumber = pagesNumber;
    self.pageControl.numberOfPages = pagesNumber;
}
- (void)setPageCurrent:(NSInteger)pageCurrent
{
    _pageCurrent = pageCurrent;
    self.pageControl.currentPage = pageCurrent;
}
- (int)currentIndex
{
    if (self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
        return 0;
    }
    int index = 0;
    return MAX(0, index);
}

- (CGXHotBrandModel *)pageIndexWithCurrentCellModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [[CGXHotBrandModel alloc] init];
}
- (void)automaticScroll
{
    if (!self.timer) return;
    if (!self.superview) return;
}
@end

