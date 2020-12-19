//
//  CGXHotBrandView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandView.h"
#import "CGXHotBrandCell.h"
#import "CGXHotBrandFlowlayout.h"
#import "CGXHotBrandPageControl.h"
#import "UIColor+CGXHotBrand.h"
@interface CGXHotBrandView ()

@property (nonatomic, strong,readwrite) NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *dataArray;

@property (nonatomic, strong) CGXHotBrandPageControl *pageControl;

@end

@implementation CGXHotBrandView
- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    self.collectionView.pagingEnabled = pagingEnabled;
}
- (void)setBounces:(BOOL)bounces
{
    _bounces = bounces;
    self.collectionView.bounces = bounces;
}
- (void)setPageSelectColor:(UIColor *)pageSelectColor
{
    _pageSelectColor = pageSelectColor;
    self.pageControl.currentPageIndicatorTintColor = pageSelectColor;
}
- (void)setPageNormalColor:(UIColor *)pageNormalColor
{
    _pageNormalColor = pageNormalColor;
    self.pageControl.pageIndicatorTintColor = pageNormalColor;
}
- (void)setPageHeight:(CGFloat)pageHeight
{
    _pageHeight = pageHeight;
}
- (void)setIsHavePage:(BOOL)isHavePage
{
    _isHavePage = isHavePage;
    self.pageControl.hidesForSinglePage = !isHavePage;
}
- (void)initializeData
{
    [super initializeData];
    self.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.placeholderImage = [UIColor gx_hotBrandImageWithColor:[UIColor colorWithWhite:0.93 alpha:1]];
    self.onlyDisplayText = NO;
    self.pageHeight = 20;
    self.pageSelectColor = [UIColor redColor];
    self.pageNormalColor = [UIColor grayColor];
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.isHavePage = YES;
}
- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.pagingEnabled = self.pagingEnabled;
    
    self.pageControl = [[CGXHotBrandPageControl alloc] init];
    [self addSubview:self.pageControl];
    
    [self reloadData];
    
    if (@available(iOS 14.0, *)) {
        self.pageControl.backgroundStyle = UIPageControlBackgroundStyleMinimal;
//        self.pageControl.preferredIndicatorImage = [UIImage systemImageNamed:@"sun.max.fill"];//系统图片
//        self.pageControl.preferredIndicatorImage = [UIImage imageNamed:@"flight"];//自定义图片
//        [self.pageControl setIndicatorImage:[UIImage systemImageNamed:@"moon.fill"] forPage:0];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isHavePage) {
        self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame)-self.pageHeight-self.minimumLineSpacing, CGRectGetWidth(self.frame), self.pageHeight);
        self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.pageHeight-self.minimumLineSpacing);
    } else{
        self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
    self.pageControl.currentPageIndicatorTintColor = self.pageSelectColor;
    self.pageControl.pageIndicatorTintColor = self.pageNormalColor;
    [self.pageControl setTransform:CGAffineTransformMakeScale(1, 1)];
    self.pageControl.hidesForSinglePage = !self.isHavePage;
    [self.pageControl setHidden:!self.isHavePage];
    
    [self reloadData];
}
- (void)reloadData
{
    self.collectionView.collectionViewLayout = [self preferredFlowLayout];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    if (self.pagingEnabled == YES) {
    CGXHotBrandFlowlayout *layout = [[CGXHotBrandFlowlayout alloc] init];
    layout.itemSectionCount = self.itemSectionCount;
    layout.itemRowCount = self.itemRowCount;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return layout;
    }else{
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return layout;
    }
}
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass
{
    [super preferredCellClass];
    return CGXHotBrandCell.class;
}
- (NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.edgeInsets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = self.edgeInsets;
    CGFloat spaceW = insets.left+insets.right;
    CGFloat spaceH = insets.top+insets.bottom;
    CGFloat width = (CGRectGetWidth(collectionView.frame) - spaceW-self.minimumInteritemSpacing*(self.itemRowCount-1)) / self.itemRowCount;
    CGFloat height = (CGRectGetHeight(collectionView.frame) - spaceH-self.minimumLineSpacing*(self.itemSectionCount-1)) / self.itemSectionCount;
    return CGSizeMake(width, height);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *sectionArr = self.dataArray[section];
    return sectionArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellClassForBaseView:)] && [self.delegate gx_hotBrandCellClassForBaseView:self]) {
        return cell;
    }else if ([self.delegate respondsToSelector:@selector(gx_hotBrandCellNibForBaseView:)] && [self.delegate gx_hotBrandCellNibForBaseView:self]) {
        return cell;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *sectionArr = self.dataArray[indexPath.section];
    CGXHotBrandModel *cellModel = sectionArr[indexPath.row];
    cellModel.hotBrand_loadImageCallback = self.hotBrand_loadImageCallback;
    BOOL isHave = [cell respondsToSelector:@selector(updateWithHotBrandCellModel:Section:Row:)];
    if (isHave == YES && [cell conformsToProtocol:@protocol(CGXHotBrandBaseCellDelegate)]) {
        [(UICollectionViewCell<CGXHotBrandBaseCellDelegate> *)cell updateWithHotBrandCellModel:cellModel Section:indexPath.section Row:indexPath.row];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *sectionArr = self.dataArray[indexPath.section];
    CGXHotBrandModel *cellModel = sectionArr[indexPath.row];
    __weak typeof(self) weskSelf = self;
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(weskSelf, cellModel);
    } else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(gx_hotBrandBaseView:DidSelectItemAtModel:)]) {
            [self.delegate gx_hotBrandBaseView:self DidSelectItemAtModel:cellModel];
        }
    }
}
- (void)updateWithDataArray:(NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *)dataArray;
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    
    self.pageControl.numberOfPages = dataArray.count;
    self.pageControl.currentPage = 0;
    [self.collectionView reloadData];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.dataArray.count) return;
    NSInteger itemIndex = [self currentIndex];
    self.pageControl.currentPage = itemIndex;
}
- (int)currentIndex
{
    if (self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
        return 0;
    }
    int index = (self.collectionView.contentOffset.x + self.collectionView.frame.size.width* 0.5) / self.collectionView.frame.size.width;
    return MAX(0, index);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
