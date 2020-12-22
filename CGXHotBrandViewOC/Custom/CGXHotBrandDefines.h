//
//  CGXHotBrandDefines.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/22.
//

#ifndef CGXHotBrandDefines_h
#define CGXHotBrandDefines_h

typedef NS_ENUM(NSInteger, CGXHotBrandViewShowType) {
    CGXHotBrandViewShowTypeRounded, // 四角圆角
    CGXHotBrandViewShowTypeJDChat,//气泡
    CGXHotBrandViewShowTypeJDRound,//单边圆角
    CGXHotBrandViewShowTypeChat,// 聊天气泡样式
};

#define CGXHotBrandViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#endif /* CGXHotBrandDefines_h */
