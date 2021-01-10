//
//  CGXHotBrandTagLabel.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandTagLabel.h"

@interface CGXHotBrandTagLabel ()
/** 遮罩 */
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
/** 路径 */
@property (nonatomic, strong) UIBezierPath *borderPath;

@property (nonatomic , assign) CGFloat arrowSpace;

@property (nonatomic, strong) UILabel *titeLabel;
@end

@implementation CGXHotBrandTagLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    self.backgroundColor= [UIColor redColor];

    
    self.tagBorderRadius = 10;
    self.triangleW = 5;
    self.triangleH = 5;
    self.arrowSpace = 5;
    self.titleColor = [UIColor whiteColor];
    self.titleFont = [UIFont systemFontOfSize:10];
    self.titeLabel = [[UILabel alloc] init];
    self.titeLabel.textColor = self.titleColor;
    self.titeLabel.font = self.titleFont;
    self.titeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titeLabel];
}
- (void)setRoundedType:(CGXHotBrandRoundedType)roundedType
{
    _roundedType = roundedType;
}
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.titeLabel.text = titleStr;
}
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titeLabel.textColor = titleColor;
}
- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titeLabel.font = titleFont;
}
- (void)setShowType:(CGXHotBrandViewShowType)showType
{
    _showType = showType;
}
- (void)setTagBorderRadius:(CGFloat)tagBorderRadius
{
    _tagBorderRadius = tagBorderRadius;
}
- (void)setTriangleH:(CGFloat)triangleH
{
    _triangleH = triangleH;
}
- (void)setTriangleW:(CGFloat)triangleW
{
    _triangleW = triangleW;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了

    // 初始化遮罩
    self.maskLayer = [CAShapeLayer layer];

    // 初始化路径
    self.borderPath = [UIBezierPath bezierPath];
    self.borderLayer = [CAShapeLayer layer];
    
    self.titeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace);
    if (self.showType == CGXHotBrandViewShowTypeJDChat){
        [self drawThePath1];
    } else if (self.showType == CGXHotBrandViewShowTypeChat){
        [self drawThePath3];
    } else{
        self.titeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.borderPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCorner)self.roundedType cornerRadii:CGSizeMake(self.tagBorderRadius, self.tagBorderRadius)];

        self.borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.borderLayer.lineWidth = self.tagBorderWidth;
        self.borderLayer.strokeColor = self.tagBorderColor.CGColor;
        self.borderLayer.fillColor = [UIColor clearColor].CGColor;
        self.borderLayer.path = self.borderPath.CGPath;
        self.maskLayer.path = self.borderPath.CGPath;
        [self.layer insertSublayer:self.borderLayer atIndex:0];
        
    }
    self.maskLayer.path = self.borderPath.CGPath;
    // 设置遮罩
    [self.layer setMask:self.maskLayer];
    // 遮罩层frame
    self.maskLayer.frame = self.bounds;
    
}
- (void)drawThePath0
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.tagBorderRadius)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.tagBorderRadius, CGRectGetHeight(self.frame)) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame))];

    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, CGRectGetHeight(self.frame))];

    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.tagBorderRadius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];

    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.tagBorderRadius)];

    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];

    [self.borderPath addLineToPoint:CGPointMake(self.tagBorderRadius, 0)];

    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.tagBorderRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.tagBorderRadius)];
}
- (void)drawThePath1
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.arrowSpace*3, CGRectGetHeight(self.frame)-self.arrowSpace) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace-self.tagBorderRadius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.tagBorderRadius)];
    
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.tagBorderRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.tagBorderRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
}
- (void)drawThePath2
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, CGRectGetHeight(self.frame))];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.tagBorderRadius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.tagBorderRadius)];
    
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.tagBorderRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.tagBorderRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
}
- (void)drawThePath3
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.tagBorderRadius-self.arrowSpace)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.tagBorderRadius/2, CGRectGetHeight(self.frame)-self.arrowSpace) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.arrowSpace)];
    
    [self.borderPath addLineToPoint:CGPointMake(self.tagBorderRadius/2, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(self.tagBorderRadius/2, CGRectGetHeight(self.frame))];

    [self.borderPath addQuadCurveToPoint:CGPointMake(self.tagBorderRadius+self.arrowSpace, CGRectGetHeight(self.frame)-self.arrowSpace) controlPoint:CGPointMake(self.tagBorderRadius/2, CGRectGetHeight(self.frame)-self.arrowSpace)];
    
    
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.tagBorderRadius-self.arrowSpace) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.tagBorderRadius)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.tagBorderRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.tagBorderRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.tagBorderRadius-self.arrowSpace)];
}
- (void)drawThePath4
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.arrowSpace*3, CGRectGetHeight(self.frame)-self.arrowSpace) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace-self.tagBorderRadius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.tagBorderRadius)];
    
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.tagBorderRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.tagBorderRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.tagBorderRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
