//
//  CGXHotBrandIndicatorView.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2021/11/3.
//

#import "CGXHotBrandBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandIndicatorView : CGXHotBrandBaseView
@property(nonatomic, assign) CGXHotBrandPageStyle dotStyle;
/**Number of pages for control. Default is 0.*/
@property (nonatomic) NSInteger pagesNumber;
/** Current page on which control is active. Default is 0.*/
@property (nonatomic) NSInteger pageCurrent;
/* 圆点所在高度 默认 20 */
@property (nonatomic, assign) CGFloat pageHeight;
///* 选中的色，默认红色 */
@property(nonatomic,strong) UIColor *pageSelectColor;
/* 背景色，默认灰色 */
@property(nonatomic,strong) UIColor *pageNormalColor;
/* 选中图 */
@property(nonatomic,strong) UIImage *pageSelectImage;
/* 背景图 */
@property(nonatomic,strong) UIImage *pageNormalImage;
/* 圆点延展 */
@property(nonatomic, assign) CGFloat pageWidthSpace;
/* 圆点间距 默认 10 */
@property(nonatomic, assign) CGFloat pageBetween;
/* 圆点边框默认颜色 */
@property(nonatomic, strong) UIColor *pageBorderColor;
/* 圆点边框选择颜色 */
@property(nonatomic, strong) UIColor *pageBorderSelectColor;
/*圆点边框宽度 */
@property(nonatomic, assign) CGFloat pageBorderWidth;
/* 原点大小 默认 CGSizeMake(10, 10) */
@property (nonatomic, assign) CGSize pageSize;
/* 是否分页 默认YES*/
@property (nonatomic , assign) BOOL pagingEnabled;
/* 是否有分页原点*/
@property (nonatomic , assign) BOOL isHavePage;
/** 分页控件距离轮播图的底部间距（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageBottomOffset;
/** 分页控件距离轮播图的右边间距（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageHorizontalOffset;
/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property(nonatomic,assign) BOOL hidesPage;
/* 圆点对齐方式 默认剧中*/
@property(nonatomic,assign) CGXHotBrandPageAliment pageContolAliment;
@end

NS_ASSUME_NONNULL_END
