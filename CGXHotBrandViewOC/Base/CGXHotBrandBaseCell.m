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

@property (nonatomic , assign ,readwrite) NSInteger section;
@property (nonatomic , assign ,readwrite) NSInteger row;

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
    self.hotImageView.contentMode = UIViewContentModeScaleToFill;
    self.hotImageView.layer.masksToBounds = YES;
    self.hotImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.hotImageView];
    [self.contentView sendSubviewToBack:self.hotImageView];
    self.hotImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.hotImageTop = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    self.hotImageLeft = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.hotImageRight = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    self.hotImageBottom = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30];
    [self.contentView addConstraint:self.hotImageTop];
    [self.contentView addConstraint:self.hotImageLeft];
    [self.contentView addConstraint:self.hotImageRight];
    [self.contentView addConstraint:self.hotImageBottom];
    
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
    self.section = section;
    self.row = row;
    self.contentView.backgroundColor = cellModel.itemColor;
    if ([cellModel.hotPicStr hasPrefix:@"http:"] || [cellModel.hotPicStr hasPrefix:@"https:"]) {
        __weak typeof(self) weakSelf = self;
        if (cellModel.hotBrand_loadImageCallback != nil) {
            cellModel.hotBrand_loadImageCallback(weakSelf.hotImageView, [NSURL URLWithString:cellModel.hotPicStr]);
        }
    } else{
        UIImage *image = [UIImage imageNamed:cellModel.hotPicStr];
        if (!image) {
            image = [UIImage imageWithContentsOfFile:cellModel.hotPicStr];
        }
        self.hotImageView.image = image;
    }
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    [self.contentView gx_hotBrandBorderWithColor:cellModel.itemBorderColor borderWidth:cellModel.itemBorderWidth];
    [self.contentView gx_hotBrandRoundedWithAllRadius:cellModel.itemBorderRadius];
    
}
- (void)cellOffsetOnCollectionView:(UICollectionView *)collectionView
{
    
}

@end
