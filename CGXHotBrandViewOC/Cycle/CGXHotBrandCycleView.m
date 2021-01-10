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

@end

@implementation CGXHotBrandCycleView
- (void)initializeData
{
    [super initializeData];
    self.offsetX = 0.5;
    self.totalInter = 11;
    self.widthSpace = 1.0;
    
    self.scrollOffsetX = 10;
    self.itemSectionCount = 2;
    self.itemRowCount = 4;
    self.autoScrollTimeInterval = 0.1;
    
    self.isHavePage = NO;
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
- (NSInteger)gx_hotBrandNumberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    [super gx_hotBrandNumberOfSectionsInCollectionView:collectionView];
    return 1;
}
- (NSInteger)gx_hotBrandCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [super gx_hotBrandCollectionView:collectionView numberOfItemsInSection:section];
    return   self.dataArray.count * self.totalInter;
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
//    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:indexPath];
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
//    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:indexPath];
}
- (void)setItemRowCount:(NSInteger)itemRowCount
{
    _itemRowCount = itemRowCount;
    NSAssert(itemRowCount>=1, @"数据源类型不对，itemRowCount至少大于等于1");
}
- (void)setItemSectionCount:(NSInteger)itemSectionCount
{
    _itemSectionCount = itemSectionCount;
    NSAssert(itemSectionCount>=2, @"数据源类型不对，itemSectionCount至少大于等于2");
}
- (NSInteger)hotBrandCycleSectionAtIndex:(NSInteger)section
{
    return self.itemSectionCount;
}
- (NSInteger)hotBrandCycleRowAtIndex:(NSInteger)section
{
    return self.itemRowCount;
}
- (CGFloat)hotBrandCycleItemWidthAtheight:(CGFloat)height
{
    if (self.widthSpace > 0) {
        return height * self.widthSpace;
    }
    return height;
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
- (void)automaticScroll
{
    [super automaticScroll];
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x+self.scrollOffsetX, 0) animated:YES];
}
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
