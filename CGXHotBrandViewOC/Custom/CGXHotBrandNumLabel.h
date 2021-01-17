//
//  CGXHotBrandNumLabel.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2021/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandNumLabel : UIView

// 下标对应文字
@property (nonatomic, strong) NSString *numStr;
/** 下标对应文字label颜色  [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *numColor;
/** 下标对应文字字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *numFont;
@property (nonatomic, assign) CGFloat bottomHeight;

@end

NS_ASSUME_NONNULL_END
