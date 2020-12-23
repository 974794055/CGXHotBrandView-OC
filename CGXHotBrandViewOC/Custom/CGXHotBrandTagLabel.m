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

    
    self.cornerRadius = 10;
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
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
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
    // 设置遮罩
    [self.layer setMask:self.maskLayer];
    // 初始化路径
    self.borderPath = [UIBezierPath bezierPath];
    
    // 遮罩层frame
    self.maskLayer.frame = self.bounds;
    
    self.titeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace);

    if (self.showType == CGXHotBrandViewShowTypeJDChat){
        [self drawThePath1];
    } else if (self.showType == CGXHotBrandViewShowTypeJDRound){
        [self drawThePath2];
        self.titeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    } else if (self.showType == CGXHotBrandViewShowTypeChat){
        [self drawThePath3];
    } else{
        self.titeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [self drawThePath0];
    }
    self.maskLayer.path = self.borderPath.CGPath;
}

- (void)drawThePath0
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.cornerRadius)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.cornerRadius, CGRectGetHeight(self.frame)) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, CGRectGetHeight(self.frame))];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.cornerRadius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.cornerRadius)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.cornerRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.cornerRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.cornerRadius)];
}
- (void)drawThePath1
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.arrowSpace*3, CGRectGetHeight(self.frame)-self.arrowSpace) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace-self.cornerRadius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.cornerRadius)];
    
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.cornerRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.cornerRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
}
- (void)drawThePath2
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, CGRectGetHeight(self.frame))];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.cornerRadius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.cornerRadius)];
    
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.cornerRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.cornerRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
}
- (void)drawThePath3
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.cornerRadius-self.arrowSpace)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.cornerRadius/2, CGRectGetHeight(self.frame)-self.arrowSpace) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.arrowSpace)];
    
    [self.borderPath addLineToPoint:CGPointMake(self.cornerRadius/2, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(self.cornerRadius/2, CGRectGetHeight(self.frame))];
    //    [self.borderPath addLineToPoint:CGPointMake(self.cornerRadius+self.arrowSpace, CGRectGetHeight(self.frame)-self.arrowSpace)];
    
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.cornerRadius+self.arrowSpace, CGRectGetHeight(self.frame)-self.arrowSpace) controlPoint:CGPointMake(self.cornerRadius/2, CGRectGetHeight(self.frame)-self.arrowSpace)];
    
    
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.cornerRadius-self.arrowSpace) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.cornerRadius)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.cornerRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.cornerRadius) controlPoint:CGPointMake(0, 0)];
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.cornerRadius-self.arrowSpace)];
}
- (void)drawThePath4
{
    [self.borderPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.arrowSpace*3, CGRectGetHeight(self.frame)-self.arrowSpace) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace-self.cornerRadius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.arrowSpace)];
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), self.cornerRadius)];
    
    [self.borderPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.cornerRadius, 0) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.cornerRadius, 0)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.cornerRadius) controlPoint:CGPointMake(0, 0)];
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
