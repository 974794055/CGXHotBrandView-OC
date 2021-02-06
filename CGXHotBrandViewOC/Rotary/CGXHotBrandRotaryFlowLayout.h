//
//  CGXHotBrandRotaryFlowLayout.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CGXHotBrandRotaryFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@optional

/*
 当前放大的item
 */
- (void)gx_hotBrandAtCurrentInter:(NSInteger)currentInter;

@end

typedef NS_ENUM(NSUInteger, HJCarouselAnim) {
    HJCarouselAnimLinear,
    HJCarouselAnimRotary,
    HJCarouselAnimCarousel,
    HJCarouselAnimCoverFlow,
};

@interface CGXHotBrandRotaryFlowLayout : CGXHotBrandBaseFlowLayout

@property (nonatomic , weak) id<CGXHotBrandRotaryFlowLayoutDelegate>carouselDelegate;

@property (nonatomic , assign)  HJCarouselAnim carouselAnim;

@property (nonatomic) NSInteger visibleCount;

@end

NS_ASSUME_NONNULL_END
