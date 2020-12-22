//
//  CGXHotBrandCell.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseCell.h"
#import "CGXHotBrandTagLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandCell : CGXHotBrandBaseCell

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong)CGXHotBrandTagLabel *tagLabel;


- (void)updateWithSHowType:(CGXHotBrandViewShowType)showType IsAnimation:(BOOL)isAnimation;

@end

NS_ASSUME_NONNULL_END
