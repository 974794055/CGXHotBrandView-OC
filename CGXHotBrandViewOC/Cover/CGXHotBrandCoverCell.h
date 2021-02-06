//
//  CGXHotBrandCoverCell.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseCell.h"
#import "CGXHotBrandTagLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandCoverCell : CGXHotBrandBaseCell

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *subLabel;
@property (nonatomic , strong) CGXHotBrandTagLabel *tagLabel;

@end

NS_ASSUME_NONNULL_END
