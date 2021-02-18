//
//  CGXHotBrandCardFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCardFlowLayout.h"

#define pNormalScale 0.8//最小的缩放比例
#define pMaxScale 1.0//最大的拉伸比例

@interface CGXHotBrandCardFlowLayout()

//垂直缩放 数值越大缩放越小
@property(nonatomic,assign) CGFloat wActiveDistance;
@property(nonatomic,assign) CGSize currentCellSize;

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
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }
    if ([self.collectionView numberOfItemsInSection:0] == 0) {
        return;
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat LineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:0];
    CGSize sizeItem = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathWithIndex:0]];
    self.currentCellSize = sizeItem;
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
    for (int i = 0; i<array.count; i++) {
        CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:i];
        CGSize sizeItem = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathWithIndex:i]];
        CGFloat itemWidth = sizeItem.width;
        UICollectionViewLayoutAttributes *attributes = array[i];
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        if (self.itemContentOffsetX!=0.5) {
            distance = CGRectGetMidX(visibleRect) - (attributes.center.x + (0.5-self.itemContentOffsetX)*visibleRect.size.width);
        }
        //垂直缩放 数值越大缩放越小
        CGFloat wActiveDistance = visibleRect.size.height > 0 ? visibleRect.size.height:([UIScreen mainScreen].bounds.size.width);
        CGFloat normalizedDistance = fabs(distance / (1.0*wActiveDistance));
        CGFloat zoom = 1 - self.itemScaleFactor * normalizedDistance;
        
        CGPoint center = CGPointMake(attributes.center.x, attributes.center.y);
        if (self.cellPosition == CGXHotBrandCellPositionBottom) {
   
            center =  CGPointMake(attributes.center.x, attributes.center.y+attributes.size.height*(1-zoom)/2.0);
        }else if (self.cellPosition == CGXHotBrandCellPositionTop) {
            center =  CGPointMake(attributes.center.x, attributes.center.y-attributes.size.height*(1-zoom)/2.0);
        }else if (self.cellPosition == CGXHotBrandCellPositionCenter) {
            
        }
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


// 滚动时cell的缩放放大比例
- (CGFloat)cellOffsetAtIndex:(NSInteger)index
{
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect cellFrameInSuperview = [self.collectionView convertRect:attributes.frame toView:[self.collectionView superview]];
    
    CGSize firstSize = self.currentCellSize;
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
