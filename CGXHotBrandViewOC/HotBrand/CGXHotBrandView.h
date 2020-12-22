//
//  CGXHotBrandView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"
#import "CGXHotBrandModel.h"
#import "CGXHotBrandCell.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXHotBrandView;
@protocol CGXHotBrandViewDataSource <NSObject>

@required

@optional
/*点击cell*/
- (void)gx_hotBrandView:(CGXHotBrandView *)hotView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                AtModel:(CGXHotBrandModel *)hotModel;
/* 处理cell显示*/
- (void)gx_hotBrandView:(CGXHotBrandView *)hotView
 cellForItemAtIndexPath:(NSIndexPath *)indexPath
                 AtCell:(UICollectionViewCell *)cell
                AtModel:(CGXHotBrandModel *)hotModel;

@end

@interface CGXHotBrandView : CGXHotBrandBaseView

@property (nonatomic, strong,readonly) NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *dataArray;

/*界面设置代理*/
@property (nonatomic , weak) id<CGXHotBrandViewDataSource>dataSource;

/* 圆点所在高度 默认 20 */
@property (nonatomic, assign) CGFloat pageHeight;
///* 选中的色，默认红色 */
@property(nonatomic,strong) UIColor *pageSelectColor;
/* 背景色，默认灰色 */
@property(nonatomic,strong) UIColor *pageNormalColor;
/* 是否分页 默认YES*/
@property (nonatomic , assign) BOOL pagingEnabled;
/* 是否回弹 默认YES*/
@property (nonatomic , assign) BOOL bounces;
/* 是否有分页原点*/
@property (nonatomic , assign) BOOL isHavePage;

/* 是否回弹 默认YES*/
@property (nonatomic , assign) CGXHotBrandViewShowType showType;
// 角标是否有动画
@property (nonatomic , assign) BOOL isAnimation;

/** 更新数据源   */
- (void)updateWithDataArray:(NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *)dataArray;

@end

NS_ASSUME_NONNULL_END

