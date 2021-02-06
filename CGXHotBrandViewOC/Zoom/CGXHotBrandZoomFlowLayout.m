//
//  CGXHotBrandZoomFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandZoomFlowLayout.h"
#define pMaxScale 1.0//最大的拉伸比例
#define pNormalScale 0.7 //最小的缩放比例
@interface CGXHotBrandZoomFlowLayout()

@property(nonatomic,assign) CGSize firstCellSize;

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
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:0];
    CGFloat totalWidth = (itemSize.width + minimumLineSpacing) * (itemTotalCount-1) + CGRectGetWidth(self.collectionView.frame);
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
    
//   NSInteger currentIndex = ceil(self.collectionView.contentOffset.x / (itemSize.width + minimumLineSpacing));
//    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandZoomScrollEndAtIndex:)]) {
//        [self.delegate gx_hotBrandZoomScrollEndAtIndex:currentIndex];
//    }
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
                        attributes.center = CGPointMake(attributes.center.x - sin(M_PI_2)*minimumLineSpacing, attributes.center.y);
                    } completion:nil];
                }
            }
        }
        
    }
    return originalArr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:0];
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat finalPointX = 0;
    NSInteger index = ceil(proposedContentOffset.x / (itemSize.width+ minimumLineSpacing));
    finalPointX = (itemSize.width+ minimumLineSpacing)*index;
    CGPoint finalPoint = CGPointMake(finalPointX, proposedContentOffset.y);
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandZoomScrollEndAtIndex:)]) {
        [self.delegate gx_hotBrandZoomScrollEndAtIndex:index];
    }
    return finalPoint;
}


- (CGFloat)cellOffsetAtIndex:(NSInteger)index
{
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect cellFrameInSuperview = [self.collectionView convertRect:attributes.frame toView:[self.collectionView superview]];
    
    CGSize firstSize = self.firstCellSize;
    UIEdgeInsets edgeInsets = [self gx_insetForSectionAtIndex:0];
    
    CGFloat preferXoffset = firstSize.width / 2 +edgeInsets.left;//距离collectionView左边间距为此值时视图恢复正常大小
    
    CGFloat itemGaps = 0.0;//item的间距
    
    CGFloat itemXoffset = cellFrameInSuperview.origin.x;
    
    CGFloat animationMinOffset = -(cellFrameInSuperview.size.width - (preferXoffset-cellFrameInSuperview.size.width/2-itemGaps));//item子视图开始动画的最小x偏移量
    
    CGFloat animationMaxOffset = preferXoffset + cellFrameInSuperview.size.width/2 + itemGaps;//item子视图开始动画的最大x偏移量
    
    CGFloat normalOffset = preferXoffset - cellFrameInSuperview.size.width/2;//item子视图为1倍大小时的x方向偏移量
    
    CGFloat needScale = 0;
    if (itemXoffset > animationMinOffset && itemXoffset < animationMaxOffset) {
        if (itemXoffset<normalOffset) {//开始缩小
            CGFloat config = normalOffset - animationMinOffset;
            needScale =(itemXoffset-animationMinOffset)/config*(pMaxScale-pNormalScale)+pNormalScale;
        }else if (itemXoffset>normalOffset){//开始缩小
            CGFloat config = animationMaxOffset - normalOffset;
            needScale =(animationMaxOffset-itemXoffset)/config*(pMaxScale-pNormalScale)+pNormalScale;
        }else{//恢复正常(最大)
            needScale = pMaxScale;
        }
    }else{
        needScale = pNormalScale;
    }
    return needScale;
}

@end
