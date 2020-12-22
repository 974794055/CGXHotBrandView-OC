//
//  CGXHotBrandCycleView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCycleView.h"
#import "CGXHotBrandCycleFlowLayout.h"


@interface CGXHotBrandCycleView ()<CGXHotBrandCycleFlowLayoutDelegate>

@property (nonatomic, strong,readwrite) NSMutableArray<CGXHotBrandModel *> *dataArray;

@property (nonatomic, assign) NSInteger totalInter;

/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;

/** 自动滚动间隔时间,默认0.1s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

@end

@implementation CGXHotBrandCycleView
- (void)initializeData
{
    [super initializeData];
    self.offsetX = 0.5;
    self.totalInter = 11;
    self.widthSpace = 1.0;
    self.autoScrollTimeInterval = 0.1;
    self.autoScroll = YES;
    
    self.scrollOffsetX = 10;
}
- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.collectionView reloadData];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.collectionViewLayout = [self preferredFlowLayout];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    
    NSInteger targetIndex = self.dataArray.count * self.totalInter * 0.5;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXHotBrandCycleFlowLayout *layout = [[CGXHotBrandCycleFlowLayout alloc] init];
    layout.cycleDelegate = self;
    layout.offsetX = self.offsetX;
    layout.itemSectionCount = self.itemSectionCount;
    layout.itemRowCount = self.itemRowCount;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandCycleCell.class;
}
- (NSMutableArray<CGXHotBrandModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.edgeInsets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = self.edgeInsets;
    CGFloat spaceW = insets.left+insets.right;
    CGFloat spaceH = insets.top+insets.bottom;
    CGFloat width = (CGRectGetWidth(collectionView.frame) - spaceW-self.minimumInteritemSpacing*(self.itemRowCount-1)) / self.itemRowCount;
    CGFloat height = (CGRectGetHeight(collectionView.frame) - spaceH-self.minimumLineSpacing*(self.itemSectionCount-1)) / self.itemSectionCount;
    return CGSizeMake(width, height);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.dataArray.count * self.totalInter;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellClassForBaseView:)] && [self.delegate gx_hotBrandCellClassForBaseView:self]) {
        return cell;
    }else if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellNibForBaseView:)] && [self.delegate gx_hotBrandCellNibForBaseView:self]) {
        return cell;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    int rowInter = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    CGXHotBrandModel *cellModel = self.dataArray[rowInter];
    BOOL isHave = [cell respondsToSelector:@selector(updateWithHotBrandCellModel:Section:Row:)];
    if (isHave == YES && [cell conformsToProtocol:@protocol(CGXHotBrandUpdateCellDelegate)]) {
        [(UICollectionViewCell<CGXHotBrandUpdateCellDelegate> *)cell updateWithHotBrandCellModel:cellModel Section:indexPath.section Row:indexPath.row];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gx_hotBrandCycleView:cellForItemAtIndexPath:AtCell:AtModel:)]) {
        [self.dataSource gx_hotBrandCycleView:self cellForItemAtIndexPath:indexPath AtCell:cell AtModel:cellModel];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int rowInter = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    CGXHotBrandModel *cellModel = self.dataArray[rowInter];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gx_hotBrandCycleView:didSelectItemAtIndexPath:AtModel:)]) {
        [self.dataSource gx_hotBrandCycleView:self didSelectItemAtIndexPath:indexPath AtModel:cellModel];
    }
    
}
- (CGFloat)hotBrand_collectionView:(UICollectionView *)collectionView ItemWidthAtheight:(CGFloat)height
{
    if (self.widthSpace > 0) {
        return height * self.widthSpace;
    }
    return height;
}
- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.dataArray.count;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat itemWW = scrollView.contentSize.width / self.totalInter;
    if (scrollView.contentOffset.x<=itemWW) {
        [self.collectionView performBatchUpdates:^{
            [self.collectionView setContentOffset:CGPointMake(scrollView.contentSize.width-2*itemWW+scrollView.contentOffset.x, 0) animated:NO];
        } completion:^(BOOL finished) {
            
        }];
    }
    if (scrollView.contentOffset.x >= itemWW*(self.totalInter-1)) {
        [self.collectionView performBatchUpdates:^{
            [self.collectionView setContentOffset:CGPointMake(scrollView.contentOffset.x - itemWW*(self.totalInter-1) + 2*itemWW, 0) animated:NO];
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
}

#pragma mark - 定时器
- (void)setupTimer
{
    if (self.timer || self.autoScrollTimeInterval <= 0) {
        return;
    }
    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
// 停止定时器
- (void)invalidateTimer
{
    if (!self.timer) {
        return;
    }
    [self.timer  invalidate];
    self.timer  = nil;
}
- (void)automaticScroll
{
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x+self.scrollOffsetX, 0) animated:YES];
}
-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    [self invalidateTimer];
    if (_autoScroll) {
        [self setupTimer];
    }
}
- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
