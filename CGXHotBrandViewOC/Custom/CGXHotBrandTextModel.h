//
//  CGXHotBrandTextModel.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandTextModel : NSObject

// 图片对应的文字显示
@property (nonatomic, strong) NSString *text;
/** 轮播文字label颜色  [UIColor blackColor]; */
@property (nonatomic, strong) UIColor *color;
/** 轮播文字背景颜 默认无 [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *bgColor;
/** 轮播文字label字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *font;
/** 文字补充间距  默认 10 */
@property (nonatomic, assign) CGFloat space;
/** 文字上间距  默认 0 */
@property (nonatomic, assign) CGFloat spaceTop;
/** 文字下间距  默认 0 */
@property (nonatomic, assign) CGFloat spaceBottom;
/** 标签左间距  默认0 */
@property (nonatomic, assign) CGFloat spaceLeft;
/** 标签右间距  默认0 */
@property (nonatomic, assign) CGFloat spaceRight;
/* 默认剧中*/
@property (nonatomic, assign) NSTextAlignment textAlignment;
/*  默认一行。为1*/
@property (nonatomic, assign) NSInteger numberOfLines;

/** --cell边框--- */
/** 下标对应文字背景颜  [UIColor redColor]; */
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat borderRadius;

@end

NS_ASSUME_NONNULL_END
