//
//  CGXHotBrandZoomView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class CGXHotBrandZoomView;
@protocol CGXHotBrandZoomViewDataSource <NSObject>

@required

@optional

/*上部分View*/
- (UIView *)gx_hotBrandZoomTopView:(CGXHotBrandZoomView *)hotView;
- (void)gx_hotBrandZoomTopView:(CGXHotBrandZoomView *)hotView AtInter:(NSInteger)inter ItemModel:(CGXHotBrandModel *)itemModel;
/*下部分View*/
- (UIView *)gx_hotBrandZoomBottomView:(CGXHotBrandZoomView *)hotView;
- (void)gx_hotBrandZoomBottomView:(CGXHotBrandZoomView *)hotView AtInter:(NSInteger)inter ItemModel:(CGXHotBrandModel *)itemModel;

@end

@interface CGXHotBrandZoomView : CGXHotBrandBaseView

/*界面设置代理*/
@property (nonatomic , weak) id<CGXHotBrandZoomViewDataSource>dataSource;

@property(strong,nonatomic,readonly)NSMutableArray<CGXHotBrandModel *> *dataArray;
//宽度所占的比例 default 0.5
@property(assign,nonatomic) CGFloat itemWidthScale;
//item缩放比例所占的比例 default 0.5
@property(assign,nonatomic) CGFloat itemZoomcale;

//背景毛玻璃效果 default NO
@property(assign,nonatomic) BOOL itemEffect;
//毛玻璃背景的高度 (视图的高度*倍数) default 1 范围0~1
@property(assign,nonatomic) CGFloat itemEffectHeight;
//背景毛玻璃效果透明度 默认1
@property(assign,nonatomic) CGFloat itemEffectAlpha;


//是否点击放大 NO
@property(assign,nonatomic) BOOL isCenter;

// 更新数据源
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;
// 更新某个item
- (void)updateWithItemModel:(CGXHotBrandModel *)itemModel AtIndexPath:(NSIndexPath *)indexPath;


- (void)setAutoScroll:(BOOL)autoScroll NS_UNAVAILABLE;
- (void)setIsHavePage:(BOOL)isHavePage NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
