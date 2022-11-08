//
//  CGXHotBrandPageNumView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandPageNumView.h"

static const NSTimeInterval timeInterval = 0.5f;

@interface CGXHotBrandPageNumView ()

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation CGXHotBrandPageNumView

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
    self.backgroundColor    = [UIColor whiteColor];
    
    self.titleLabel = ({
        UILabel *ppLabel  =[[UILabel alloc] init];
        ppLabel.textColor = [UIColor blackColor];
        ppLabel.font = [UIFont systemFontOfSize:14];
        ppLabel.numberOfLines = 0;
        ppLabel.textAlignment = NSTextAlignmentCenter;
        ppLabel.layer.masksToBounds = YES;
        ppLabel.layer.borderWidth = 0;
        ppLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        ppLabel.layer.cornerRadius = 0;
        ppLabel;
    });
    [self addSubview:self.titleLabel];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
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
        self.backgroundColor = self.dotModel.dotCurrentColor;
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
}

- (void)animateToInactiveState
{
    [UIView animateWithDuration:timeInterval animations:^{
        self.backgroundColor = self.dotModel.dotColor;
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}


- (void)updateWithModel:(CGXHotBrandPageModel *)model ActiveState:(BOOL)active DotInter:(NSInteger)dotInter
{
    self.dotModel = model;
    if (active) {
        self.backgroundColor = model.dotCurrentColor;
    } else{
        self.backgroundColor = model.dotColor;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%ld",dotInter];
    self.titleLabel.textColor = model.titleColor;
    self.titleLabel.font = model.titleFont;
}

@end
