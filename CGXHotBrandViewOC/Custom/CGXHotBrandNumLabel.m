//
//  CGXHotBrandNumLabel.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandNumLabel.h"

@interface CGXHotBrandNumLabel ()
/** 遮罩 */
@property (nonatomic, strong) CAShapeLayer *maskLayer;
/** 路径 */
@property (nonatomic, strong) UIBezierPath *borderPath;

@property (nonatomic, strong) UILabel *titeLabel;
@end

@implementation CGXHotBrandNumLabel
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
    self.bottomHeight = 10;
    self.numColor = [UIColor whiteColor];
    self.numFont = [UIFont systemFontOfSize:10];
    
    self.titeLabel = [[UILabel alloc] init];
    self.titeLabel.textColor = self.numColor;
    self.titeLabel.font = self.numFont;
    self.titeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titeLabel];
    [self bringSubviewToFront:self.titeLabel];
}
- (void)setNumStr:(NSString *)numStr
{
    _numStr = numStr;
    self.titeLabel.text = numStr;
}
- (void)setNumColor:(UIColor *)numColor
{
    _numColor = numColor;
    self.titeLabel.textColor = numColor;
}
- (void)setNumFont:(UIFont *)numFont
{
    _numFont = numFont;
    self.titeLabel.font = numFont;
}
- (void)setBottomHeight:(CGFloat)bottomHeight
{
    _bottomHeight = bottomHeight;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了

    // 初始化遮罩
    self.maskLayer = [CAShapeLayer layer];
    // 初始化路径
    self.borderPath = [UIBezierPath bezierPath];

    [self drawThePath];
    
    self.maskLayer.path = self.borderPath.CGPath;
    // 设置遮罩
    [self.layer setMask:self.maskLayer];
    // 遮罩层frame
    self.maskLayer.frame = self.bounds;
    
    self.titeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-10);
    
}
- (void)drawThePath
{
    [self.borderPath moveToPoint:CGPointMake(0,0)];
    
    [self.borderPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-self.bottomHeight)];
    
    [self.borderPath addCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.bottomHeight)
                       controlPoint1:CGPointMake(0, CGRectGetHeight(self.frame)-self.bottomHeight)
                       controlPoint2:CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame))];
    
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.bottomHeight)];
    
    [self.borderPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];

    [self.borderPath moveToPoint:CGPointMake(0,0)];

}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
