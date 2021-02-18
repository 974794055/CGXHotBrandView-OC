//
//  CGXHotBrandSliderView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandSliderView.h"
#import "CGXHotBrandSliderFlowLayout.h"
#import "CGXHotBrandSliderCell.h"
@interface CGXHotBrandSliderView()

@property (nonatomic,strong,readwrite) NSMutableArray<CGXHotBrandModel *>  *dataArray;
@property (nonatomic ,assign) NSInteger currentSelectIndex;

@end

@implementation CGXHotBrandSliderView
- (void)initializeData
{
    [super initializeData];
    self.currentSelectIndex = 0;
    self.isHavePage = YES;
    self.visibleItemsCount = 5;
    self.minScale = 0.7;
    self.edgeInsets =UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.clipsToBounds = NO;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView reloadData];
}
- (NSMutableArray<CGXHotBrandModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isHavePage) {
        self.collectionView.frame = CGRectMake(self.edgeInsets.left, 0, CGRectGetWidth(self.frame)-self.edgeInsets.left-self.edgeInsets.right, CGRectGetHeight(self.frame)-self.pageHeight);
    } else{
        self.collectionView.frame = CGRectMake(self.edgeInsets.left, 0, CGRectGetWidth(self.frame)-self.edgeInsets.left-self.edgeInsets.right, CGRectGetHeight(self.frame));
    }
    CGXHotBrandSliderFlowLayout *layout = (CGXHotBrandSliderFlowLayout *)[self preferredFlowLayout];
    layout.visibleItemsCount = self.visibleItemsCount;
    layout.minScale = self.minScale;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    if(self.collectionView.contentOffset.x == 0 && self.totalInter > 0){
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.collectionView.userInteractionEnabled = YES;
    }
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXHotBrandSliderFlowLayout *layout = [[CGXHotBrandSliderFlowLayout alloc] init];
    layout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    layout.minimumLineSpacing = self.minimumLineSpacing;
    layout.sectionInset = self.edgeInsets;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.visibleItemsCount = self.visibleItemsCount;
    layout.minScale = self.minScale;
    return layout;
}
- (void)setVisibleItemsCount:(NSInteger)visibleItemsCount
{
    _visibleItemsCount = visibleItemsCount;
    CGXHotBrandSliderFlowLayout *layout = (CGXHotBrandSliderFlowLayout *)[self preferredFlowLayout];
    layout.visibleItemsCount = visibleItemsCount;
    self.collectionView.collectionViewLayout = layout;
}
- (void)setMinScale:(CGFloat)minScale
{
    _minScale = minScale;
    CGXHotBrandSliderFlowLayout *layout = (CGXHotBrandSliderFlowLayout *)[self preferredFlowLayout];
    layout.minScale = minScale;
    self.collectionView.collectionViewLayout = layout;
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandSliderCell.class;
}
- (NSInteger)gx_hotBrandNumberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    [super gx_hotBrandNumberOfSectionsInCollectionView:collectionView];
    return 1;
}
- (NSInteger)gx_hotBrandCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [super gx_hotBrandCollectionView:collectionView numberOfItemsInSection:section];
    return  self.totalInter;
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
- (void)automaticScroll
{
    [super automaticScroll];
    if (0 == self.totalInter) return;
    [self scrollToIndex:self.currentSelectIndex];
}
- (void)scrollToIndex:(NSInteger)targetIndex
{
    NSInteger currentInter = targetIndex;
    if (currentInter >= self.totalInter-self.dataArray.count) {
        if (self.infiniteLoop) {
            NSInteger itemIndex = [self currentIndex];
            int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
            [self.collectionView setContentOffset:CGPointMake(itemIndex * self.collectionView.bounds.size.width, 0) animated:NO];
            self.pageCurrent = indexOnPageControl;
        }
        return;
    }
    NSInteger itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    [self.collectionView setContentOffset:CGPointMake(itemIndex * self.collectionView.bounds.size.width,0) animated:YES];
    self.pageCurrent = indexOnPageControl;
}

////#pragma mark - 定时器
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
    self.currentSelectIndex = (scrollView.contentOffset.x + 20)/self.collectionView.bounds.size.width;
    if (self.currentSelectIndex >= (self.totalInter-1-self.visibleItemsCount) || self.currentSelectIndex == 0) {
        NSInteger centerIndex = self.totalInter/2;
        self.currentSelectIndex = centerIndex;
    }
    if (self.dataArray.count > 0 && self.currentSelectIndex % self.dataArray.count < self.dataArray.count) {
        int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:self.currentSelectIndex];
        self.pageCurrent = indexOnPageControl;
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.collectionView.userInteractionEnabled = YES;
    if (!self.dataArray.count) return; // 解决清除timer时偶尔会出现的问题
    self.currentSelectIndex = (scrollView.contentOffset.x + 20)/self.collectionView.bounds.size.width;
    if (self.currentSelectIndex >= (self.totalInter-1-self.visibleItemsCount) || self.currentSelectIndex == 0) {
        NSInteger centerIndex = self.totalInter/2;;
        self.currentSelectIndex = centerIndex;
    }
    if (self.dataArray.count > 0 && self.currentSelectIndex % self.dataArray.count < self.dataArray.count) {
        int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:self.currentSelectIndex];
        self.pageCurrent = indexOnPageControl;
    }
}
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    if (self.dataArray&&self.dataArray.count==1) {
        self.infiniteLoop = NO;
        self.totalInter = self.dataArray.count;
    } else{
        self.totalInter =  self.infiniteLoop?self.dataArray.count*self.groudInter:self.dataArray.count;
    }
    if (self.dataArray.count > 1) { // 由于 !=1 包含count == 0等情况
        self.collectionView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        self.collectionView.scrollEnabled = NO;
    }
    self.pagesNumber = dataArray.count;
    [self.collectionView reloadData];
}


- (int)currentIndex
{
    [super currentIndex];
    if (self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
        return 0;
    }
    self.currentSelectIndex++;
    int index = (int)self.currentSelectIndex;
    return MAX(0, index);
}
- (CGXHotBrandModel *)pageIndexWithCurrentCellModelAtIndexPath:(NSIndexPath *)indexPath
{
    [super pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    int rowInter = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    CGXHotBrandModel *cellModel = self.dataArray[rowInter];
    return cellModel;
}
- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.dataArray.count;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
