//
//  CGXHotBrandIndicatorView.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2021/11/3.
//

#import "CGXHotBrandIndicatorView.h"
#import "NSTimer+CGXHotBrandTimer.h"
#import "CGXHotBrandBaseFlowLayout.h"
#import "CGXHotBrandBaseCell.h"
#import "CGXHotBrandModel.h"
#import "CGXHotBrandTools.h"
#import "CGXHotBrandPageSquareView.h"
@interface CGXHotBrandIndicatorView ()


@property (nonatomic, strong) CGXHotBrandPageControl *pageControl;


@end
@implementation CGXHotBrandIndicatorView

- (void)initializeData
{
    [super initializeData];
    self.pageSize = CGSizeMake(8, 8);
    self.pageHeight = 20;
    self.pageSelectColor = [UIColor redColor];
    self.pageNormalColor = [UIColor grayColor];
    self.pagingEnabled = YES;

    self.isHavePage = NO;
    self.hidesPage = YES;
    self.pageBottomOffset = 0;
    self.pageHorizontalOffset = 0;
    self.pageContolAliment = CGXHotBrandPageAlimentCenter;
    
    self.pageWidthSpace = 0;
    self.pageBetween = 0;
    self.pageBorderColor = self.pageNormalColor;
    self.pageBorderSelectColor = self.pageSelectColor;
    self.pageBorderWidth = 0;
}
- (void)initializeViews
{
    [super initializeViews];
    self.pageControl = [[CGXHotBrandPageControl alloc] init];
    [self.pageControl setTransform:CGAffineTransformMakeScale(1, 1)];
    self.pageControl.hidesForSinglePage = true;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.dotSize = self.pageSize;
    [self addSubview:self.pageControl];
    [self bringSubviewToFront:self.pageControl];

    if (self.pageNormalColor) {
        self.pageNormalColor = self.pageNormalColor;
    }
    if (self.pageSelectColor) {
        self.pageSelectColor = self.pageSelectColor;
    }
    self.pageControl.dotStyle = self.dotStyle;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isHavePage) {
        if (self.pageCurrent < self.totalInter) {
            self.pageControl.currentPage = self.pageCurrent;
        }
        CGSize pointSize = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
        if (self.pageContolAliment == CGXHotBrandPageAlimentRight) {
            self.pageControl.frame = CGRectMake(CGRectGetWidth(self.frame)-self.pageHorizontalOffset-pointSize.width, CGRectGetHeight(self.frame)-self.pageHeight-self.pageBottomOffset, pointSize.width, self.pageHeight);
        } else if (self.pageContolAliment == CGXHotBrandPageAlimentLeft){
            self.pageControl.frame = CGRectMake(self.pageHorizontalOffset, CGRectGetHeight(self.frame)-self.pageHeight-self.pageBottomOffset, pointSize.width, self.pageHeight);
        } else{
            self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame)-self.pageHeight-self.pageBottomOffset, CGRectGetWidth(self.frame), self.pageHeight);
        }
        self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.pageHeight);
    } else{
        self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
    self.pageControl.hidesPage = !self.isHavePage;
}
- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    self.collectionView.pagingEnabled = pagingEnabled;
}

- (void)setPageSelectColor:(UIColor *)pageSelectColor
{
    _pageSelectColor = pageSelectColor;
    self.pageControl.dotCurrentColor = pageSelectColor;
}
- (void)setPageNormalColor:(UIColor *)pageNormalColor
{
    _pageNormalColor = pageNormalColor;
    self.pageControl.dotColor = pageNormalColor;
}
- (void)setPageSelectImage:(UIImage *)pageSelectImage
{
    _pageSelectImage = pageSelectImage;
    self.pageControl.dotImage = pageSelectImage;
}
- (void)setPageNormalImage:(UIImage *)pageNormalImage
{
    _pageNormalImage = pageNormalImage;
    self.pageControl.dotImage = pageNormalImage;
}
- (void)setPageHeight:(CGFloat)pageHeight
{
    _pageHeight = pageHeight;
}
- (void)setIsHavePage:(BOOL)isHavePage
{
    _isHavePage = isHavePage;
    self.pageControl.hidesPage = !isHavePage;
}
- (void)setPageSize:(CGSize)pageSize
{
    _pageSize = pageSize;
    self.pageControl.dotSize = pageSize;
}
- (void)setHidesPage:(BOOL)hidesPage
{
    _hidesPage = hidesPage;
}
- (void)setPageContolAliment:(CGXHotBrandPageAliment)pageContolAliment
{
    _pageContolAliment = pageContolAliment;
}
- (void)setPageBetween:(CGFloat)pageBetween
{
    _pageBetween = pageBetween;
    self.pageControl.dotBetween = pageBetween;
}
- (void)setPageWidthSpace:(CGFloat)pageWidthSpace
{
    _pageWidthSpace= pageWidthSpace;
    self.pageControl.dotWidthSpace = pageWidthSpace;
}
- (void)setPageBorderColor:(UIColor *)pageBorderColor
{
    _pageBorderColor = pageBorderColor;
    self.pageControl.dotBorderColor = pageBorderColor;
}
- (void)setPageBorderSelectColor:(UIColor *)pageBorderSelectColor
{
    _pageBorderSelectColor = pageBorderSelectColor;
    self.pageControl.dotBorderSelectColor = pageBorderSelectColor;
}
- (void)setPageBorderWidth:(CGFloat)pageBorderWidth
{
    _pageBorderWidth = pageBorderWidth;
    self.pageControl.dotBorderWidth = pageBorderWidth;
}
- (void)setPagesNumber:(NSInteger)pagesNumber
{
    _pagesNumber = pagesNumber;
    self.pageControl.numberOfPages = pagesNumber;
}
- (void)setPageCurrent:(NSInteger)pageCurrent
{
    _pageCurrent = pageCurrent;
    self.pageControl.currentPage = pageCurrent;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
