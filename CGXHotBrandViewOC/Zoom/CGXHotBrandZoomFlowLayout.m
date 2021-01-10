//
//  CGXHotBrandZoomFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandZoomFlowLayout.h"

@interface CGXHotBrandZoomFlowLayout()

@property(nonatomic,assign)CGFloat last;

@property(nonatomic,assign,readwrite) CGSize firstCellSize;
@property(nonatomic,assign,readwrite) NSInteger currentIndex;
@end

@implementation CGXHotBrandZoomFlowLayout

- (void)initializeData
{
    [super initializeData];
}
- (void)prepareLayout {
    [super prepareLayout];
   
}
/** 计算collectionView的滚动范围 */
- (CGSize)collectionViewContentSize
{
    NSInteger const itemTotalCount = [self.collectionView numberOfItemsInSection:0];;
    UIEdgeInsets sectionInsets = [self gx_insetForSectionAtIndex:0];
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:0];
    CGFloat totalWidth = sectionInsets.left + (itemSize.width + minimumLineSpacing) * (itemTotalCount-1) + CGRectGetWidth(self.collectionView.frame) -sectionInsets.right;
    ;
    return CGSizeMake(totalWidth, 0);
}
/*
 获取所有的布局信息
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    if (itemsCount <= 0) {
        return nil;
    }
    NSArray *originalArr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:0];
    UIEdgeInsets sectionInsets = [self gx_insetForSectionAtIndex:0];
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGRect first = CGRectMake(sectionInsets.left + self.collectionView.contentOffset.x, sectionInsets.top + self.collectionView.contentOffset.y, itemSize.width, itemSize.height);
    self.firstCellSize = [self.delegate gx_hotBrandSizeForFirstCell];
    
    self.currentIndex = ceil(self.collectionView.contentOffset.x / (itemSize.width + minimumLineSpacing));
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandZoomScrollEndAtIndex:)]) {
        [self.delegate gx_hotBrandZoomScrollEndAtIndex:self.currentIndex];
    }
    

    CGFloat totalOffset = 0;
    for (UICollectionViewLayoutAttributes *attributes in originalArr) {
        CGRect originFrame = attributes.frame;
        //判断两个矩形是否相交
        if (CGRectIntersectsRect(first, originFrame)) {
            //如果相交，获取两个矩形相交的区域
            CGRect insertRect = CGRectIntersection(first, originFrame);
            attributes.size = CGSizeMake(itemSize.width + (insertRect.size.width / itemSize.width) * (self.firstCellSize.width - itemSize.width), itemSize.height + (insertRect.size.width) / (itemSize.width) * (self.firstCellSize.height - itemSize.height));
            CGFloat currentOffsetX = attributes.size.width - itemSize.width;
            attributes.center = CGPointMake(attributes.center.x + totalOffset + currentOffsetX / 2, attributes.center.y);
            totalOffset = totalOffset + currentOffsetX;
        } else {
            if (CGRectGetMinX(originFrame) >= CGRectGetMaxX(first)) {
                attributes.center = CGPointMake(attributes.center.x + totalOffset, attributes.center.y);
            }
            if (sectionInsets.left != minimumLineSpacing) {
                if (CGRectGetMaxX(originFrame) <= CGRectGetMinX(first)-minimumLineSpacing) {
                    [UIView animateWithDuration:1 animations:^{
                        attributes.center = CGPointMake(attributes.center.x + totalOffset-sectionInsets.left, attributes.center.y);
                    } completion:nil];
                }
            }
        }
    }
    
    self.last = self.collectionView.contentOffset.x;
    
    return originalArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:0];
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat finalPointX = 0;
    NSInteger index = ceil(proposedContentOffset.x / (itemSize.width + minimumLineSpacing));
    finalPointX = (itemSize.width + minimumLineSpacing) * index;
    CGPoint finalPoint = CGPointMake(finalPointX, proposedContentOffset.y);
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandZoomScrollEndAtIndex:)]) {
        [self.delegate gx_hotBrandZoomScrollEndAtIndex:index];
    }
    
    self.currentIndex = index;
    return finalPoint;
}

@end
