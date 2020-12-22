//
//  CGXHotBrandCycleView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"
#import "CGXHotBrandCycleCell.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXHotBrandCycleView;


@protocol CGXHotBrandCycleViewDataSource <NSObject>

@required

@optional
/*点击cell*/
- (void)gx_hotBrandCycleView:(CGXHotBrandCycleView *)hotView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                     AtModel:(CGXHotBrandModel *)hotModel;
/* 处理cell显示*/
- (void)gx_hotBrandCycleView:(CGXHotBrandCycleView *)hotView
      cellForItemAtIndexPath:(NSIndexPath *)indexPath
                      AtCell:(UICollectionViewCell *)cell
                     AtModel:(CGXHotBrandModel *)hotModel;

@end

@interface CGXHotBrandCycleView : CGXHotBrandBaseView

/*界面设置代理*/
@property (nonatomic , weak) id<CGXHotBrandCycleViewDataSource>dataSource;

/* 比例 0.0 ～ 1.0 之间 两端无效 默认0.5 */
@property (nonatomic, assign) CGFloat offsetX; //

/* 宽度是高度的倍数。默认 1.0  */
@property (nonatomic, assign) CGFloat widthSpace; //

/** 是否自动滚动,默认NO */
@property (nonatomic,assign) BOOL autoScroll;
/** 滚动速度设置  默认 10   */
@property (nonatomic, assign) CGFloat scrollOffsetX;

@property (nonatomic, strong,readonly) NSMutableArray<CGXHotBrandModel *> *dataArray;

/** 更新数据源   */
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
