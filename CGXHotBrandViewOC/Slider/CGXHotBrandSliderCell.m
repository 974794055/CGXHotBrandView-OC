//
//  CGXHotBrandSliderCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandSliderCell.h"

@interface CGXHotBrandSliderCell ()

@end
@implementation CGXHotBrandSliderCell
- (void)initializeViews
{
    [super initializeViews];
    self.hotImageView.hidden = NO;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}
- (void)updateWithHotBrandCellModel:(CGXHotBrandModel *)cellModel Section:(NSInteger)section Row:(NSInteger)row
{
    [super updateWithHotBrandCellModel:cellModel Section:section Row:row];
    self.hotImageTop.constant = 0;
    self.hotImageLeft.constant =0;
    self.hotImageRight.constant = 0;
    self.hotImageBottom.constant = 0;
}

@end
