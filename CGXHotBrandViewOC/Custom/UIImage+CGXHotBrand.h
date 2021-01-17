//
//  UIImage+CGXHotBrand.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2021/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TriangleDirection) { // 生成三角图片方向
    TriangleDirection_Down,
    TriangleDirection_Left,
    TriangleDirection_Right,
    TriangleDirection_Up
};

@interface UIImage (CGXHotBrand)
/**
 *  @brief  根据颜色生成纯色图片
 *  @param color 颜色
 *  @return 纯色图片
 */
+ (UIImage *)gx_hotBrandImageWithColor:(UIColor *)color;
+ (UIImage *)gx_hotBrandImageWithColor:(UIColor *)color Size:(CGSize)size;
/** 圆角图片 */
- (UIImage *)gx_hotBrandImageWithCornerRadius:(CGFloat)radius;

/** 圆角图片 */
- (UIImage*)gx_hotBrandImageWithCornerRadius:(CGFloat)radius andSize:(CGSize)size;

/** 圆形图片 */
+ (UIImage *)gx_hotBrandImageWithRoundImage:(UIImage *)image;

/**
 生成带圆角的颜色图片

 @param tintColor 图片颜色
 @param targetSize 生成尺寸
 @param cornerRadius 圆角大小
 @param backgroundColor 背景颜色
 */
+ (UIImage *)gx_hotBrandRadiusImageWithColor:(UIColor *)tintColor
                                targetSize:(CGSize)targetSize
                                   corners:(UIRectCorner)corners
                              cornerRadius:(CGFloat)cornerRadius
                           backgroundColor:(UIColor *)backgroundColor;

/// 生成三角图片
/// @param size 尺寸
/// @param color 颜色
/// @param direction 三角方向
+ (UIImage *)gx_hotBrandTriangleImageWithSize:(CGSize)size
                                color:(UIColor *)color
                            direction:(TriangleDirection)direction;
@end

NS_ASSUME_NONNULL_END
