//
//  CGXHotBrandView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandView.h"
#import "CGXHotBrandTools.h"
#import "CGXHotBrandFlowlayout.h"
@interface CGXHotBrandView ()<CGXHotBrandFlowlayoutHotDelegate>

@property (nonatomic, strong) NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *dataArray;

@end

@implementation CGXHotBrandView


- (void)setIsAnimation:(BOOL)isAnimation
{
    _isAnimation = isAnimation;
    [self.collectionView reloadData];
}
- (void)initializeData
{
    [super initializeData];
    self.isAnimation = NO;
    self.itemSectionCount = 2;
    self.itemRowCount = 4;
    self.isHavePage = YES;
}
- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.pagingEnabled = self.pagingEnabled;
    [self.collectionView reloadData];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.collectionView reloadData];
}

/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    if (self.pagingEnabled == YES) {
        CGXHotBrandFlowlayout *layout = [[CGXHotBrandFlowlayout alloc] init];
        layout.itemSectionCount = self.itemSectionCount;
        layout.itemRowCount = self.itemRowCount;
        layout.hotDelegate = self;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return layout;
    }else{
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return layout;
    }
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandCell.class;
}
- (NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)setItemRowCount:(NSInteger)itemRowCount
{
    _itemRowCount = itemRowCount;
    NSAssert(itemRowCount>=1, @"数据源类型不对，itemRowCount至少大于等于1");
}
- (void)setItemSectionCount:(NSInteger)itemSectionCount
{
    _itemSectionCount = itemSectionCount;
    NSAssert(itemSectionCount>=1, @"数据源类型不对，itemSectionCount至少大于等于1");
}
- (NSInteger)hotBrandItemSectionAtIndex:(NSInteger)section
{
    return self.itemSectionCount;
}
- (NSInteger)hotBrandItemRowAtIndex:(NSInteger)section
{
    return self.itemRowCount;
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
    return self.dataArray.count;
}
- (NSInteger)gx_hotBrandCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [super gx_hotBrandCollectionView:collectionView numberOfItemsInSection:section];
    NSMutableArray *sectionArr = self.dataArray[section];
    return sectionArr.count;
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
    if (!self.dataArray.count) return;
    NSInteger itemIndex = [self currentIndex];
    self.pageCurrent = itemIndex;
}
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    NSMutableArray *listArr = [CGXHotBrandTools splitArray:dataArray withSubSize:self.itemSectionCount*self.itemRowCount];
    if (self.pagingEnabled) {
        [self.dataArray addObjectsFromArray:listArr];
        self.pagesNumber = listArr.count;
        self.pageCurrent = 0;
        
    }else{
        self.pagesNumber = listArr.count;
        self.pageCurrent = 0;
        [self.dataArray addObject:dataArray];
    }
    self.totalInter = listArr.count;
    [self.collectionView reloadData];
}
// 更新某个item
- (void)updateWithItemModel:(CGXHotBrandModel *)itemModel AtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i<self.dataArray.count; i++) {
        if (indexPath.section == i) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray[i]];
            for (int j = 0; j<array.count; j++) {
                if (indexPath.row == j) {
                    [array replaceObjectAtIndex:j withObject:itemModel];
                    break;;
                }
            }
            [self.dataArray replaceObjectAtIndex:i withObject:array];
            [UIView animateWithDuration:0 animations:^{
                [self.collectionView performBatchUpdates:^{
                    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:i]];
                    [self.collectionView reloadData];
                } completion:nil];
            }];
            break;
        }
    }
}

- (int)currentIndex
{
    [super currentIndex];
    if (self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
        return 0;
    }
    int index = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    return MAX(0, index);
}

- (CGXHotBrandModel *)pageIndexWithCurrentCellModelAtIndexPath:(NSIndexPath *)indexPath
{
    [super pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    NSMutableArray *sectionArr = self.dataArray[indexPath.section];
    CGXHotBrandModel *cellModel = sectionArr[indexPath.row];
    return cellModel;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
