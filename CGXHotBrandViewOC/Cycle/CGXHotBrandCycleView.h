//
//  CGXHotBrandCycleView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandIndicatorView.h"
#import "CGXHotBrandCycleCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandCycleView : CGXHotBrandIndicatorView

/** 多少行  默认2行  */
@property (nonatomic, assign) NSInteger itemSectionCount;
/** 每行展示多少个item  默认5个*/
@property (nonatomic, assign) NSInteger itemRowCount;

/* 比例 0.0 ～ 1.0 之间 两端无效 默认0.5 */
@property (nonatomic, assign) CGFloat offsetX; //

/* 宽度是高度的倍数。默认 1.0  */
@property (nonatomic, assign) CGFloat widthSpace; //

/** 滚动速度设置  默认 10   */
@property (nonatomic, assign) CGFloat scrollOffsetX;

@property (nonatomic, strong,readonly) NSMutableArray<CGXHotBrandModel *> *dataArray;

/** 更新数据源   */
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;

// 禁用 分页小圆点
- (void)setIsHavePage:(BOOL)isHavePage NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
