//
//  CGXHotBrandTagLabel.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandTagLabel : UIView

@property (nonatomic , assign) CGFloat triangleW;
@property (nonatomic , assign) CGFloat triangleH;

/** --边框--- */
@property (nonatomic, strong) UIColor *tagBorderColor;
@property (nonatomic, assign) CGFloat tagBorderWidth;
@property (nonatomic, assign) CGFloat tagBorderRadius;

@property (nonatomic , assign) CGXHotBrandViewShowType showType;

@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;



/* 角标样式  CGXHotBrandViewShowTypeRounded 有效  默认CGXHotBrandRoundedTypeAll*/
@property (nonatomic , assign) CGXHotBrandRoundedType roundedType;

@end

NS_ASSUME_NONNULL_END
