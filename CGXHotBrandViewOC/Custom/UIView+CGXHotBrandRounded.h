//
//  UIView+CGXHotBrandRounded.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandDefines.h"
typedef NS_OPTIONS (NSUInteger, CGXRoundedClipType) {
    CGXRoundedClipTypeNone = 0,  // 不切
    CGXRoundedClipTypeTopLeft     = UIRectCornerTopLeft, // 左上角
    CGXRoundedClipTypeTopRight    = UIRectCornerTopRight, // 右上角
    CGXRoundedClipTypeBottomLeft  = UIRectCornerBottomLeft, // 左下角
    CGXRoundedClipTypeBottomRight = UIRectCornerBottomRight, // 右下角
    CGXRoundedClipTypeAll  = UIRectCornerAllCorners,// 全部四个角
};
@interface UIView (CGXHotBrandRounded)

/**
四角圆角
@param radius 圆角角度
*/
- (void)gx_hotBrandRoundedWithAllRadius:(CGFloat)radius;
/**
上面两个圆角
@param radius 圆角角度
*/
- (void)gx_hotBrandRoundedWithTopRadius:(CGFloat)radius;
/**
下面两个圆角
@param radius 圆角角度
*/
- (void)gx_hotBrandRoundedWithBottomRadius:(CGFloat)radius;
/**
左面两个圆角
@param radius 圆角角度
*/
- (void)gx_hotBrandRoundedWithLeftRadius:(CGFloat)radius;
/**
右面两个圆角
@param radius 圆角角度
*/
- (void)gx_hotBrandRoundedWithRightRadius:(CGFloat)radius;
/**
 便捷添加圆角
 @param clipType 圆角类型
 @param radius 圆角角度
 */
- (void)gx_hotBrandRoundedWithRadius:(CGFloat)radius clipWithType:(CGXRoundedClipType)clipType;
/**
 便捷给添加border
 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)gx_hotBrandBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

@end

