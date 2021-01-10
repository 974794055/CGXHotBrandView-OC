//
//  UIView+CGXRoundedCorners.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIView+CGXHotBrandRounded.h"
#import <objc/runtime.h>

@interface UIView ()


@end

@implementation UIView (CGXHotBrandRounded)



- (void)gx_hotBrandRadius:(CGFloat)radius
                LineWidth:(CGFloat)lineWidth
              BorderColor:(UIColor *)borderColor
                   Corner:(CGXHotBrandRoundedType)corner
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    borderLayer.lineWidth = lineWidth;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) cornerRadius:radius];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [self.layer insertSublayer:borderLayer atIndex:0];
    [self.layer setMask:maskLayer];
    
}
@end
