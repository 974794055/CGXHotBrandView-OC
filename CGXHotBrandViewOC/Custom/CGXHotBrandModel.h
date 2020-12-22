//
//  CGXHotBrandModel.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandModel : NSObject

/** 轮播图点击事件原始l数据源 */
@property (nonatomic, strong) NSObject *dataModel;
// 背景颜色
@property (nonatomic, strong) UIColor *itemColor;
// 图片
@property (nonatomic, strong) NSString *hotPicStr;
/** 图片左右间距  默认 10 */
@property (nonatomic, assign) CGFloat hotPicSpace;
/** 图片上间距  默认 10 */
@property (nonatomic, assign) CGFloat hotPicSpaceTop;
// 图片对应的文字显示
@property (nonatomic, strong) NSString *titleStr;
/** 轮播文字label字体颜色  [UIColor blackColor]; */
@property (nonatomic, strong) UIColor *titleColor;
/** 轮播文字label字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *titleFont;
/** 轮播文字label高度  默认 30 */
@property (nonatomic, assign) CGFloat titleHeight;
/** 文字上间距  默认 0 */
@property (nonatomic, assign) CGFloat titleSpaceTop;
/** 文字下间距  默认 0 */
@property (nonatomic, assign) CGFloat titleSpaceBottom;

/** --边框--- */
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat borderRadius;

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


@end

NS_ASSUME_NONNULL_END
