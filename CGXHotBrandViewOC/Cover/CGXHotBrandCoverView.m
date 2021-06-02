//
//  CGXHotBrandCoverView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCoverView.h"
#import "CGXHotBrandCoverCell.h"
#import "CGXHotBrandCoverFlowLayout.h"
#import "CGXHotBrandTools.h"

@interface CGXHotBrandCoverView ()<CGXHotBrandCoverFlowLayoutDelegate>

@property(strong,nonatomic)NSMutableArray<CGXHotBrandModel *> *dataArray;

@property(nonatomic,assign) NSInteger currentSelectInter;
//宽度比例 0.1~1.0之间。 适当设置 default 1:3
@property(nonatomic,assign) CGFloat itemWidthScale;
@end

@implementation CGXHotBrandCoverView

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
    self.infiniteLoop = NO;
    self.itemWidthScale = 1/3.0;
    self.itemHeightScale = 0.9;
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
    CGSize itemSize = CGSizeMake(CGRectGetWidth(self.frame)*self.itemWidthScale, (CGRectGetHeight(self.frame)-self.edgeInsets.top-self.edgeInsets.bottom)*self.itemHeightScale);
    self.edgeInsets = UIEdgeInsetsMake(0, (CGRectGetWidth(self.frame)- itemSize.width)/2.0, 0, (CGRectGetWidth(self.frame)- itemSize.width)/2.0);
    [self.collectionView reloadData];
    if (self.dataArray.count>0) {
        int iiiiii = (int)self.totalInter*0.5;
        if (iiiiii>1) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:iiiiii-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        self.currentSelectInter = iiiiii;
        [self.collectionView performBatchUpdates:^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentSelectInter inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            [self gx_hotBrandAtCurrentInter:self.currentSelectInter];
        } completion:^(BOOL finished) {
            [self.collectionView reloadData];
        }];
        [self gx_hotBrandScrollViewEnd];
    }
}
- (void)setItemWidthScale:(CGFloat)itemWidthScale
{
    _itemWidthScale = itemWidthScale;
}
- (void)setItemHeightScale:(CGFloat)itemHeightScale
{
    _itemHeightScale = itemHeightScale;
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXHotBrandCoverFlowLayout *layout = [[CGXHotBrandCoverFlowLayout alloc] init];
    layout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    layout.minimumLineSpacing = self.minimumLineSpacing;
    layout.sectionInset = self.edgeInsets;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.delegate = self;
    return layout;
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandCoverCell.class;
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
    return CGSizeMake(CGRectGetWidth(collectionView.frame)*self.itemWidthScale, (CGRectGetHeight(collectionView.frame)-self.edgeInsets.top-self.edgeInsets.bottom)*self.itemHeightScale);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self gx_hotBrandScrollViewEnd];
}
- (void)gx_hotBrandScrollViewEnd
{
    // 坐标系转换获得collectionView上面的位于中心的cell
    CGPoint pointInView = [self convertPoint:self.collectionView.center toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointInView];
    NSInteger index = indexPath.row;
    NSArray *arr = [NSArray arrayWithObjects:@(index-2),@(index+2),@(index-1),@(index+1), @(index),nil];
    for (int i = 0; i<arr.count; i++) {
        NSInteger intextt = [arr[i] integerValue];
        if (intextt < self.totalInter &&[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:intextt inSection:0]]) {
            CGXHotBrandCoverCell *cell = (CGXHotBrandCoverCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:intextt inSection:0]];
            [self.collectionView bringSubviewToFront:cell];
        }
    }
    self.currentSelectInter = index;
    //在滑动过程中获取当前显示的所有cell, 调用偏移量的计算方法
    [[self.collectionView visibleCells] enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(cellOffsetOnCollectionView:)] && [obj conformsToProtocol:@protocol(CGXHotBrandUpdateCellDelegate)]) {
            [(UICollectionViewCell<CGXHotBrandUpdateCellDelegate> *)obj cellOffsetOnCollectionView:self.collectionView];
        }
    }];
}

- (void)gx_hotBrandAtCurrentInter:(NSInteger)currentInter
{
    self.currentSelectInter = currentInter;
    if (!self.dataArray.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int selectIndex = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:ScrollEndItemAtIndexPath:AtModel:)]) {
        [self.delegate gx_hotBrandBaseView:self ScrollEndItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0] AtModel:cellModel];
    }
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
    
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
// 更新某个item
- (void)updateWithItemModel:(CGXHotBrandModel *)itemModel AtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0 || indexPath.row >= self.dataArray.count) {
        return;
    }
    [UIView animateWithDuration:0 animations:^{
        [self.collectionView performBatchUpdates:^{
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:itemModel];
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            [self.collectionView reloadData];
        } completion:nil];
    }];
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
