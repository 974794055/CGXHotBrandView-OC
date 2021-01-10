//
//  CGXHotBrandBlurEffectView.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBlurEffectView.h"
@interface CGXHotBrandBlurEffectView()

@property(nonatomic,strong) UIVisualEffectView *effectView;


@end

@implementation CGXHotBrandBlurEffectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    self.effectImgView = [[UIImageView alloc] init];
    self.effectImgView.clipsToBounds = YES;
    self.effectImgView.layer.masksToBounds = YES;
    self.effectImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.effectImgView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.effectImgView addSubview:self.effectView];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.effectImgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.effectView.frame = self.effectImgView.bounds;
    self.effectView.alpha = self.itemEffectAlpha;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
