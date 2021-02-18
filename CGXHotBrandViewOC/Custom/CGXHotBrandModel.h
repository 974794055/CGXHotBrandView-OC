//
//  CGXHotBrandModel.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandDefines.h"
#import "CGXHotBrandTextModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandModel : NSObject

/** 自定义原始数据源 */
@property (nonatomic, strong) NSObject *dataModel;
// 背景颜色
@property (nonatomic, strong) UIColor *itemColor;
/** --cell边框--- */
/** 下标对应文字背景颜  [UIColor redColor]; */
@property (nonatomic, strong) UIColor *itemBorderColor;
@property (nonatomic, assign) CGFloat itemBorderWidth;
@property (nonatomic, assign) CGFloat itemBorderRadius;
// 图片
@property (nonatomic, strong) NSString *hotPicStr;
/** 图片左右间距  默认 0 */
@property (nonatomic, assign) CGFloat hotPicSpace;
/** 图片上间距  默认 10 */
@property (nonatomic, assign) CGFloat hotPicSpaceTop;
/** 图片加载 */
@property (nonatomic, copy) void(^hotBrand_loadImageCallback)(UIImageView *hotImageView, NSURL *hotImageURL);

/*  标题 */
@property (nonatomic, strong) CGXHotBrandTextModel *titleModel;
/** 轮播文字label高度  默认 30 */
@property (nonatomic, assign) CGFloat titleHeight;

/* 标签文字显示 */
@property (nonatomic, strong) CGXHotBrandTextModel *tagModel;
/** 标签高度  默认20 */
@property (nonatomic, assign) CGFloat tagHeight;
/* 角标样式  默认圆角*/
@property (nonatomic , assign) CGXHotBrandViewShowType showType;
/* 角标样式  CGXHotBrandViewShowTypeRounded 有效  默认CGXHotBrandRoundedTypeAll*/
@property (nonatomic , assign) CGXHotBrandRoundedType roundedType;
// 角标是否有动画
@property (nonatomic , assign) BOOL isAnimation;

/* 副标签文字显示 */
@property (nonatomic, strong) CGXHotBrandTextModel *numModel;
/** 下标对应文字高度  默认 30 */
@property (nonatomic, assign) CGFloat numHeight;
/** 下标对应文字宽度  默认 30 */
@property (nonatomic, assign) CGFloat numWidth;
/** 下标对应底部圆弧高度  默认 15 */
@property (nonatomic, assign) CGFloat bottomHeight;


@end

NS_ASSUME_NONNULL_END
