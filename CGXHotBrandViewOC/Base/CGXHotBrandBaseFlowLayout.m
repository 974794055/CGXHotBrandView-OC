//
//  CGXHotBrandBaseFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseFlowLayout.h"

@implementation CGXHotBrandBaseFlowLayout

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self initializeData];
    }
    return self;
}
- (void)initializeData
{
    self.itemSectionCount = 2;
    self.itemRowCount = 4;
}
- (void)prepareLayout
{
    [super prepareLayout];
    NSInteger const numberOfSections = self.collectionView.numberOfSections;
    for (int i = 0; i < numberOfSections; i++) {
        // 从collectionView中获取到有多少个item
        NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:i];
        // 遍历出item的attributes,把它添加到管理它的属性数组中去
        for (int j = 0; j < itemTotalCount; j++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [[self layoutAttributesForItemAtIndexPath:indexpath] copy];
            [self.attributesArrayM addObject:attributes];
        }
    }
}

/** 返回collectionView视图中所有视图的属性数组 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArrayM;
}
- (NSMutableArray *)attributesArrayM
{
    if (!_attributesArrayM) {
        _attributesArrayM = [NSMutableArray array];
    }
    return _attributesArrayM;
}
@end


@implementation CGXHotBrandBaseFlowLayout (CGXHotBrandAttributes)

- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return self.minimumInteritemSpacing;
    }
}
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    } else {
        return self.minimumLineSpacing;
    }
}
- (CGSize)gx_referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(0, 0);
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        size = [delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
    } else{
        size = self.headerReferenceSize;
    }
    return size;
}
- (CGSize)gx_referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(0, 0);
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        size = [delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
    } else{
        size = self.footerReferenceSize;
    }
    return size;
}
- (UIEdgeInsets)gx_insetForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    } else {
        return self.sectionInset;
    }
}
- (CGSize)gx_sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    } else {
        return self.itemSize;
    }
}

- (NSInteger)gx_referenceAtSection:(NSInteger)section
{
    CGFloat sectionCount = self.itemSectionCount;
    id <CGXHotBrandBaseFlowLayoutDelegate> delegate  = (id <CGXHotBrandBaseFlowLayoutDelegate>)self.collectionView.delegate;
    if (delegate && [delegate respondsToSelector:@selector(hotBrand_collectionView:layout:SectionAtIndex:)]) {
        sectionCount = [delegate hotBrand_collectionView:self.collectionView layout:self SectionAtIndex:section];
    }
    return sectionCount;
}
- (NSInteger)gx_referenceAtRow:(NSInteger)row
{
    CGFloat count = self.itemRowCount;
    id <CGXHotBrandBaseFlowLayoutDelegate> delegate  = (id <CGXHotBrandBaseFlowLayoutDelegate>)self.collectionView.delegate;
    if (delegate && [delegate respondsToSelector:@selector(hotBrand_collectionView:layout:RowAtIndex:)]) {
        count = [delegate hotBrand_collectionView:self.collectionView layout:self RowAtIndex:row];
    }
    return count;
}
@end
