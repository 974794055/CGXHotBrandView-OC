//
//  CGXHotBrandRotaryFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandRotaryFlowLayout.h"

#define pMaxScale 1.0//最大的拉伸比例
#define pNormalScale 0.8 //最小的缩放比例

@interface CGXHotBrandRotaryFlowLayout ()
{
   CGFloat _itemHeight;
}

@end

@implementation CGXHotBrandRotaryFlowLayout

- (void)initializeData
{
    [super initializeData];
}
- (void)prepareLayout {
    [super prepareLayout];
    if (self.visibleCount < 1) {
        self.visibleCount = 5;
    }
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }
    if ([self.collectionView numberOfItemsInSection:0] == 0) {
        return;
    }
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    _itemHeight = itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, (CGRectGetWidth(self.collectionView.frame) - _itemHeight) / 2, 0, (CGRectGetWidth(self.collectionView.frame) - _itemHeight) / 2);
}

- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(cellCount * _itemHeight, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat centerY = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame) / 2;
    NSInteger index = centerY / _itemHeight;
    NSInteger count = (self.visibleCount - 1) / 2;
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    attributes.size = itemSize;
    
    CGFloat cY = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame) / 2;
    CGFloat attributesY = _itemHeight * indexPath.row + _itemHeight / 2;
    attributes.zIndex = -ABS(attributesY - cY);
    
    CGFloat delta = cY - attributesY;
    CGFloat ratio =  - delta / (_itemHeight * 2);
    CGFloat scale = 1 - ABS(delta) / (_itemHeight * 6) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);

    CGFloat centerY = attributesY;
    centerY = cY + sin(ratio * M_PI_2) * _itemHeight * 0.8;

    
//            attributes.transform = CGAffineTransformRotate(attributes.transform, ratio * M_PI_2);
//            centerY += sin(ratio * M_PI_4) * _itemHeight / 4;
//            break;

//            CATransform3D transform = CATransform3DIdentity;
//            transform.m34 = -1.0/6.0f;
//            transform = CATransform3DRotate(transform, ratio * M_PI_4, 0, 0, 1);
//            attributes.transform3D = transform;

    attributes.center = CGPointMake(centerY, CGRectGetHeight(self.collectionView.frame) / 2);
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat index = roundf((proposedContentOffset.x + CGRectGetWidth(self.collectionView.frame) / 2 - _itemHeight / 2) / _itemHeight);
    proposedContentOffset.x = _itemHeight * index + _itemHeight / 2 - CGRectGetWidth(self.collectionView.frame) / 2;
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(gx_hotBrandAtCurrentInter:)]) {
        [self.carouselDelegate gx_hotBrandAtCurrentInter:index];
    }
    return proposedContentOffset;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

// 滚动时cell的缩放放大比例
- (CGFloat)cellOffsetAtIndex:(NSInteger)index
{
    UICollectionViewLayoutAttributes *attributes = [[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]] copy];
    CGRect cellFrameInSuperview = [self.collectionView convertRect:attributes.frame toView:[self.collectionView superview]];
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:attributes.indexPath.row inSection:0]];
    CGSize firstSize = itemSize;
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
