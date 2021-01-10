//
//  CGXHotBrandPageSquareView.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2021/1/5.
//

#import "CGXHotBrandPageSquareView.h"
static const NSTimeInterval timeInterval = 0.5f;

@interface CGXHotBrandPageSquareView ()
/**
 *  the dot's color you customize not in current page.
 */
@property(nonatomic, strong) UIColor *dotColor;

/**
 *  the dot's color you customize int current page.
 */
@property(nonatomic, strong) UIColor *currentDotColor;
@end
@implementation CGXHotBrandPageSquareView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}

- (void)initialization
{
    self.dotColor = [UIColor whiteColor];
    self.currentDotColor = [UIColor grayColor];
    self.backgroundColor    = self.dotColor;
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
        self.backgroundColor = self.currentDotColor;
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
}

- (void)animateToInactiveState
{
    [UIView animateWithDuration:timeInterval animations:^{
        self.backgroundColor = self.dotColor;
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    self.backgroundColor = dotColor;
}

- (void)setCurrentDotColor:(UIColor *)currentDotColor
{
    _currentDotColor = currentDotColor;
    self.backgroundColor = currentDotColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
