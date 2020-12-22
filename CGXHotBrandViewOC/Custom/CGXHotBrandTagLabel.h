//
//  CGXHotBrandTagLabel.h
//  QQQQQ
//
//  Created by 曹贵鑫 on 2020/1/30.
//  Copyright © 2020 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandTagLabel : UIView

@property (nonatomic , assign) CGFloat triangleW;
@property (nonatomic , assign) CGFloat triangleH;

@property (nonatomic , assign) CGFloat cornerRadius;
@property (nonatomic , assign) CGXHotBrandViewShowType showType;

@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;


@end

NS_ASSUME_NONNULL_END
