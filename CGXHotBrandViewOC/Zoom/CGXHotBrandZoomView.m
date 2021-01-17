//
//  CGXHotBrandZoomView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandZoomView.h"
#import "CGXHotBrandZoomFlowLayout.h"
#import "CGXHotBrandZoomCell.h"
#import "CGXHotBrandBlurEffectView.h"
@interface CGXHotBrandZoomView()<FirstCellZoomInLayoutTwoDelegate>
{
    BOOL beganDragging;
}
@property(strong,nonatomic,readwrite)NSMutableArray<CGXHotBrandModel *> *dataArray;

@property(nonatomic,assign) NSInteger currentSelectInter;

@property(nonatomic,strong) CGXHotBrandBlurEffectView *effectView;

@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *bottomView;

@end
@implementation CGXHotBrandZoomView


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
    self.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.itemZoomcale = 0.7;
    self.itemWidthScale = 0.4;
    self.currentSelectInter = 0;
    
    self.itemEffect = NO;
    self.itemEffectHeight = 1;
    self.itemEffectAlpha = 1;
    
    self.bounces = YES;
    self.infiniteLoop = NO;
    
}
- (void)initializeViews
{
    [super initializeViews];
    
    self.effectView = [[CGXHotBrandBlurEffectView alloc] init];
    [self addSubview:self.effectView];
    [self sendSubviewToBack:self.effectView];
    self.effectView.hidden = self.itemEffect;
    
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.collectionViewLayout = [self preferredFlowLayout];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    
}
- (void)setDataSource:(id<CGXHotBrandZoomViewDataSource>)dataSource
{
    _dataSource = dataSource;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gx_hotBrandZoomTopView:)]) {
        self.topView = [[UIView alloc] init];
        [self addSubview:self.topView];
        [self bringSubviewToFront:self.topView];
        UIView *topView = [self.dataSource gx_hotBrandZoomTopView:self];;
        [self.topView addSubview:topView];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gx_hotBrandZoomBottomView:)]) {
        self.bottomView = [[UIView alloc] init];
        [self addSubview:self.bottomView];
        [self bringSubviewToFront:self.bottomView];
        UIView *bottomView = [self.dataSource gx_hotBrandZoomBottomView:self];;
        [self.bottomView addSubview:bottomView];

    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.edgeInsets.top);
    self.bottomView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-self.edgeInsets.bottom, CGRectGetWidth(self.frame), self.edgeInsets.bottom);
    
    self.effectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*self.itemEffectHeight);
    self.effectView.itemEffectAlpha = self.itemEffectAlpha;
    self.effectView.hidden = self.itemEffect;
    
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
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
    CGXHotBrandZoomFlowLayout *layout = [[CGXHotBrandZoomFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.delegate = self;
    return layout;
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandZoomCell.class;
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
    CGSize size = [self gx_hotBrandSizeForFirstCell];
    return CGSizeMake(floor(size.width * self.itemZoomcale) , floor(size.height * self.itemZoomcale));
}
- (CGSize)gx_hotBrandSizeForFirstCell {
    
    CGFloat width = CGRectGetWidth(self.collectionView.frame)-self.edgeInsets.left-self.edgeInsets.right;
    CGFloat height = CGRectGetHeight(self.collectionView.frame)-self.edgeInsets.top-self.edgeInsets.bottom;
    return CGSizeMake(width * self.itemWidthScale , height);
}
/*滚动结束*/
- (void)gx_hotBrandZoomScrollEndAtIndex:(NSInteger)index
{
    self.currentSelectInter = index;
    
    if (!self.dataArray.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int selectIndex = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:ScrollEndItemAtIndexPath:AtModel:)]) {
        [self.delegate gx_hotBrandBaseView:self ScrollEndItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0] AtModel:cellModel];
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
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gx_hotBrandZoomTopView:)] && [self.dataSource respondsToSelector:@selector(gx_hotBrandZoomTopView:AtInter:ItemModel:)]) {
        [self.dataSource gx_hotBrandZoomTopView:self AtInter:index ItemModel:cellModel];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gx_hotBrandZoomBottomView:)]&& [self.dataSource respondsToSelector:@selector(gx_hotBrandZoomBottomView:AtInter:ItemModel:)]) {
        [self.dataSource gx_hotBrandZoomBottomView:self AtInter:index ItemModel:cellModel];
    }
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
//    CGXHotBrandModel *cellModel = [self pageIndexWithCurrentCellModelAtIndexPath:indexPath];
}
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super gx_hotBrandCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
            [self scrolToPath:indexPath animated:YES];
}

//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beganDragging = YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.dataArray.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    if (self.infiniteLoop) {
        if (itemIndex >= self.totalInter-self.dataArray.count-1  || itemIndex <= self.dataArray.count) {
            int index = MAX(0, self.groudInter/2.0);
            itemIndex = index * (int)self.dataArray.count-1;
            [self scrolToPath:[NSIndexPath indexPathForRow:itemIndex inSection:0] animated:NO];
        }
    }
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
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    beganDragging = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
    [self gx_hotBrandZoomScrollEndAtIndex:self.currentSelectInter];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self gx_hotBrandZoomScrollEndAtIndex:self.currentSelectInter];
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
    self.currentSelectInter = 0;
    [self gx_hotBrandZoomScrollEndAtIndex:self.currentSelectInter];
    if (!self.infiniteLoop) {
        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    [self.collectionView reloadData];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
// 更新某个item
- (void)updateWithItemModel:(CGXHotBrandModel *)itemModel AtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0 || indexPath.row >= self.dataArray.count) {
        return;
    }
    [UIView animateWithDuration:0 animations:^{
        [self.collectionView performBatchUpdates:^{
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:itemModel];
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            [self.collectionView reloadData];
        } completion:nil];
    }];
}

//滚动处理
- (void)scrolToPath:(NSIndexPath*)path animated:(BOOL)animated
{
    self.currentSelectInter = path.row;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:path.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];

    if (path.row > 0) {
        UICollectionViewLayoutAttributes*attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:path.row-1 inSection:0]];
        
        [self.collectionView setContentOffset:CGPointMake(CGRectGetMaxX(attributes.frame), 0) animated:animated];
    }

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
@end
