//
//  CGXHotBrandCycleView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCycleView.h"
#import "CGXHotBrandCycleFlowLayout.h"
#import "CGXHotBrandCycleCell.h"

@interface CGXHotBrandCycleView ()<CGXHotBrandCycleFlowLayoutDelegate>

@property (nonatomic, strong,readwrite) NSMutableArray<CGXHotBrandModel *> *dataArray;

@property (nonatomic, assign) NSInteger totalInter;

@end

@implementation CGXHotBrandCycleView
- (void)initializeData
{
    [super initializeData];
    self.offsetX = 0.5;
    self.totalInter = 11;
    self.widthSpace = 1.0;
    
}
- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.pagingEnabled = NO;
    [self.collectionView reloadData];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.collectionViewLayout = [self preferredFlowLayout];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    NSInteger targetIndex = self.dataArray.count * self.totalInter * 0.5;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [self.collectionView reloadData];
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
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    int rowInter = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    CGXHotBrandModel *cellModel = self.dataArray[rowInter];
    cellModel.loadImageCallback = self.loadImageCallback;
    BOOL isHave = [cell respondsToSelector:@selector(updateWithHotBrandCellModel:Section:Row:)];
    if (isHave == YES && [cell conformsToProtocol:@protocol(CGXHotBrandBaseCellDelegate)]) {
        [(UICollectionViewCell<CGXHotBrandBaseCellDelegate> *)cell updateWithHotBrandCellModel:cellModel Section:indexPath.section Row:indexPath.row];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int rowInter = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    CGXHotBrandModel *cellModel = self.dataArray[rowInter];
    __weak typeof(self) weskSelf = self;
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(weskSelf, cellModel);
    } else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:DidSelectItemAtModel:)]) {
            [self.delegate gx_hotBrandBaseView:self DidSelectItemAtModel:cellModel];
        }
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
        [self.collectionView setContentOffset:CGPointMake(scrollView.contentSize.width-2*itemWW+scrollView.contentOffset.x, 0) animated:NO];
    }
    if (scrollView.contentOffset.x >= itemWW*(self.totalInter-1)) {
        [self.collectionView setContentOffset:CGPointMake(scrollView.contentOffset.x - itemWW*(self.totalInter-1) + 2*itemWW, 0) animated:NO];
    }
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
