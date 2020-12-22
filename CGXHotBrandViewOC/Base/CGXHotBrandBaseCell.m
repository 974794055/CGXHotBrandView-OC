//
//  CGXHotBrandBaseCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseCell.h"
#import "UIView+CGXHotBrandRounded.h"
@interface CGXHotBrandBaseCell ()

@property (nonatomic, assign) NSInteger totalInter;

@end

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.hotImageView = [[UIImageView alloc] init];
    self.hotImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.hotImageView];
    self.hotImageView.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
}
- (void)updateWithHotBrandCellModel:(CGXHotBrandModel *)cellModel Section:(NSInteger)section Row:(NSInteger)row
{
    self.cellModel = cellModel;
    self.contentView.backgroundColor = cellModel.itemColor;
    
    [self.contentView gx_hotBrandRoundedWithRadius:cellModel.borderRadius];
    [self.contentView gx_hotBrandBorderWithColor:cellModel.borderColor borderWidth:cellModel.borderWidth];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}
@end
