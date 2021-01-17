//
//  CGXHotBrandScrollView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2021/1/4.
//

#import "CGXHotBrandBaseView.h"
#import "CGXHotBrandDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandScrollView : CGXHotBrandBaseView

@property(strong,nonatomic,readonly)NSMutableArray<CGXHotBrandModel *> *dataArray;

/* 滚动样式 */
@property(nonatomic,assign) CGXHotBrandScrollType scrollType;
/* 滚动方向 */
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

/* 淡入淡出动画 默认NO */
@property(nonatomic,assign) BOOL fadeOpen;

/* 跑马灯 默认NO */
@property(nonatomic,assign) BOOL marquee;
/* 跑马灯 速度 默认10 */
@property(nonatomic,assign) CGFloat marqueeRate;

/* item下间距  默认NO 高度同pageHeight */
@property(nonatomic,assign) BOOL isHaveSpaceBottom;


/** 解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
- (void)adjustWhenControllerViewWillAppera;

/** 可以调用此方法手动控制滚动到哪一个index */
- (void)scrollViewScrollToIndex:(NSInteger)index;

// 更新数据源
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;


- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing NS_UNAVAILABLE;
- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing NS_UNAVAILABLE;
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
