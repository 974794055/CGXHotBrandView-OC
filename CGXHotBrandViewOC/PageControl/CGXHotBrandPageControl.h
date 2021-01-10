//
//  CGXHotBrandBaseView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CGXHotBrandPageSquareView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandPageControl : UIControl

@property(nonatomic, strong) Class __nullable dotViewClass;
/**
 *  UIImage to represent a dot, if custom dot view not extends CGXHotBrandPageDotView and has set dotImage.
 */
@property(nonatomic, strong) UIImage *dotImage;
/**
 *  UIImage to represent a dot as current page, if custom dot view not extends CGXHotBrandPageDotView and has set currentDotImage.
 */
@property(nonatomic, strong) UIImage *currentDotImage;
/**
 *  Set dot view Color. Default is WhiteColor.
 */
@property(nonatomic, strong) UIColor *dotColor;
/**
 *  Set current dot view Color. Default is GrayColor.
 */
@property(nonatomic, strong) UIColor *currentDotColor;
/**
 *  Set dot size. Default is (8, 8).
 */
@property(nonatomic, assign) CGSize dotSize;

/**
 *  Set dot width add. Default is 0.
 */
@property(nonatomic, assign) CGFloat dotWidthSpace;

/**
 *  Set gap between dot and dot. Default is 8.
 */
@property(nonatomic, assign) double gapBetweenDots;
/**
 *  Number of pages for control. Default is 0.
 */
@property (nonatomic) NSInteger numberOfPages;
/**
 *  Current page on which control is active. Default is 0.
 */
@property (nonatomic) NSInteger currentPage;
/**
 *  When only one page set whether to hide. Default is NO.
 */
@property(nonatomic) BOOL hidesForSinglePage;
/**
 *  set whether to hide. Default is NO.
 */
@property(nonatomic) BOOL hidesPage;
/**
 *  Return the minimum size with total page count
 *  @param pageCount   numbers of dots that will display.
 *  @return CGSize  the minimum size
 */
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

/**
 * 禁用系统的隐藏
 */
- (void)setHidden:(BOOL)hidden NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
