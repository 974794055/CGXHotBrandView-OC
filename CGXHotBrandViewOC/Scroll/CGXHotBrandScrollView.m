//
//  CGXHotBrandScrollView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2021/1/4.
//

#import "CGXHotBrandScrollView.h"
#import "CGXHotBrandScrollFlowLayout.h"
#import "CGXHotBrandScrollCell.h"
#import "CGXHotBrandTools.h"
@interface CGXHotBrandScrollView()

@property(assign,nonatomic) BOOL beganDragging;
@property(strong,nonatomic,readwrite)NSMutableArray<CGXHotBrandModel *> *dataArray;

@property(nonatomic,assign)CGFloat last;

@end

@implementation CGXHotBrandScrollView

- (NSMutableArray<CGXHotBrandModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)initializeData
{
    [super initializeData];
    
    self.pageControl.hidesPage = !self.isHavePage;
    
    self.isHaveSpaceBottom = NO;
    self.edgeInsets = UIEdgeInsetsMake(0, 0, self.isHaveSpaceBottom ? self.pageHeight:0, 0);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollType = CGXHotBrandScrollTypeOnlyImage;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.isHavePage = YES;
    self.fadeOpen = NO;
    self.marquee = NO;
    self.marqueeRate = 10;
}
- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.collectionView reloadData];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.edgeInsets = UIEdgeInsetsMake(0, 0, self.isHaveSpaceBottom ? self.pageHeight:0, 0);
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self.collectionView reloadData];
    
    self.collectionView.pagingEnabled = !self.marquee;
    
    
    if (self.collectionView.contentOffset.x == 0 &&  self.totalInter>0 && self.dataArray.count > 0) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = self.totalInter * 0.5;
        }else{
            targetIndex = 0;
        }
        UICollectionViewScrollPosition position = self.scrollDirection;
        if (self.scrollDirection == UICollectionViewScrollPositionCenteredHorizontally) {
            position = UICollectionViewScrollPositionCenteredHorizontally;
        } else{
            position = UICollectionViewScrollPositionCenteredVertically;
        }
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:position animated:NO];
        if (!self.marquee) {
            int rowInter = [self pageControlIndexWithCurrentCellIndex:targetIndex];
            self.pageControl.currentPage = rowInter;
        }
    }
    if (self.scrollType == CGXHotBrandScrollTypeOnlyTitle || self.marquee) {
        self.pageControl.hidesPage = YES;
        self.collectionView.scrollEnabled = NO;
    }
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXHotBrandScrollFlowLayout *layout = [[CGXHotBrandScrollFlowLayout alloc] init];
    layout.scrollDirection = self.scrollDirection;
    return layout;
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandScrollCell.class;
}
- (NSInteger)gx_hotBrandNumberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    [super gx_hotBrandNumberOfSectionsInCollectionView:collectionView];
    return 1;
}
- (NSInteger)gx_hotBrandCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [super gx_hotBrandCollectionView:collectionView numberOfItemsInSection:section];
    return  self.totalInter;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return self.edgeInsets;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame)-self.edgeInsets.left-self.edgeInsets.right ,floor(CGRectGetHeight(collectionView.frame)-self.edgeInsets.top-self.edgeInsets.bottom));
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    //    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    if ([cell isKindOfClass:[CGXHotBrandScrollCell class]]) {
        CGXHotBrandScrollCell *scrollCell = (CGXHotBrandScrollCell *)cell;
        scrollCell.scrollType = self.scrollType;
    }
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    
    if (self.dataArray&&self.dataArray.count==1) {
        self.infiniteLoop = NO;
        self.totalInter = self.dataArray.count;
    } else{
        self.totalInter =  self.infiniteLoop?self.dataArray.count*self.groudInter:self.dataArray.count;
    }
    self.pageControl.numberOfPages = dataArray.count;
    
    
    [self.collectionView reloadData];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (CGXHotBrandModel *)pageIndexWithCurrentCellModelAtIndexPath:(NSIndexPath *)indexPath
{
    [super pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    int rowInter = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    CGXHotBrandModel *cellModel = self.dataArray[rowInter];
    return cellModel;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.dataArray.count) return; // 解决清除timer时偶尔会出现的问题
    if (!self.marquee) {
        int itemIndex = [self currentIndex];
        int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
        self.pageControl.currentPage = indexOnPageControl;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.beganDragging = YES;
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.beganDragging = NO;
    if (self.autoScroll) {
        [self setupTimer];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
    if (!self.marquee) {
        [self fadeAction];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.dataArray.count) return; // 解决清除timer时偶尔会出现的问题
    self.last = scrollView.contentOffset.x;
    int itemIndex = [self currentIndex];
    int index = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:ScrollEndItemAtIndexPath:AtModel:)]) {
        [self.delegate gx_hotBrandBaseView:self ScrollEndItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] AtModel:cellModel];
    }
    if (!self.marquee) {
        [self fadeAction];
    }
    
}

- (void)fadeAction
{
    if (self.fadeOpen) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            int currentIndex = [self currentIndex];
            NSInteger current = MAX(currentIndex, 0);
            BOOL right = NO;
            if (self.scrollDirection == UICollectionViewScrollPositionCenteredVertically) {
                if (self.collectionView.contentOffset.y>self.last) {
                    right = YES;
                }else if (self.collectionView.contentOffset.y<self.last){
                    right = NO;
                }
            }else{
                if (self.collectionView.contentOffset.x>self.last) {
                    right = YES;
                }else if (self.collectionView.contentOffset.x<self.last){
                    right = NO;
                }
            }
            NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
            NSInteger showIndex = MIN(itemsCount-1, MAX(0, current));
            NSInteger hideIndex = right?MAX(showIndex-1, 0):MIN(showIndex+1, itemsCount-1);
            NSIndexPath *showIndexPath = [NSIndexPath indexPathForRow:showIndex inSection:0];
            NSIndexPath *hideIndexPath = [NSIndexPath indexPathForRow:hideIndex inSection:0];
            [CGXHotBrandTools showAninationWithView:[self.collectionView cellForItemAtIndexPath:showIndexPath]];
            [CGXHotBrandTools hideAninationWithView:[self.collectionView cellForItemAtIndexPath:hideIndexPath]];
        });
    }
}
- (void)automaticScroll
{
    [super automaticScroll];
    if (self.dataArray.count == 0) return;
    if (self.beganDragging) return;
    if (self.marquee) {
        BOOL isAnimated = YES;
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            CGFloat OffsetX = self.collectionView.contentOffset.x + self.marqueeRate;
            if (OffsetX >self.collectionView.contentSize.width) {
                OffsetX = self.dataArray.count * CGRectGetWidth(self.collectionView.frame);
                isAnimated = NO;
            }
            [self.collectionView setContentOffset:CGPointMake(OffsetX, 0) animated:isAnimated];
        }else{
            CGFloat OffsetY = self.collectionView.contentOffset.y + self.marqueeRate;
            if (OffsetY >self.collectionView.contentSize.height) {
                OffsetY = self.dataArray.count * CGRectGetHeight(self.collectionView.frame);
                isAnimated = NO;
            }
            [self.collectionView setContentOffset:CGPointMake(0, OffsetY) animated:isAnimated];
        }
    } else{
        int currentIndex = [self currentIndex];
        int targetIndex = currentIndex + 1;
        [self scrollToIndex:targetIndex];
    }
    
}
- (void)scrollToIndex:(int)targetIndex
{
    UICollectionViewScrollPosition position = self.scrollDirection;
    if (self.scrollDirection == UICollectionViewScrollPositionCenteredHorizontally) {
        position = UICollectionViewScrollPositionCenteredHorizontally;
    } else{
        position = UICollectionViewScrollPositionCenteredVertically;
    }
    if (targetIndex >= self.totalInter) {
        if (self.infiniteLoop) {
            targetIndex = self.totalInter * 0.5;
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:position animated:NO];
        }
        return;
    }
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:position animated:YES];
}
- (void)scrollViewScrollToIndex:(NSInteger)index
{
    if (!self.marquee) {
        if (self.autoScroll) {
            [self invalidateTimer];
        }
        if (0 == self.totalInter) return;
        
        [self scrollToIndex:(int)(self.totalInter * 0.5 + index)];
        if (self.autoScroll) {
            [self setupTimer];
        }
    }
}

- (void)setFadeOpen:(BOOL)fadeOpen
{
    _fadeOpen = fadeOpen;
}
- (void)setMarquee:(BOOL)marquee
{
    _marquee = marquee;
    self.collectionView.pagingEnabled = !marquee;
}
- (void)adjustWhenControllerViewWillAppera
{
    if (!self.marquee) {
        long targetIndex = [self currentIndex];
        if (targetIndex < self.totalInter) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }
}


- (int)currentIndex
{
    [super currentIndex];
    if (self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
        return 0;
    }
    int index = 0;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame) * 0.5) / CGRectGetWidth(self.collectionView.frame);
    } else {
        index = (self.collectionView.contentOffset.y + CGRectGetHeight(self.collectionView.frame) * 0.5) / CGRectGetHeight(self.collectionView.frame);
    }
    return MAX(0, index);
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.dataArray.count;
}

- (void)setScrollType:(CGXHotBrandScrollType)scrollType
{
    _scrollType = scrollType;
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    CGXHotBrandScrollFlowLayout *layout = (CGXHotBrandScrollFlowLayout *)[self preferredFlowLayout];
    layout.scrollDirection = scrollDirection;
    self.collectionView.collectionViewLayout = layout;
}
@end
