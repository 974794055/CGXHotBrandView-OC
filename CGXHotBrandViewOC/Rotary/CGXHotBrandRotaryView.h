//
//  CGXHotBrandRotaryView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"
#import "CGXHotBrandModel.h"

@interface CGXHotBrandRotaryView : CGXHotBrandBaseView

//缩放系数 数值越大缩放越大 default 0.5
@property(nonatomic,assign) CGFloat itemScaleFactor;
//显示的item 奇数
@property (nonatomic) NSInteger visibleCount;

- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;

// 禁用 分页小圆点
- (void)setIsHavePage:(BOOL)isHavePage NS_UNAVAILABLE;
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets NS_UNAVAILABLE;
- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing NS_UNAVAILABLE;
- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing NS_UNAVAILABLE;
- (void)setAutoScroll:(BOOL)autoScroll NS_UNAVAILABLE;

@end
