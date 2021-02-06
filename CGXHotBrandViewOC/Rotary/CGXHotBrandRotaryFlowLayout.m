//
//  CGXHotBrandRotaryFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandRotaryFlowLayout.h"

#define INTERSPACEPARAM  0.6
@interface CGXHotBrandRotaryFlowLayout ()
{
   CGFloat _viewHeight;
   CGFloat _itemHeight;
}
@property (nonatomic, assign) CGFloat lastDirectionIndex;
@property (nonatomic, assign) CGFloat slidDistance;
@property (nonatomic, strong) NSIndexPath *lastIndexOne;

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
    _viewHeight = CGRectGetWidth(self.collectionView.frame);
    _itemHeight = itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, (_viewHeight - _itemHeight) / 2, 0, (_viewHeight - _itemHeight) / 2);
}

- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(cellCount * _itemHeight, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat centerY = self.collectionView.contentOffset.x + _viewHeight / 2;
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
    
    CGFloat cY = self.collectionView.contentOffset.x + _viewHeight / 2;
    CGFloat attributesY = _itemHeight * indexPath.row + _itemHeight / 2;
    attributes.zIndex = -ABS(attributesY - cY);
    
    CGFloat delta = cY - attributesY;
    CGFloat ratio =  - delta / (_itemHeight * 2);
    CGFloat scale = 1 - ABS(delta) / (_itemHeight * 6) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat centerY = attributesY;
    switch (self.carouselAnim) {
        case HJCarouselAnimRotary:
            attributes.transform = CGAffineTransformRotate(attributes.transform, ratio * M_PI_2);
            centerY += sin(ratio * M_PI_4) * _itemHeight / 4;
            break;
        case HJCarouselAnimCarousel:
            centerY = cY + sin(ratio * M_PI_2) * _itemHeight * INTERSPACEPARAM;
            break;
        case HJCarouselAnimCoverFlow: {
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -1.0/1200.0f;
            transform = CATransform3DRotate(transform, ratio * M_PI_4, 0, 0, 1);
            attributes.transform3D = transform;
        }
            break;
        default:
            break;
    }
    attributes.center = CGPointMake(centerY, CGRectGetHeight(self.collectionView.frame) / 2);
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat index = roundf((proposedContentOffset.x + _viewHeight / 2 - _itemHeight / 2) / _itemHeight);
    proposedContentOffset.x = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(gx_hotBrandAtCurrentInter:)]) {
        [self.carouselDelegate gx_hotBrandAtCurrentInter:index];
    }
    return proposedContentOffset;
}
//判断滑动的方向(yes往左，no为右)；
-(BOOL)judgeDirection:(CGFloat )index{
    if (self.lastDirectionIndex>index) {
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}
@end
