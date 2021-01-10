//
//  CGXHotBrandPageDotView.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2021/1/5.
//

#import "CGXHotBrandPageDotView.h"

@implementation CGXHotBrandPageDotView
- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}


- (void)changActiveState:(BOOL)active
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}

- (void)setDotColor:(UIColor *)dotColor
{
    
}

- (void)setCurrentDotColor:(UIColor *)currentDotColor
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
