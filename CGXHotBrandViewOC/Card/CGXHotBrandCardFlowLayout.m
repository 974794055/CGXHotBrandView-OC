//
//  CGXHotBrandCardFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCardFlowLayout.h"
@interface CGXHotBrandCardFlowLayout(){
    CGSize factItemSize;
}
//垂直缩放 数值越大缩放越小
@property(nonatomic,assign) CGFloat wActiveDistance;

@end
@implementation CGXHotBrandCardFlowLayout

- (void)initializeData
{
    [super initializeData];
        self.itemContentOffsetX = 0.5;
        self.itemAlpha = 1;
        self.cellPosition = CGXHotBrandCellPositionCenter;
        self.itemScaleFactor = 0.7;
        self.wActiveDistance = [UIScreen mainScreen].bounds.size.width;
        self.itemIsZoom = YES;
}
- (void)prepareLayout
{
    [super prepareLayout];
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat LineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:0];
    CGSize sizeItem = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathWithIndex:0]];
    NSInteger currentInter = round ((ABS(self.collectionView.contentOffset.x))/(sizeItem.width + LineSpacing));
    
    if (self.cardDelegate && [self.cardDelegate respondsToSelector:@selector(gx_hotBrandAtCurrentInter:)]) {
        [self.cardDelegate gx_hotBrandAtCurrentInter:currentInter];
    }
    
    NSArray *array = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    if (!self.itemIsZoom) {
        return array;
    }
    CGRect  visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    NSMutableArray *marr = [NSMutableArray new];
//    NSInteger minIndex = 0;
//    CGFloat minCenterX = [(UICollectionViewLayoutAttributes*)array.firstObject center].x;
//    for (int i = 0; i<array.count; i++) {
//        UICollectionViewLayoutAttributes *attributes = array[i];
//        CGRect cellFrameInSuperview = [self.collectionView convertRect:attributes.frame toView:self.collectionView.superview];
//        if (cellFrameInSuperview.origin.x>=0&&
//            cellFrameInSuperview.origin.x<=self.collectionView.frame.size.width) {
//            if (minCenterX>cellFrameInSuperview.origin.x) {
//                minCenterX = cellFrameInSuperview.origin.x;
//                minIndex = i;
//            }
//        }
//    }
//    CGXHotBrandDebugLog(@"哈哈哈糊诶额：%ld",minIndex);
    
    for (int i = 0; i<array.count; i++) {
        CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:i];
        CGSize sizeItem = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathWithIndex:i]];
        CGFloat itemWidth = sizeItem.width;
        UICollectionViewLayoutAttributes *attributes = array[i];
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        if (self.itemContentOffsetX!=0.5) {
            distance = CGRectGetMidX(visibleRect) - (attributes.center.x + (0.5-self.itemContentOffsetX)*visibleRect.size.width);
        }
        CGFloat wActiveDistance = visibleRect.size.height > 0 ? visibleRect.size.height:([UIScreen mainScreen].bounds.size.width);
        CGFloat normalizedDistance = fabs(distance / (1.0*wActiveDistance));
        CGFloat zoom = 1 - self.itemScaleFactor * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
       
        if (self.itemAlpha<1) {
            CGFloat collectionCenter =  self.collectionView.frame.size.width / 2 ;
            CGFloat offset = self.collectionView.contentOffset.x ;
            CGFloat normalizedCenter =  attributes.center.x - offset;
            CGFloat maxDistance = (itemWidth) + minimumLineSpacing;
            CGFloat distance1 = MIN(fabs(collectionCenter - normalizedCenter), maxDistance);
            CGFloat ratio = (maxDistance - distance1) / maxDistance;
            CGFloat alpha = ratio * (1 - self.itemAlpha) +self.itemAlpha;
            attributes.alpha = alpha;
        }
        CGPoint center = CGPointMake(attributes.center.x, attributes.center.y);
        if (self.cellPosition == CGXHotBrandCellPositionBottom) {
            center =  CGPointMake(attributes.center.x, attributes.center.y+attributes.size.height*(1-zoom));
//            attributes.center = center;
        }else if (self.cellPosition == CGXHotBrandCellPositionTop) {
            center =  CGPointMake(attributes.center.x, attributes.center.y - attributes.size.height*(1-zoom));
//            attributes.center = center;
        }else if (self.cellPosition == CGXHotBrandCellPositionCenter) {
//            attributes.center = center;
        }
        attributes.center = center;
        [marr addObject:attributes];
    }
    return marr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return ![self.collectionView isPagingEnabled];
}
/**
 * collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    if ([self.collectionView isPagingEnabled]) {
        return proposedContentOffset;
    }
    CGFloat offSetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = (CGFloat) (proposedContentOffset.x + self.collectionView.frame.size.width * self.itemContentOffsetX);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x,0.0,self.collectionView.bounds.size.width,self.collectionView.bounds.size.height);
   
    NSArray *attributes = [self layoutAttributesForElementsInRect:targetRect];
    NSPredicate *cellAttributesPredicate = [NSPredicate predicateWithBlock: ^BOOL(UICollectionViewLayoutAttributes * _Nonnull evaluatedObject,NSDictionary<NSString *,id> * _Nullable bindings){
        return (evaluatedObject.representedElementCategory == UICollectionElementCategoryCell);
    }];
    
    NSArray *cellAttributes = [attributes filteredArrayUsingPredicate: cellAttributesPredicate];
    UICollectionViewLayoutAttributes *currentAttributes;
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in cellAttributes){
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offSetAdjustment)){
            currentAttributes   = layoutAttributes;
            offSetAdjustment    = itemHorizontalCenter - horizontalCenter;
        }
    }
    CGFloat nextOffset          = proposedContentOffset.x + offSetAdjustment;
    proposedContentOffset.x     = nextOffset;
    CGFloat deltaX              = proposedContentOffset.x - self.collectionView.contentOffset.x;
    CGFloat velX                = velocity.x;
    if (fabs(deltaX) <= FLT_EPSILON || fabs(velX) <= FLT_EPSILON || (velX > 0.0 && deltaX > 0.0) || (velX < 0.0 && deltaX < 0.0)){
        
    }else if (velocity.x > 0.0){
        NSArray *revertedArray = [[attributes reverseObjectEnumerator] allObjects];
        BOOL found = YES;
        float proposedX = 0.0;
        for (UICollectionViewLayoutAttributes *layoutAttributes in revertedArray){
            if(layoutAttributes.representedElementCategory == UICollectionElementCategoryCell){
                CGFloat itemHorizontalCenter = layoutAttributes.center.x;
                if (itemHorizontalCenter > proposedContentOffset.x) {
                    found = YES;
                    proposedX = nextOffset + (currentAttributes.frame.size.width / 2) + (layoutAttributes.frame.size.width / 2);
                } else {
                    break;
                }
            }
        }
        if (found) {
            proposedContentOffset.x = proposedX;
            CGFloat wLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:currentAttributes.indexPath.section];
            proposedContentOffset.x += wLineSpacing;
        }
    }else if (velocity.x < 0.0){
        for (UICollectionViewLayoutAttributes *layoutAttributes in cellAttributes){
            CGFloat wLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:layoutAttributes.indexPath.section];
            CGFloat itemHorizontalCenter = layoutAttributes.center.x;
            if (itemHorizontalCenter > proposedContentOffset.x)
            {
                proposedContentOffset.x = nextOffset - ((currentAttributes.frame.size.width / 2) + (layoutAttributes.frame.size.width / 2));
                proposedContentOffset.x -= wLineSpacing;
                break;
            }
        }
    }
    proposedContentOffset.y = 0.0;
    return proposedContentOffset;
}

@end
