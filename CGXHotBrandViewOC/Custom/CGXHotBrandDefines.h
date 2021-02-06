//
//  CGXHotBrandDefines.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#ifndef CGXHotBrandDefines_h
#define CGXHotBrandDefines_h

typedef NS_ENUM(NSInteger, CGXHotBrandViewShowType) {
    CGXHotBrandViewShowTypeRounded = 0, // 四角圆角
    CGXHotBrandViewShowTypeJDChat = 1,//气泡
    CGXHotBrandViewShowTypeChat = 2// 聊天气泡样式
};
typedef NS_OPTIONS (NSUInteger, CGXHotBrandRoundedType) {
    CGXHotBrandRoundedTypeTopLeft     = UIRectCornerTopLeft, // 左上角
    CGXHotBrandRoundedTypeTopRight    = UIRectCornerTopRight, // 右上角
    CGXHotBrandRoundedTypeBottomLeft  = UIRectCornerBottomLeft, // 左下角
    CGXHotBrandRoundedTypeBottomRight = UIRectCornerBottomRight, // 右下角
    CGXHotBrandRoundedTypeAll  = UIRectCornerAllCorners// 全部四个角
};
/*
 *cell卡片对齐动画的位置
 */
typedef NS_ENUM(NSInteger, CGXHotBrandCellPosition) {
    CGXHotBrandCellPositionCenter      = 0,             //居中 默认
    CGXHotBrandCellPositionBottom      = 1,             //置底
    CGXHotBrandCellPositionTop         = 2,             //顶部
};

typedef NS_ENUM(NSInteger, CGXHotBrandScrollType) {
    CGXHotBrandScrollTypeOnlyImage, //置底
    CGXHotBrandScrollTypeOnlyTitle, //顶部
    CGXHotBrandScrollTypeImageTitle
};
/*
 *圆点对齐方式
 */
typedef NS_ENUM(NSInteger, CGXHotBrandPageAliment) {
    CGXHotBrandPageAlimentCenter  = 0, //居中 默认
    CGXHotBrandPageAlimentLeft    = 1, //左对齐
    CGXHotBrandPageAlimentRight   = 2, //右对齐
};
/*
 *圆点样式
 */
typedef NS_ENUM(NSInteger, CGXHotBrandPageStyle) {
    CGXHotBrandPageModelSystem,//系统样式 默认
    CGXHotBrandPageModelImage, //带有数字样式
    CGXHotBrandPageModelNumber //带有数字样式
};


#define CGXHotBrandViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)


#endif /* CGXHotBrandDefines_h */
