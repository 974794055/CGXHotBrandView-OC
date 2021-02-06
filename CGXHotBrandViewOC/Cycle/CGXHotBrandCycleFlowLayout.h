//
//  CGXHotBrandCycleFlowLayout.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CGXHotBrandCycleFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>
@optional
/*
item的高
 */
- (CGFloat)hotBrandCycleItemWidthAtheight:(CGFloat)height;
/*
 几行
 */
- (NSInteger)hotBrandCycleSectionAtIndex:(NSInteger)section;
/*
 每行几个item
 */
- (NSInteger)hotBrandCycleRowAtIndex:(NSInteger)section;


@end

@interface CGXHotBrandCycleFlowLayout : CGXHotBrandBaseFlowLayout

/** 多少行 */
@property (nonatomic, assign) NSInteger itemSectionCount;
/** 每行展示多少个item */
@property (nonatomic, assign) NSInteger itemRowCount;
/* 比例 0.0 ～ 1.0 之间 两端无效 默认0.5 */
@property (nonatomic, assign) CGFloat offsetX; //

@property (nonatomic , weak) id<CGXHotBrandCycleFlowLayoutDelegate>cycleDelegate;

@end

NS_ASSUME_NONNULL_END
