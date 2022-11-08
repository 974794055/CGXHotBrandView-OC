//
//  CGXHotBrandPageModel.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGXHotBrandDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandPageModel : NSObject

/**
 *  UIImage to represent a dot, if custom dot view not extends CGXHotBrandPageDotView and has set dotImage.
 */
@property(nonatomic, strong) UIImage *dotImage;
/**
 *  UIImage to represent a dot as current page, if custom dot view not extends CGXHotBrandPageDotView and has set dotCurrentImage.
 */
@property(nonatomic, strong) UIImage *dotCurrentImage;
/**
 *  Set dot view Color. Default is WhiteColor.
 */
@property(nonatomic, strong) UIColor *dotColor;
/**
 *  Set current dot view Color. Default is GrayColor.
 */
@property(nonatomic, strong) UIColor *dotCurrentColor;

/**
 *  Set current dot view titleColor. Default is BlackColor.
 */

@property (nonatomic, strong) UIColor *titleColor;
/**
 *  Set current dot view titleFont. Default is 14.
 */
@property (nonatomic, strong) UIFont *titleFont;


@property(nonatomic, assign) CGXHotBrandPageStyle dotStyle;

@end

NS_ASSUME_NONNULL_END
