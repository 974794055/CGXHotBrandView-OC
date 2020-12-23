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

@property (nonatomic , assign) CGFloat cornerRadius;
@property (nonatomic , assign) CGXHotBrandViewShowType showType;

@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;


@end

NS_ASSUME_NONNULL_END
