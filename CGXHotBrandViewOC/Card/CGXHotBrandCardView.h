//
//  CGXHotBrandCardView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"
#import "CGXHotBrandCardFlowLayout.h"
#import "CGXHotBrandModel.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXHotBrandCardView;
@protocol CGXHotBrandCardViewDataSource <NSObject>

@required

@optional

/*上部分View*/
- (UIView *)gx_hotBrandCardTopView:(CGXHotBrandCardView *)hotView;
- (void)gx_hotBrandCardTopView:(CGXHotBrandCardView *)hotView AtInter:(NSInteger)inter ItemModel:(CGXHotBrandModel *)itemModel;
/*下部分View*/
- (UIView *)gx_hotBrandCardBottomView:(CGXHotBrandCardView *)hotView;
- (void)gx_hotBrandCardBottomView:(CGXHotBrandCardView *)hotView AtInter:(NSInteger)inter ItemModel:(CGXHotBrandModel *)itemModel;

@end

@interface CGXHotBrandCardView : CGXHotBrandBaseView

/*界面设置代理*/
@property (nonatomic , weak) id<CGXHotBrandCardViewDataSource>dataSource;

//宽度所占的比例 0～1之间 default 0.5 两端无效
@property(assign,nonatomic) CGFloat itemWidthScale;
//缩放系数 数值越大缩放越大 default 0.5
@property(nonatomic,assign) CGFloat itemScaleFactor;
// 停留的中心比例 0～1之间 default 0.5 两端无效
@property(nonatomic,assign) CGFloat itemContentOffsetX;
//左右的透明度 default 1
@property(nonatomic,assign) CGFloat itemAlpha;
//开启缩放 default NO
@property(nonatomic,assign) BOOL itemIsZoom;
/*放大对其的的位置 默认剧中*/
@property(nonatomic,assign) CGXHotBrandCellPosition   cellPosition;

//背景毛玻璃效果 default NO
@property(assign,nonatomic) BOOL itemEffect;
//毛玻璃背景的高度 (视图的高度*倍数) default 1 范围0~1
@property(assign,nonatomic) CGFloat itemEffectHeight;
//背景毛玻璃效果透明度 默认1
@property(assign,nonatomic) CGFloat itemEffectAlpha;

// 点击左右剧中 默认YES
@property(nonatomic,assign) BOOL itemClickCenter;
// item上间距 默认0
@property(assign,nonatomic) CGFloat itemSpaceTop;
// item下间距 默认0
@property(assign,nonatomic) CGFloat itemSpaceBottom;

- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;

// 更新某个item
- (void)updateWithItemModel:(CGXHotBrandModel *)itemModel AtIndexPath:(NSIndexPath *)indexPath;

/** 解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
- (void)adjustWhenControllerViewWillAppera;


- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets NS_UNAVAILABLE;

@end


NS_ASSUME_NONNULL_END
