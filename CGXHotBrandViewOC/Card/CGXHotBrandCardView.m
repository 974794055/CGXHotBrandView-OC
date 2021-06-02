//
//  CGXHotBrandCardView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCardView.h"
#import "CGXHotBrandCardFlowLayout.h"

#import "CGXHotBrandCardCell.h"
#import "CGXHotBrandBlurEffectView.h"
@interface CGXHotBrandCardView()<CGXHotBrandCardFlowLayoutDelegate>
{
    BOOL beganDragging;
    
}
@property(strong,nonatomic)NSMutableArray<CGXHotBrandModel *> *dataArray;

//默认移动到第几个 default 0
@property(nonatomic,assign)NSInteger currentSelectInter;

@property(nonatomic,strong) CGXHotBrandBlurEffectView *effectView;

@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *bottomView;

@end

@implementation CGXHotBrandCardView


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
    self.itemWidthScale = 0.5;
    self.itemContentOffsetX = 0.5;
    self.currentSelectInter = 0;
    self.itemScaleFactor = 0.5;
    self.itemAlpha = 1;
    self.itemClickCenter = YES;
    self.isHavePage = YES;
    self.bounces = YES;
    self.itemEffect = NO;
    self.itemEffectHeight = 1;
    self.itemEffectAlpha = 1;
    
    self.itemSpaceTop = 0;
    self.itemSpaceBottom = 0;
    
    self.edgeInsets = UIEdgeInsetsMake(0, self.frame.size.width*self.itemWidthScale/2, 0, self.frame.size.width*self.itemWidthScale/2);
    
}
- (void)initializeViews
{
    [super initializeViews];
    
    self.hidesPage = !self.isHavePage;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.effectView = [[CGXHotBrandBlurEffectView alloc] init];
    [self addSubview:self.effectView];
    [self sendSubviewToBack:self.effectView];
    self.effectView.hidden = self.itemEffect;
    self.collectionView.collectionViewLayout = [self preferredFlowLayout];;;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}
- (void)setDataSource:(id<CGXHotBrandCardViewDataSource>)dataSource
{
    _dataSource = dataSource;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gx_hotBrandCardTopView:)]) {
        self.topView = [[UIView alloc] init];
        [self addSubview:self.topView];
        [self bringSubviewToFront:self.topView];
        UIView *topView = [self.dataSource gx_hotBrandCardTopView:self];;
        [self.topView addSubview:topView];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gx_hotBrandCardBottomView:)]) {
        self.bottomView = [[UIView alloc] init];
        [self addSubview:self.bottomView];
        [self bringSubviewToFront:self.bottomView];
        UIView *bottomView = [self.dataSource gx_hotBrandCardBottomView:self];
        [self.bottomView addSubview:bottomView];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.topView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.itemSpaceTop);
    self.bottomView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-self.itemSpaceBottom, CGRectGetWidth(self.frame), self.itemSpaceBottom);
    
    self.collectionView.frame = CGRectMake(0, self.itemSpaceTop, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.itemSpaceTop-self.itemSpaceBottom);;
    
    self.effectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*self.itemEffectHeight);
    self.effectView.itemEffectAlpha = self.itemEffectAlpha;
    self.effectView.hidden = self.itemEffect;
    
    self.collectionView.pagingEnabled = (CGRectGetWidth(self.collectionView.frame)*self.itemWidthScale == self.collectionView.frame.size.width && self.minimumLineSpacing == 0);
    
    self.collectionView.collectionViewLayout = [self preferredFlowLayout];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    
    
    if (self.collectionView.contentOffset.x == 0 &&  self.totalInter>0 && self.dataArray.count > 0) {
        if (self.infiniteLoop) {
            self.currentSelectInter = self.totalInter * 0.5;
        }else{
            self.currentSelectInter = 0;
        }
        [self scrolToPath:[NSIndexPath indexPathForRow:self.currentSelectInter inSection:0] animated:NO];
        [self scrollEnd:[NSIndexPath indexPathForRow:self.currentSelectInter inSection:0]];
    }
    [self.collectionView reloadData];
    
    
    //在滑动过程中获取当前显示的所有cell, 调用偏移量的计算方法
    [[self.collectionView visibleCells] enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(cellOffsetOnCollectionView:)] && [obj conformsToProtocol:@protocol(CGXHotBrandUpdateCellDelegate)]) {
            [(UICollectionViewCell<CGXHotBrandUpdateCellDelegate> *)obj cellOffsetOnCollectionView:self.collectionView];
        }
    }];
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXHotBrandCardFlowLayout *layout = [[CGXHotBrandCardFlowLayout alloc] init];
    layout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    layout.minimumLineSpacing = self.minimumLineSpacing;
    layout.sectionInset = self.edgeInsets;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemScaleFactor = self.itemScaleFactor;
    layout.itemContentOffsetX = self.itemContentOffsetX;
    layout.itemAlpha = self.itemAlpha;
    layout.itemIsZoom = self.itemIsZoom;
    layout.cellPosition = self.cellPosition;
    layout.cardDelegate = self;
    return layout;
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandCardCell.class;
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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat leftSpace = self.edgeInsets.left;
    CGFloat rightSpace = self.edgeInsets.right;
    if (self.itemContentOffsetX == 0.5) {
        leftSpace = (CGRectGetWidth(self.collectionView.frame) * (1-self.itemWidthScale)) / 2.0;
        rightSpace = (CGRectGetWidth(self.collectionView.frame) * (1-self.itemWidthScale)) / 2.0;
    }
    if (self.itemContentOffsetX > 0.5) {
        leftSpace = (self.itemContentOffsetX-self.itemWidthScale/2.0) * CGRectGetWidth(collectionView.frame);
        rightSpace = (1-self.itemContentOffsetX-self.itemWidthScale/2.0) * CGRectGetWidth(collectionView.frame);
    }
    if (self.itemContentOffsetX < 0.5) {
        CGFloat compareSpace = self.itemContentOffsetX - self.itemWidthScale/2.0;
        if (compareSpace > 0) {
            leftSpace = CGRectGetWidth(self.collectionView.frame) * compareSpace;
            rightSpace = (CGRectGetWidth(self.collectionView.frame) * (self.itemContentOffsetX + self.itemWidthScale/2.0));
        } else if (compareSpace < 0){
            leftSpace = CGRectGetWidth(self.collectionView.frame) * compareSpace;;
            rightSpace = (CGRectGetWidth(self.collectionView.frame) * (1-self.itemContentOffsetX - self.itemWidthScale/2.0));
        } else{
            leftSpace = 0;
            rightSpace = (CGRectGetWidth(self.collectionView.frame) * (1-self.itemWidthScale));
        }
    }
    
    return UIEdgeInsetsMake(self.edgeInsets.top, leftSpace, self.edgeInsets.bottom, rightSpace);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame)*self.itemWidthScale, CGRectGetHeight(collectionView.frame)-self.edgeInsets.top-self.edgeInsets.bottom);
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    //    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:indexPath];
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    //    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    BOOL center = [self checkCellInCenterCollectionView:collectionView AtIndexPath:indexPath];
    //   UICollectionViewCell *currentCell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.itemClickCenter) {
        if (!center) {
            NSArray *visibleCellIndex = [collectionView visibleCells];
            NSArray *sortedIndexPaths = [visibleCellIndex sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSIndexPath *path1 = (NSIndexPath *)[collectionView indexPathForCell:obj1];
                NSIndexPath *path2 = (NSIndexPath *)[collectionView indexPathForCell:obj2];
                return [path1 compare:path2];
            }];
            if (sortedIndexPaths.count>0) {
                NSInteger center = sortedIndexPaths.count/2;
                UICollectionViewCell *tmpCell = [collectionView cellForItemAtIndexPath:indexPath];
                for (int i = 0; i < sortedIndexPaths.count; i++) {
                    UICollectionViewCell *cell = sortedIndexPaths[i];
                    if (cell == tmpCell) {
                        if(self.itemContentOffsetX>0.5 || self.itemContentOffsetX<0.5){
                            if (i==center) {
                                [self scrolCenterAtIndex:indexPath.row Center:center];
                            }
                        }else {
                            [self scrolCenterAtIndex:indexPath.row Center:center];
                        }
                        if (i>center || i<center) {
                            [self scrolCenterAtIndex:indexPath.row Center:center];
                        }
                        break;
                    }
                }
            }
        }
    }
}
- (void)scrolCenterAtIndex:(NSInteger)index Center:(BOOL)center;
{
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    self.currentSelectInter = index;
    [self scrolToPath:nextIndexPath animated:YES];
    [self.collectionView setUserInteractionEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView setUserInteractionEnabled:YES];
    });
}
/*
 检测是否是中间的cell 当前判断依据为最大的cell 如果cell大小一样 那么取显示的first第一个
 */
- (BOOL)checkCellInCenterCollectionView:(UICollectionView *)collectionView AtIndexPath:(NSIndexPath *)indexPath{
    BOOL center = NO;
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableArray *indexArr = [NSMutableArray new];
    for (int i = 0; i<[collectionView visibleCells].count; i++) {
        UICollectionViewCell *cell = [collectionView visibleCells][i];
        [arr addObject:[NSString stringWithFormat:@"%.0f",cell.frame.size.height]];
        [indexArr addObject:cell];
    }
    
    float max = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];
    
    NSInteger cellIndex = [arr indexOfObject:[NSString stringWithFormat:@"%.0f",max]];
    if (cellIndex == NSNotFound) {
        if (arr.count%2 == 0) {
            cellIndex = arr.count/2 ;
        }else{
            cellIndex = arr.count/2+1 ;
        }
    }
    if (cellIndex<indexArr.count) {
        UICollectionViewCell *cell = indexArr[cellIndex];
        UICollectionViewCell *currentCell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell == currentCell) {
            center = YES;
        }
    }
    if (self.currentSelectInter == indexPath.row) {
        center = YES;
    }
    return center;
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
    self.pagesNumber = dataArray.count;
    self.pageCurrent = 0;
    [self.collectionView reloadData];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
// 更新某个item
- (void)updateWithItemModel:(CGXHotBrandModel *)itemModel AtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0 || indexPath.row >= self.totalInter) {
        return;
    }
    [UIView animateWithDuration:0 animations:^{
        [self.collectionView performBatchUpdates:^{
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:itemModel];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            [self.collectionView reloadData];
        } completion:nil];
    }];
}
//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beganDragging = YES;
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:ScrollAtPoint:)]) {
        [self.delegate gx_hotBrandBaseView:self ScrollAtPoint:self.collectionView];
    }
    //在滑动过程中获取当前显示的所有cell, 调用偏移量的计算方法
    [[self.collectionView visibleCells] enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(cellOffsetOnCollectionView:)] && [obj conformsToProtocol:@protocol(CGXHotBrandUpdateCellDelegate)]) {
            [(UICollectionViewCell<CGXHotBrandUpdateCellDelegate> *)obj cellOffsetOnCollectionView:self.collectionView];
        }
    }];
}
//拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    beganDragging = NO;
    if (self.autoScroll) {
        [self setupTimer];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
    [self scrollEnd:[NSIndexPath indexPathForRow:self.currentSelectInter inSection:0]];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollEnd:[NSIndexPath indexPathForRow:self.currentSelectInter inSection:0]];
}
- (void)gx_hotBrandAtCurrentInter:(NSInteger)currentInter
{
    self.currentSelectInter = currentInter;
    if (self.isHavePage) {
        int itemIndex = [self currentIndex];
        int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
        self.pageCurrent = indexOnPageControl;
    }
}

- (void)automaticScroll
{
    [super automaticScroll];
    if (beganDragging) return;
    if (self.dataArray.count == 0) return;
    int currentIndex = [self currentIndex];
    self.currentSelectInter = currentIndex + 1;
    [self scrolToPath:[NSIndexPath indexPathForRow:self.currentSelectInter inSection:0] animated:YES];
    [self.collectionView setUserInteractionEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView setUserInteractionEnabled:YES];
    });
    
}
//滚动处理
- (void)scrolToPath:(NSIndexPath*)path animated:(BOOL)animated
{
    if (self.dataArray.count==0) return;
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForItem:path.row inSection:0];
    if (path.row >= (self.groudInter-1) * self.dataArray.count) {
        if (self.infiniteLoop) {
            self.currentSelectInter = self.dataArray.count;;
            scrollIndexPath = [NSIndexPath indexPathForItem:self.currentSelectInter inSection:0];
            [self.collectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            if ([self.collectionView isPagingEnabled]) return;
            if (self.itemContentOffsetX>0.5) {
                self.collectionView.contentOffset =
                CGPointMake(self.collectionView.contentOffset.x-(self.itemContentOffsetX-0.5)*CGRectGetWidth(self.collectionView.frame), self.collectionView.contentOffset.y);
            } else if (self.itemContentOffsetX<0.5) {
                self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x+CGRectGetWidth(self.collectionView.frame) *(0.5-self.itemContentOffsetX), self.collectionView.contentOffset.y);
            }
        }
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    if ([self.collectionView isPagingEnabled]) return;
    if (self.itemContentOffsetX>0.5) {
        self.collectionView.contentOffset =
        CGPointMake(self.collectionView.contentOffset.x-(self.itemContentOffsetX-0.5)*CGRectGetWidth(self.collectionView.frame), self.collectionView.contentOffset.y);
    } else if (self.itemContentOffsetX<0.5) {
        self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x+CGRectGetWidth(self.collectionView.frame) *(0.5-self.itemContentOffsetX), self.collectionView.contentOffset.y);
    }
}

- (void)scrollEnd:(NSIndexPath*)indexPath{
    if (!self.dataArray.count) return;
    NSInteger current = MAX(self.currentSelectInter, 0);
    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:[NSIndexPath indexPathForRow:current inSection:0]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:ScrollEndItemAtIndexPath:AtModel:)]) {
        [self.delegate gx_hotBrandBaseView:self ScrollEndItemAtIndexPath:[NSIndexPath indexPathForRow:current inSection:0] AtModel:cellModel];
    }
    if (!self.itemEffect) {
        if ([cellModel.hotPicStr hasPrefix:@"http"]) {
            if (self.hotBrand_loadImageCallback) {
                self.hotBrand_loadImageCallback(self.effectView.effectImgView, [NSURL URLWithString:cellModel.hotPicStr]);
            }
        }else{
            self.effectView.effectImgView.image = [UIImage imageNamed:cellModel.hotPicStr];
        }
    }
    if (self.isHavePage) {
        int rowInter = [self pageControlIndexWithCurrentCellIndex:current];
        self.pageCurrent = rowInter;
    }
}
//itemContentOffsetX
- (void)setItemContentOffsetX:(CGFloat)itemContentOffsetX
{
    if (itemContentOffsetX <= 0 || itemContentOffsetX >=1) {
        itemContentOffsetX = 0.5;
    }
    _itemContentOffsetX = itemContentOffsetX;
}
- (void)setItemWidthScale:(CGFloat)itemWidthScale
{
    if (itemWidthScale <= 0 || itemWidthScale >=1) {
        itemWidthScale = 0.5;
    }
    _itemWidthScale = itemWidthScale;
}
- (void)setItemSpaceTop:(CGFloat)itemSpaceTop
{
    _itemSpaceTop = itemSpaceTop;
}
- (void)setItemSpaceBottom:(CGFloat)itemSpaceBottom
{
    _itemSpaceBottom = itemSpaceBottom;
}
- (CGXHotBrandModel *)pageIndexWithCurrentCellModelAtIndexPath:(NSIndexPath *)indexPath
{
    [super pageIndexWithCurrentCellModelAtIndexPath:indexPath];
    int rowInter = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    CGXHotBrandModel *cellModel = self.dataArray[rowInter];
    return cellModel;
}

- (int)currentIndex
{
    [super currentIndex];
    if (self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
        return 0;
    }
    int index = (int)self.currentSelectInter;
    return MAX(0, index);
}
- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.dataArray.count;
}
- (void)adjustWhenControllerViewWillAppera
{
    if (self.dataArray.count == 0) return;
    long targetIndex = [self currentIndex];
    if (targetIndex < self.totalInter) {
        [self scrolToPath:[NSIndexPath indexPathForRow:self.currentSelectInter inSection:0] animated:NO];
        [self scrollEnd:[NSIndexPath indexPathForRow:self.currentSelectInter inSection:0]];
    }
}
@end
