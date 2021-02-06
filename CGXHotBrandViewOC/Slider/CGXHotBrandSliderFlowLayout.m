//
//  CGXHotBrandSliderFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandSliderFlowLayout.h"


@interface CGXHotBrandSliderFlowLayout()

@end
@implementation CGXHotBrandSliderFlowLayout

- (void)initializeData
{
    [super initializeData];
}

- (void)prepareLayout
{
    [super prepareLayout];
    self.visibleItemsCount = 4;
    self.minScale = 0.7;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    if (itemsCount <= 0) {
        return nil;
    }
    NSInteger currentPage = MAX(floor(self.collectionView.contentOffset.x / self.collectionView.bounds.size.width), 0);
    
    NSInteger minVisibleIndex = MAX(currentPage, 0);
    NSInteger contentOffset = (int)self.collectionView.contentOffset.x;
    NSInteger collectionBounds = (int)self.collectionView.bounds.size.width;
    CGFloat offset = contentOffset % collectionBounds;
    CGFloat offsetProgress = offset / self.collectionView.bounds.size.width*1.0f;
    NSInteger maxVisibleIndex = MAX(MIN(itemsCount - 1, currentPage + self.visibleItemsCount), minVisibleIndex);
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (NSInteger i = minVisibleIndex; i<=maxVisibleIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForIndexPath:indexPath currentPage:currentPage offset:offset offsetProgress:offsetProgress];
        [mArr addObject:attributes];
    }
    return mArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForIndexPath:(NSIndexPath *)indexPath
                                                       currentPage:(NSInteger)currentPage
                                                            offset:(CGFloat)offset
                                                    offsetProgress:(CGFloat)offsetProgress
{
    UICollectionViewLayoutAttributes *attributes = [[self layoutAttributesForItemAtIndexPath:indexPath] copy];
    NSInteger visibleIndex = MAX(indexPath.item - currentPage + 1, 0);
    
    CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    UIEdgeInsets edgeInsets = [self gx_insetForSectionAtIndex:indexPath.section];
    CGFloat width = self.collectionView.bounds.size.width - (self.visibleItemsCount - 1)*minimumLineSpacing;
    CGFloat height = self.collectionView.bounds.size.height-edgeInsets.top-edgeInsets.bottom;
    CGSize topItemSize = CGSizeMake(width, height);
    
    attributes.size = topItemSize;
    
    CGFloat topCardMidX = self.collectionView.contentOffset.x + topItemSize.width / 2;
    attributes.center = CGPointMake(topCardMidX + minimumLineSpacing * (visibleIndex - 1), self.collectionView.bounds.size.height/2);
    attributes.zIndex = 1000 - visibleIndex;
    CGFloat scale = [self parallaxProgressForVisibleIndex:visibleIndex offsetProgress:offsetProgress minScale:self.minScale];
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (visibleIndex == 1) {
        if (self.collectionView.contentOffset.x >= 0) {
            attributes.center = CGPointMake(attributes.center.x - offset, attributes.center.y);
        }else{
            attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - minimumLineSpacing * offsetProgress, attributes.center.y);
        }
    } else if (visibleIndex == self.visibleItemsCount+1){
        attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - minimumLineSpacing, attributes.center.y);
    } else{
        attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - minimumLineSpacing * offsetProgress, attributes.center.y);
    }
    return attributes;
}

- (CGFloat)parallaxProgressForVisibleIndex:(NSInteger)visibleIndex
                            offsetProgress:(CGFloat)offsetProgress
                                  minScale:(CGFloat)minScale
{
    CGFloat step = (1.0 - minScale) / (self.visibleItemsCount-1)*1.0;
    return (1.0 - (visibleIndex - 1) * step + step * offsetProgress);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGSize)collectionViewContentSize
{
   NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(self.collectionView.bounds.size.width * itemsCount, self.collectionView.bounds.size.height);
}
@end
