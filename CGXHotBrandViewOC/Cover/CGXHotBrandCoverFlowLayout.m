//
//  CGXHotBrandCoverFlowLayout.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCoverFlowLayout.h"

#define pMaxScale 1.0//最大的拉伸比例
#define pNormalScale 0.8 //最小的缩放比例
@interface CGXHotBrandCoverFlowLayout ()

@end
@implementation CGXHotBrandCoverFlowLayout

- (void)initializeData
{
    [super initializeData];
}
// 布局之前的准备工作（这个方法只会调用一次）
- (void)prepareLayout
{
    [super prepareLayout];
}
// 当bounds发生变化的时候是否应该重新进行布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
// 这个方法在滚动的过程当中, 系统会根据需求来调用
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 要想计算每个cell的缩放比, 就要先计算出整体的中心点的x值 和 每个cell的中心点的x值
    // 用这两个x值做一个差值, 然后计算出绝对值, 这样就得到了每个cell的中心点的x值和整体中心点的x值之间的距离
    // 根据这个距离就可以计算出一个缩放比
    // 1. 先计算出整体的中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    // 在这个方法中, 我们只要根据当前的滚动, 对每个cell, 进行对应的缩放就可以了
    // 1. 获取所有的attributes对象
    NSArray *arrayAttrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
//    CGSize itemSize = self.itemSize;
    // 2. 循环遍历这些attributes对象, 对每个对象进行缩放
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:attr.indexPath.row inSection:0]];
        // 获取每个cell的中心点的x值
        CGFloat cell_centerX = attr.center.x;
        // 计算这两个中心点的x值的偏移（距离）
        CGFloat absOffset = ABS(cell_centerX - centerX);
        // 如何根据这个距离计算缩放比?
        // 距离越大,缩放比应该越小。距离越小缩放比越大。缩放比最大是1.当两个中心点的x值相等的时候（重合），此时缩放比就是1.
        // 缩放系数
//        CGFloat factor = 0.001;
//        // 记录缩放比
//        CGFloat scale = 1 / (1 + distance * factor);
//        attr.size = CGSizeMake(itemSize.width / itemSize.height * self.collectionView.bounds.size.height, self.collectionView.bounds.size.height);

        CGFloat heightZoom = (self.collectionView.bounds.size.height-itemSize.height)/self.collectionView.bounds.size.height;
        CGFloat scale = 1;
        CGFloat distance = itemSize.width;
        if (absOffset < distance) {
            scale = 1+(1-absOffset/distance)*heightZoom;
        }
        attr.zIndex = 1;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    // 3. 返回修改后的attributes数组
    return arrayAttrs;
}
/**
 *  @param proposedContentOffset 自然滚动的情况下进行的偏移
 *  @param velocity              滚动的速度（poit/second ）点/秒
 *  @return 返回值: 手动指定滚动的偏移（手动指定滚动到什么位置）
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 1. 计算中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    // 2. 计算可视区域
    CGFloat visibleX = proposedContentOffset.x;
    CGFloat visibleY = proposedContentOffset.y;
    CGFloat visibleW = self.collectionView.bounds.size.width;
    CGFloat visibleH = self.collectionView.bounds.size.height;
    // 计算出了可视区域
    CGRect visibleRect = CGRectMake(visibleX, visibleY, visibleW, visibleH);
    // 3. 获取可视区域之内的所有的cell的attribute对象
    NSArray *arrayAttrs = [super layoutAttributesForElementsInRect:visibleRect];
    // 4. 用每个cell的中心点和centerX进行比较, 最终比较出一个距离最短的值
    // 假设第0个元素是最小的
    NSInteger min_idx = 0;
    UICollectionViewLayoutAttributes *min_attr = arrayAttrs[min_idx];
    // 循环arrayAttrs数组, 找出最小值
    for (int i = 1; i < arrayAttrs.count; i++) {
        UICollectionViewLayoutAttributes *attr = arrayAttrs[i];
        if (ABS(attr.center.x - centerX) < ABS(min_attr.center.x - centerX)) {
            min_idx = i;
            min_attr = attr;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandAtCurrentInter:)]) {
        [self.delegate gx_hotBrandAtCurrentInter:min_idx];
    }
    // 5. 计算出距离中心点最小的那个cell 和中心点的偏移
    CGFloat offsetX = min_attr.center.x - centerX;
    // 6. 返回一个新的偏移点
    return CGPointMake(proposedContentOffset.x + offsetX, proposedContentOffset.y);
}

// 滚动时cell的缩放放大比例
- (CGFloat)cellOffsetAtIndex:(NSInteger)index
{
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
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
