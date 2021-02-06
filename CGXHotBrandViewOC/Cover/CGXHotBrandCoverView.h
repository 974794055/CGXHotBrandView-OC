//
//  CGXHotBrandCoverView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"
#import "CGXHotBrandModel.h"

@interface CGXHotBrandCoverView : CGXHotBrandBaseView

//宽度比例 0.1~1.0之间。 适当设置 default 1:3
@property(nonatomic,assign) CGFloat itemHeightScale;
//高度比例  0.5～1.0之间 适当设置 default 0.9
@property(nonatomic,assign) CGFloat itemWidthScale;

- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;
// 更新某个item
- (void)updateWithItemModel:(CGXHotBrandModel *)itemModel AtIndexPath:(NSIndexPath *)indexPath;

// 禁用 分页小圆点
- (void)setIsHavePage:(BOOL)isHavePage NS_UNAVAILABLE;
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets NS_UNAVAILABLE;
- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing NS_UNAVAILABLE;
- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing NS_UNAVAILABLE;
- (void)setInfiniteLoop:(BOOL)infiniteLoop NS_UNAVAILABLE;
- (void)setAutoScroll:(BOOL)autoScroll NS_UNAVAILABLE;

@end
