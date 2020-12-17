//
//  CGXHotBrandCycleCell.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCycleCell.h"

@implementation CGXHotBrandCycleCell

- (void)initializeViews
{
    [super initializeViews];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateUI];
    
}

- (void)updateUI
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:top];
    [self.contentView addConstraint:left];
    [self.contentView addConstraint:right];
    [self.contentView addConstraint:bottom];
}
- (void)updateWithHotBrandCellModel:(CGXHotBrandModel *)cellModel Section:(NSInteger)section Row:(NSInteger)row
{
    [super updateWithHotBrandCellModel:cellModel Section:section Row:row];
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
    [self updateUI];
    
    __weak typeof(self) weakSelf = self;
    if (cellModel.loadImageCallback != nil) {
        cellModel.loadImageCallback(weakSelf.hotImageView, [NSURL URLWithString:cellModel.hotPicStr]);
    }
}

@end
