//
//  UIView+CGXHotBrandRounded.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandDefines.h"

@interface UIView (CGXHotBrandRounded)


- (void)gx_hotBrandRadius:(CGFloat)radius
                LineWidth:(CGFloat)lineWidth
              BorderColor:(UIColor *)borderColor
                   Corner:(CGXHotBrandRoundedType)corner;


@end

