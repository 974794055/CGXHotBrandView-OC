//
//  CGXHotBrandScrollCell.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseCell.h"
#import "CGXHotBrandDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandScrollCell : CGXHotBrandBaseCell

@property (nonatomic , strong) UILabel *titleLabel;

/* 滚动样式 */
@property(nonatomic,assign) CGXHotBrandScrollType scrollType;

@end

NS_ASSUME_NONNULL_END
