//
//  CGXHotBrandRotaryView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandRotaryView.h"
#import "CGXHotBrandRotaryCell.h"
#import "CGXHotBrandRotaryFlowLayout.h"
#import "CGXHotBrandTools.h"

@interface CGXHotBrandRotaryView ()<CGXHotBrandRotaryFlowLayoutDelegate>


@property(strong,nonatomic)NSMutableArray<CGXHotBrandModel *> *dataArray;

@property(nonatomic,assign) NSInteger currentSelectInter;

@end

@implementation CGXHotBrandRotaryView

- (NSMutableArray<CGXHotBrandModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)initializeData
{
    [super initializeData];
    self.isHavePage = NO;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.infiniteLoop = YES;
    self.itemScaleFactor = 0.7;
    self.visibleCount = 5;
}
- (void)setVisibleCount:(NSInteger)visibleCount
{
    if (visibleCount < 1) {
        visibleCount = 5;
    }
    _visibleCount = visibleCount;
}
- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.collectionView reloadData];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    CGFloat space = (CGRectGetWidth(self.collectionView.frame)*(1-self.itemScaleFactor)) / 2;
    self.edgeInsets = UIEdgeInsetsMake(0, space, 0, space);
    CGXHotBrandRotaryFlowLayout *layout = (CGXHotBrandRotaryFlowLayout *)[self preferredFlowLayout];
    layout.visibleCount = self.visibleCount;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXHotBrandRotaryFlowLayout *layout = [[CGXHotBrandRotaryFlowLayout alloc] init];
    layout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    layout.minimumLineSpacing = self.minimumLineSpacing;
    layout.sectionInset = self.edgeInsets;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.visibleCount = self.visibleCount;
    layout.carouselDelegate = self;
    return layout;
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandRotaryCell.class;
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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
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
    return CGSizeMake(CGRectGetWidth(self.frame)*self.itemScaleFactor, (CGRectGetHeight(self.frame)-self.edgeInsets.top-self.edgeInsets.bottom));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetHeight(collectionView.frame), 0);
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
}


- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray
{
    if (dataArray.count<=0) {
        return;
    }
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    if (self.dataArray&&self.dataArray.count==1) {
        self.infiniteLoop = NO;
        self.totalInter = self.dataArray.count;
    } else{
        self.totalInter =  self.infiniteLoop?self.dataArray.count*self.groudInter:self.dataArray.count;
    }
    [self.collectionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hotBrand_SlideEnd];
    });
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:ScrollAtPoint:)]) {
        [self.delegate gx_hotBrandBaseView:self ScrollAtPoint:self.collectionView];
    }
    //在滑动过程中获取当前显示的所有cell, 调用偏移量的计算方法
    [[self.collectionView visibleCells] enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(cellOffsetOnCollectionView:)] && [obj conformsToProtocol:@protocol(CGXHotBrandUpdateCellDelegate)]) {
            [(UICollectionViewCell<CGXHotBrandUpdateCellDelegate> *)obj cellOffsetOnCollectionView:self.collectionView];
        }
    }];
    if (self.infiniteLoop) {
        CGFloat itemWidth = CGRectGetWidth(self.frame)*self.itemScaleFactor;
        CGPoint point = CGPointMake(0+(self.totalInter/2*itemWidth*self.itemScaleFactor),self.collectionView.contentOffset.y);
        if (scrollView.contentOffset.x<300) {
            [self.collectionView setContentOffset:point animated:NO];
        }else if (scrollView.contentOffset.x>(self.totalInter*itemWidth)-500){
            [self.collectionView setContentOffset:point animated:NO];
        }
    }
}

/**
 回到屏幕正中间
 */
-(void)hotBrand_SlideEnd
{
    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentOffset.y) animated:NO];
    CGFloat itemWidth = CGRectGetWidth(self.frame)*self.itemScaleFactor;
    CGPoint point = CGPointMake(0+(self.totalInter/2*itemWidth),self.collectionView.contentOffset.y);
    [self.collectionView setContentOffset:point animated:NO];
    CGPoint collectionViewPoint = self.collectionView.contentOffset;
    CGFloat index = roundf((self.collectionView.contentOffset.x+ CGRectGetWidth(self.collectionView.frame) / 2 - itemWidth / 2) /itemWidth);
    collectionViewPoint.x = itemWidth * index + itemWidth / 2 - CGRectGetWidth(self.collectionView.frame) / 2;
    [self.collectionView setContentOffset:collectionViewPoint animated:YES];
    self.currentSelectInter = index;
    [self gx_hotBrandAtCurrentInter:self.currentSelectInter];
}

- (void)gx_hotBrandAtCurrentInter:(NSInteger)currentInter
{
    self.currentSelectInter = currentInter;
    if (!self.dataArray.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int index = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:ScrollEndItemAtIndexPath:AtModel:)]) {
        [self.delegate gx_hotBrandBaseView:self ScrollEndItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] AtModel:cellModel];
    }
}

- (CGXHotBrandModel *)pageIndexWithCurrentCellModelAtIndexPath:(NSIndexPath *)indexPath
{
    [super pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    int rowInter = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    CGXHotBrandModel *cellModel = self.dataArray[rowInter];
    return cellModel;
}
- (int)currentIndex
{
    [super currentIndex];
    if (self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
        return 0;
    }
    int index = (int)self.currentSelectInter;
    return MAX(0, index);
}
- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.dataArray.count;
}
@end
