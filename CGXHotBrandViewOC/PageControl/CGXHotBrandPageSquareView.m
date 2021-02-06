//
//  CGXHotBrandPageSquareView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandPageSquareView.h"
static const NSTimeInterval timeInterval = 0.5f;

@interface CGXHotBrandPageSquareView ()


@end
@implementation CGXHotBrandPageSquareView

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
}
- (void)layoutSubviews
{
    [super layoutSubviews];
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
