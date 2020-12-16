//
//  CGXHotBrandBaseCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseCell.h"

@implementation CGXHotBrandBaseCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    self.backgroundColor = [UIColor orangeColor];
    self.hotImageView = [[UIImageView alloc] init];
    self.hotImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.hotImageView];
    self.hotImageView.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

}
- (void)updateWithHotBrandCellModel:(CGXHotBrandModel *)cellModel Section:(NSInteger)section Row:(NSInteger)row
{
    self.cellModel = cellModel;
    self.contentView.backgroundColor = cellModel.itemColor;
}
@end
