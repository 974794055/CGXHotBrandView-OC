//
//  CGXHotBrandBaseView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandPageControl.h"
#import "CGXHotBrandPageImageView.h"
#import "CGXHotBrandPageNumView.h"
#import "CGXHotBrandPageSquareView.h"
/**
 *  Set dot size. Default is (8, 8).
 */
static CGSize const kDefaultDotSize = {8, 8};

/**
 *  Set gap between dot and dot. Default is 8.
 */
static double const kDefaultdotBetween = 8.0;

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

@property(nonatomic, strong) CGXHotBrandPageModel *dotModel;

@property(nonatomic, strong) Class __nullable dotViewClass;

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
    self.dotViewClass = [CGXHotBrandPageSquareView class];
    self.dotStyle = CGXHotBrandPageModelSystem;
    self.numberOfPages = kDefautNumberOfPages;
    self.currentPage = kDefaultCurrentPage;
    self.dotSize = kDefaultDotSize;
    self.dotBetween = kDefaultdotBetween;
    self.hidesForSinglePage = kDefaultHidesForSinglePage;
    self.hidesPage = NO;
    self.dotWidthSpace = 0;
    self.dotColor = [UIColor grayColor];
    self.dotCurrentColor = [UIColor redColor];
    self.dotBorderColor = [self.dotColor colorWithAlphaComponent:0];
    self.dotBorderSelectColor = [self.dotCurrentColor colorWithAlphaComponent:0];
    self.dotBorderWidth = 0;
    
    self.dotModel = [[CGXHotBrandPageModel alloc] init];
    self.dotModel.dotColor = self.dotColor;
    self.dotModel.dotCurrentColor = self.dotCurrentColor;
    self.dotModel.dotStyle = self.dotStyle;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateDotView];
    
    //    NSArray<UIView*> *subViews = self.subviews;
    //    CGFloat mainWidth = self.frame.size.width;
    //    CGFloat mainHeight = self.frame.size.height;
    //    if (@available(iOS 14.0, *)) {
    //        subViews = self.subviews.firstObject.subviews.firstObject.subviews;
    //        mainWidth = self.subviews.firstObject.subviews.firstObject.frame.size.width;
    //        mainHeight = self.subviews.firstObject.subviews.firstObject.frame.size.height;
    //    }
    
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
        CGXHotBrandPageDotView *dotView;
        if (i < self.dots.count) {
            dotView = [self.dots objectAtIndex:i];
        } else {
            dotView = [[self.dotViewClass alloc] initWithFrame:CGRectMake(0, 0, self.dotSize.width, self.dotSize.height)];
            [dotView updateWithModel:self.dotModel ActiveState:NO DotInter:i];
            if (dotView) {
                [self addSubview:dotView];
                [self.dots addObject:dotView];
            }
            if (self.currentPage == i) {
                dotView.layer.borderColor = [self.dotBorderSelectColor CGColor];
            } else{
                dotView.layer.borderColor = [self.dotBorderColor CGColor];
            }
            dotView.layer.borderWidth = self.dotBorderWidth;
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
    if (index < self.dots.count && self.dots.count > 0) {
        NSInteger inter = index % self.dots.count;
        CGXHotBrandPageDotView *dotView = (CGXHotBrandPageDotView *)[self.dots objectAtIndex:inter];
        if ([dotView respondsToSelector:@selector(changActiveState:)]) {
            [dotView updateWithModel:self.dotModel ActiveState:active DotInter:index];
            [dotView changActiveState:active];
        } else {
            NSLog(@"Custom Dot View : %@ must implement method 'changeActivityState'", self.dotViewClass);
        }
    }
}

#pragma mark - frame
- (void)updateFrame:(UIView *)dot atIndex:(NSInteger)index
{
    CGFloat x = self.dotBetween + (self.dotSize.width + self.dotBetween) * index + ( (CGRectGetWidth(self.frame) - [self sizeForNumberOfPages:self.numberOfPages].width) / 2);
    CGFloat y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;
    if (index == self.currentPage) {
        dot.frame = CGRectMake(x, y, self.dotSize.width+self.dotWidthSpace, self.dotSize.height);
    } else{
        if (index > self.currentPage) {
            x = x + self.dotWidthSpace;
        }
        dot.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
    }
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
    return CGSizeMake((self.dotSize.width + self.dotBetween) * pageCount + self.dotBetween, self.dotSize.height);
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
    [self changeActiveState:true atIndex:currentPage];
    
    for (NSInteger i=0; i<self.dots.count; i++) {
        CGXHotBrandPageDotView *dotView = (CGXHotBrandPageDotView *)[self.dots objectAtIndex:i];
        [self updateFrame:dotView atIndex:i];
    }
    [self changeWithOldIndex:self.currentPage atNewIndex:currentPage];
    _currentPage = currentPage;
}

- (void)changeWithOldIndex:(NSInteger)oldIndex atNewIndex:(NSInteger)newIndex{
    
    if (oldIndex < self.dots.count && newIndex < self.dots.count) {
        CGXHotBrandPageDotView *oldDotView = (CGXHotBrandPageDotView *)[self.dots objectAtIndex:oldIndex];
        CGXHotBrandPageDotView *newDotView = (CGXHotBrandPageDotView *)[self.dots objectAtIndex:newIndex];
        newDotView.layer.borderColor = [self.dotBorderSelectColor CGColor];
        oldDotView.layer.borderColor = [self.dotBorderColor CGColor];
        
        if (self.dotWidthSpace > 0) {//如果当前选中点的宽度与未选中的点宽度不一样，则要改变选中前后两点的frame
            CGRect oldDotFrame = oldDotView.frame;
            if (newIndex < oldIndex) {
                oldDotFrame.origin.x += self.dotWidthSpace;
            }
            oldDotFrame.size.width = self.dotSize.width;
            CGRect newDotFrame = newDotView.frame;
            if (newIndex > oldIndex) {
                newDotFrame.origin.x -= self.dotWidthSpace;
            }
            newDotFrame.size.width = self.dotSize.width + self.dotWidthSpace;
            [UIView animateWithDuration:0.3 animations:^{
                oldDotView.frame = oldDotFrame;
                newDotView.frame = newDotFrame;
            }];
        }
        if (newIndex - oldIndex > 1) {//点击圆点，中间有跳过的点
            for (NSInteger i = oldIndex + 1; i<newIndex; i++) {
                CGXHotBrandPageDotView *imageV = self.dots[i];
                CGRect frame = imageV.frame;
                frame.origin.x -= self.dotWidthSpace;
                frame.size.width = self.dotSize.width;
                imageV.frame = frame;
            }
        }
        if (newIndex - oldIndex < -1) {//点击圆点，中间有跳过的点
            for (NSInteger i = newIndex + 1; i< oldIndex; i++) {
                CGXHotBrandPageDotView *imageV = self.dots[i];
                CGRect frame = imageV.frame;
                frame.origin.x += self.dotWidthSpace;
                frame.size.width = self.dotSize.width;
                imageV.frame = frame;
            }
        }
    }
}

- (void)setDotImage:(UIImage *)dotImage
{
    _dotImage = dotImage;
    self.dotModel.dotImage = dotImage;
    [self resetDotView];
}

- (void)setDotCurrentImage:(UIImage *)dotCurrentImage
{
    _dotCurrentImage = dotCurrentImage;
    self.dotModel.dotCurrentImage = dotCurrentImage;
    [self resetDotView];
}

- (void)setDotViewClass:(Class)dotViewClass
{
    _dotViewClass = dotViewClass;
    
    [self resetDotView];
}
- (void)setDotCurrentColor:(UIColor *)dotCurrentColor
{
    _dotCurrentColor = dotCurrentColor;
    self.dotModel.dotCurrentColor = dotCurrentColor;
    [self resetDotView];
}
- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    self.dotModel.dotColor = dotColor;
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
    if (self.dotStyle == CGXHotBrandPageModelImage && self.dotImage && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = self.dotImage.size;
    } else if (CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = kDefaultDotSize;
        
        return _dotSize;
    }
    return _dotSize;
}

- (void)setDotStyle:(CGXHotBrandPageStyle)dotStyle
{
    _dotStyle = dotStyle;
    self.dotModel.dotStyle = dotStyle;
    
    if (dotStyle == CGXHotBrandPageModelNumber) {
        self.dotViewClass = [CGXHotBrandPageNumView class];
    } else if (dotStyle == CGXHotBrandPageModelImage){
        self.dotViewClass = [CGXHotBrandPageImageView class];
    } else{
        self.dotViewClass = [CGXHotBrandPageSquareView class];
    }
    [self resetDotView];
}
@end

