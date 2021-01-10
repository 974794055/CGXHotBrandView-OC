//
//  CGXHotBrandModel.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandModel : NSObject

/** 自定义原始数据源 */
@property (nonatomic, strong) NSObject *dataModel;
// 背景颜色
@property (nonatomic, strong) UIColor *itemColor;
// 图片
@property (nonatomic, strong) NSString *hotPicStr;
/** 图片左右间距  默认 0 */
@property (nonatomic, assign) CGFloat hotPicSpace;
/** 图片上间距  默认 10 */
@property (nonatomic, assign) CGFloat hotPicSpaceTop;

// 图片对应的文字显示
@property (nonatomic, strong) NSString *titleStr;
/** 轮播文字label颜色  [UIColor blackColor]; */
@property (nonatomic, strong) UIColor *titleColor;
/** 轮播文字背景颜 默认无 [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *titleBgColor;
/** 轮播文字label字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *titleFont;
/** 轮播文字label高度  默认 30 */
@property (nonatomic, assign) CGFloat titleHeight;
/** 文字上间距  默认 0 */
@property (nonatomic, assign) CGFloat titleSpaceTop;
/** 文字下间距  默认 0 */
@property (nonatomic, assign) CGFloat titleSpaceBottom;
/** 标签左间距  默认0 */
@property (nonatomic, assign) CGFloat titleHLpace;
/** 标签右间距  默认0 */
@property (nonatomic, assign) CGFloat titleHRpace;
/* 默认剧中*/
@property (nonatomic, assign) NSTextAlignment textAlignment;
/*  默认一行。为1*/
@property (nonatomic, assign) NSInteger numberOfLines;


/** --边框--- */
@property (nonatomic, strong) UIColor *tagBorderColor;
@property (nonatomic, assign) CGFloat tagBorderWidth;
@property (nonatomic, assign) CGFloat tagBorderRadius;

// 标签文字显示
@property (nonatomic, strong) NSString *tagStr;
/** 标签文字颜色  [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *tagColor;
/** 标签文字字体大小  [UIFont systemFontOfSize:10] */
@property (nonatomic, strong) UIFont  *tagFont;
/** 标签文字颜色  [UIColor redColor]; */
@property (nonatomic, strong) UIColor *tagBgColor;
/** 标签左右间距  默认1 0 */
@property (nonatomic, assign) CGFloat tagSpace;
/** 标签上间距  默认 0 */
@property (nonatomic, assign) CGFloat tagHSpace;
/** 标签右间距  默认10 */
@property (nonatomic, assign) CGFloat tagVSpace;
/** 标签高度  默认20 */
@property (nonatomic, assign) CGFloat tagHeight;
/* 角标样式  默认圆角*/
@property (nonatomic , assign) CGXHotBrandViewShowType showType;

/* 角标样式  CGXHotBrandViewShowTypeRounded 有效  默认CGXHotBrandRoundedTypeAll*/
@property (nonatomic , assign) CGXHotBrandRoundedType roundedType;
// 角标是否有动画
@property (nonatomic , assign) BOOL isAnimation;



// 下标对应文字
@property (nonatomic, strong) NSString *numStr;
/** 下标对应文字label颜色  [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *numColor;
/** 下标对应文字背景颜  [UIColor redColor]; */
@property (nonatomic, strong) UIColor *numBgColor;
/** 下标对应文字字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *numFont;
/** 下标对应文字高度  默认 30 */
@property (nonatomic, assign) CGFloat numHeight;
/** 下标对应文字宽度  默认 30 */
@property (nonatomic, assign) CGFloat numWidth;
/** 下标对应底部圆弧高度  默认 15 */
@property (nonatomic, assign) CGFloat bottomHeight;
/** 下标对应文字水边距  默认 10 */
@property (nonatomic, assign) CGFloat numHSpace;

@property (nonatomic, copy) void(^hotBrand_loadImageCallback)(UIImageView *hotImageView, NSURL *hotImageURL);

@end

NS_ASSUME_NONNULL_END
