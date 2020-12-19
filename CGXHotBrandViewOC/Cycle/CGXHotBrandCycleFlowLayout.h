//
//  CGXHotBrandCycleFlowLayout.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CGXHotBrandCycleFlowLayoutDelegate <NSObject>
@optional

- (CGFloat)hotBrand_collectionView:(UICollectionView *)collectionView
                 ItemWidthAtheight:(CGFloat)height;

@end

@interface CGXHotBrandCycleFlowLayout : CGXHotBrandBaseFlowLayout


/* 比例 0.0 ～ 1.0 之间 两端无效 默认0.5 */
@property (nonatomic, assign) CGFloat offsetX; //

@property (nonatomic , weak) id<CGXHotBrandCycleFlowLayoutDelegate>cycleDelegate;

@end

NS_ASSUME_NONNULL_END
