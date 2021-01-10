//
//  CGXHotBrandBaseView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandPageControl.h"

/**
 *  Set dot size. Default is (8, 8).
 */
static CGSize const kDefaultDotSize = {8, 8};

/**
 *  Set gap between dot and dot. Default is 8.
 */
static double const kDefaultGapBetweenDots = 8.0;

/**
 *  Number of pages for control. Default is 0.
 */
static NSInteger const kDefautNumberOfPages = 0;

/**
 *  Current page on which control is active. Default is 0.
 */
static NSInteger const kDefaultCurrentPage = 0;

/**
 *  Default setting for hide for single page feature. For initialization
 */
static BOOL const kDefaultHidesForSinglePage = NO;

@interface CGXHotBrandPageControl ()

@property(nonatomic, strong) NSMutableArray *dots;  ///<  存储dot数组


@end

@implementation CGXHotBrandPageControl

#pragma mark - Lifecycle
- (id)init
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
    self.numberOfPages = kDefautNumberOfPages;
    self.currentPage = kDefaultCurrentPage;
    self.dotSize = kDefaultDotSize;
    self.gapBetweenDots = kDefaultGapBetweenDots;
    self.hidesForSinglePage = kDefaultHidesForSinglePage;
    self.hidesPage = NO;
    self.dotWidthSpace = 0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateDotView];
}

#pragma mark - update
- (void)updateDotView
{
    if (!self.numberOfPages) {
        return;
    }
    if (self.numberOfPages==0) {
        return;
    }
    
    for (NSInteger i=0; i<self.numberOfPages; i++) {
        UIView *dotView;
        if (i < self.dots.count) {
            dotView = [self.dots objectAtIndex:i];
        } else {
            if (self.dotViewClass) {
                dotView = [[self.dotViewClass alloc] initWithFrame:CGRectMake(0, 0, self.dotSize.width, self.dotSize.height)];

                if (self.dotColor) {
                    CGXHotBrandPageDotView *abstracDotView = (CGXHotBrandPageDotView *)dotView;
                    [abstracDotView setDotColor:self.dotColor];
                }
            } else {
                dotView = [[UIImageView alloc] initWithImage:self.dotImage];
                dotView.frame = CGRectMake(0, 0, self.dotSize.width, self.dotSize.height);
            }
            
            if (dotView) {
                [self addSubview:dotView];
                [self.dots addObject:dotView];
            }
            dotView.userInteractionEnabled = NO;
            dotView.layer.masksToBounds = YES;
            dotView.clipsToBounds = YES;
        }
        
        [self updateFrame:dotView atIndex:i];
    }
    
    [self changeActiveState:true atIndex:self.currentPage];
    
    [self hideForSinglePage];
}

- (void)resetDotView
{
    for (UIView *dotView in self.dots) {
        [dotView removeFromSuperview];
    }
    
    [self.dots removeAllObjects];
    [self updateDotView];
}

- (void)changeActiveState:(BOOL)active atIndex:(NSInteger)index
{
    if (self.dotViewClass) {
        NSInteger inter = index % self.dots.count;
        CGXHotBrandPageDotView *abstractDotView = (CGXHotBrandPageDotView *)[self.dots objectAtIndex:inter];
        if ([abstractDotView respondsToSelector:@selector(changActiveState:)]) {
            
            if (active && self.currentDotColor) {
                [abstractDotView setCurrentDotColor:self.currentDotColor];
            } else if (!active && self.dotColor) {
                [abstractDotView setDotColor:self.dotColor];
            }
            
            [abstractDotView changActiveState:active];
        } else {
            NSLog(@"Custom Dot View : %@ must implement method 'changeActivityState'", self.dotViewClass);
        }
    } else if(self.dotImage && self.currentDotImage) {
        UIImageView *dotImage = (UIImageView *)[self.dots objectAtIndex:index];
        dotImage.image = (active) ? self.currentDotImage : self.dotImage;
    } else{
        
    }
}

#pragma mark - frame
- (void)updateFrame:(UIView *)dot atIndex:(NSInteger)index
{
    CGFloat x = self.gapBetweenDots + (self.dotSize.width + self.gapBetweenDots) * index + ( (CGRectGetWidth(self.frame) - [self sizeForNumberOfPages:self.numberOfPages].width) / 2);
    CGFloat y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;
    
//    if (self.style == CGXHotBrandPageControlStyleRectangle){//长方形
        if (index == self.currentPage) {
            dot.frame = CGRectMake(x, y, self.dotSize.width+self.dotWidthSpace, self.dotSize.height);
        } else{
            if (index > self.currentPage) {
                x = x + self.dotWidthSpace;
            }
            dot.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
        }
//    }else{
//        dot.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
//    }
    dot.layer.cornerRadius = self.dotSize.height / 2.0;
}

- (void)hideForSinglePage
{
    if (self.dots.count == 1 && self.hidesForSinglePage) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
    if (self.hidesPage) {
        self.hidden = YES;
    }
}

#pragma mark - Public Method
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    return CGSizeMake((self.dotSize.width + self.gapBetweenDots) * pageCount + self.gapBetweenDots, self.dotSize.height);
}

#pragma mark - setter
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    [self resetDotView];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    //if no page or last page equals to current page
    if (!self.numberOfPages || currentPage == _currentPage) {
        _currentPage = currentPage;
        return;
    }
    
    //set last page to inactive state
    [self changeActiveState:false atIndex:_currentPage];
    
    //set current page to active state
    _currentPage = currentPage;
    [self changeActiveState:true atIndex:_currentPage];
    
    for (NSInteger i=0; i<self.dots.count; i++) {
        UIView *dotView = [self.dots objectAtIndex:i];
        [self updateFrame:dotView atIndex:i];
    }
}

- (void)setDotImage:(UIImage *)dotImage
{
    _dotImage = dotImage;
    [self resetDotView];
    self.dotViewClass = nil;
}

- (void)setCurrentDotImage:(UIImage *)currentDotImage
{
    _currentDotImage = currentDotImage;
    [self resetDotView];
    self.dotViewClass = nil;
}

- (void)setDotViewClass:(Class)dotViewClass
{
    _dotViewClass = dotViewClass;
    
    [self resetDotView];
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    
    [self resetDotView];
}

#pragma mark - getter
- (NSMutableArray *)dots
{
    if (!_dots) {
        _dots = [[NSMutableArray alloc] init];
    }
    return _dots;
}
- (CGSize)dotSize
{
    if (self.dotImage && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = self.dotImage.size;
    } else if (self.dotViewClass && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = kDefaultDotSize;
        
        return _dotSize;
    }
    
    return _dotSize;
}
@end

