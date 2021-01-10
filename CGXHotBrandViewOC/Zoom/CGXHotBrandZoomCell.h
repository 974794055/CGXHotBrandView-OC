//
//  CGXHotBrandZoomCell.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseCell.h"
#import "CGXHotBrandTagLabel.h"
#import "CGXHotBrandNumLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandZoomCell : CGXHotBrandBaseCell

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) CGXHotBrandTagLabel *tagLabel;

@property (nonatomic , strong) CGXHotBrandNumLabel *numLabel;

@end

NS_ASSUME_NONNULL_END
