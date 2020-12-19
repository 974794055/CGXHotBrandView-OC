//
//  UIView+CGXHotBrandRounded.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CGXHotBrandRounded)


/**
四角圆角
@param radius 圆角角度
*/
- (void)gx_hotBrandRoundedWithRadius:(CGFloat)radius;
/**
 便捷给添加border
 
 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)gx_hotBrandBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

@end

