//
//  CGXHotBrandFlowlayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandFlowlayout.h"

@implementation CGXHotBrandFlowlayout

- (void)initializeData
{
    [super initializeData];
}
/** 计算collectionView的滚动范围 */
- (CGSize)collectionViewContentSize {
    
    NSInteger const numberOfSections = self.collectionView.numberOfSections;
    CGFloat totalWidth = 0;
    for (int i = 0; i < numberOfSections; i++) {
        CGFloat columnSpacing = [self gx_minimumLineSpacingForSectionAtIndex:i];
        UIEdgeInsets edgeInsets = [self gx_insetForSectionAtIndex:i];
        NSInteger sectionCount = [self gx_referenceAtSection:i];
        NSInteger rowCount = [self gx_referenceAtRow:i];

        CGSize sizeItem = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathWithIndex:i]];
        CGFloat itemWidth = sizeItem.width;
//        CGFloat itemHeight = sizeItem.height;
        
        // 从collectionView中获取到有多少个item
        NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:i];
        // 理论上每页展示的item数目
        NSInteger itemCount = sectionCount * rowCount;
        // 余数（用于确定最后一页展示的item个数）
        NSInteger remainder = itemTotalCount % itemCount;
        // 除数（用于判断页数）
        NSInteger pageNumber = itemTotalCount / itemCount;
        // 总个数小于sectionCount * rowCount
        if (itemTotalCount <= itemCount) {
            pageNumber = 1;
        }else {
            if (remainder == 0) {
                pageNumber = pageNumber;
            }else {
                // 余数不为0,除数加1
                pageNumber = pageNumber + 1;
            }
        }
        CGFloat width = 0;
        // 考虑特殊情况(当item的总个数不是sectionCount * rowCount的整数倍,并且余数小于每行展示的个数的时候)
        if (pageNumber > 1 && remainder != 0 && remainder < rowCount) {
            width = edgeInsets.left + (pageNumber - 1) * rowCount * (itemWidth + columnSpacing) + remainder * itemWidth + (remainder - 1)*columnSpacing + edgeInsets.right;
        }else {
            width = edgeInsets.left + pageNumber * rowCount * (itemWidth + columnSpacing) - columnSpacing + edgeInsets.right;
        }
        totalWidth += width;
    }
    // 只支持水平方向上的滚动
    return CGSizeMake(totalWidth, 0);
}

/** 设置每个item的属性(主要是frame) */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat columnSpacing = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    CGFloat rowSpacing = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    UIEdgeInsets edgeInsets = [self gx_insetForSectionAtIndex:indexPath.section];
    NSInteger sectionCount = [self gx_referenceAtSection:indexPath.section];
    NSInteger rowCount = [self gx_referenceAtRow:indexPath.section];

    CGSize sizeItem = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathWithIndex:indexPath.section]];
    CGFloat itemWidth = sizeItem.width;
    CGFloat itemHeight = sizeItem.height;
    
    NSInteger item = indexPath.item;
    // 当前item所在的页
    NSInteger pageNumber = item / (sectionCount * rowCount);
    NSInteger x = item % rowCount + pageNumber * rowCount;
    NSInteger y = item / rowCount;
    
    // 计算出item的坐标
    CGFloat itemX = edgeInsets.left + (itemWidth + columnSpacing) * x + indexPath.section * self.collectionView.frame.size.width;
    CGFloat itemY = edgeInsets.top + (itemHeight + rowSpacing) * y;
    
    UICollectionViewLayoutAttributes *attributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    // 每个item的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    return attributes;
}

@end
