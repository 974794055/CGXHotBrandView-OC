//
//  CGXHotBrandPageImageView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandPageImageView.h"
static const NSTimeInterval timeInterval = 0.5f;

@interface CGXHotBrandPageImageView ()

@property(nonatomic, strong) UIImageView *dotImageView;

@end

@implementation CGXHotBrandPageImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeData];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeData];
    }
    
    return self;
}

- (void)initializeData
{
    self.dotImageView = ({
        UIImageView *ppImageView = [[UIImageView alloc] init];
        ppImageView.layer.masksToBounds = YES;
        ppImageView.clipsToBounds = YES;
        ppImageView.contentMode = UIViewContentModeScaleAspectFit;
        ppImageView;
    });
    [self addSubview:self.dotImageView];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.dotImageView.frame = self.bounds;
}
#pragma mark - implement method
- (void)changActiveState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    } else {
        [self animateToInactiveState];
    }
}

- (void)animateToActiveState
{
    [UIView animateWithDuration:timeInterval animations:^{
        self.dotImageView.image = self.dotModel.dotCurrentImage;
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
}

- (void)animateToInactiveState
{
    [UIView animateWithDuration:timeInterval animations:^{
        self.dotImageView.image = self.dotModel.dotImage;
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)updateWithModel:(CGXHotBrandPageModel *)model ActiveState:(BOOL)active DotInter:(NSInteger)dotInter
{
    self.dotModel = model;
    if (active) {
        self.dotImageView.image = model.dotCurrentImage;
    } else{
        self.dotImageView.image = model.dotImage;
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
