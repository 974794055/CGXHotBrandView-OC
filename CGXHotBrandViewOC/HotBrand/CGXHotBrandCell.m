//
//  CGXHotBrandCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCell.h"

@implementation CGXHotBrandCell

- (void)initializeViews
{
    [super initializeViews];
    self.titleLabel  =[[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    

}
- (void)updateWithHotBrandCellModel:(CGXHotBrandModel *)cellModel Section:(NSInteger)section Row:(NSInteger)row
{
    [super updateWithHotBrandCellModel:cellModel Section:section Row:row];
    self.titleLabel.text = cellModel.titleStr;
    self.titleLabel.textColor = cellModel.titleColor;
    self.titleLabel.font = cellModel.titleFont;
    if (cellModel.loadImageCallback != nil) {
        cellModel.loadImageCallback(self.hotImageView, [NSURL URLWithString:cellModel.hotPicStr]);
    }
    
    NSLayoutConstraint *hotTitleHeight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:self.cellModel.titleHeight];
    [self.titleLabel addConstraint:hotTitleHeight];
    
    NSLayoutConstraint *hotTitleleft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *hotTitleRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.cellModel.titleSpaceBottom];
    [self.contentView addConstraint:hotTitleleft];
    [self.contentView addConstraint:hotTitleRight];
    [self.contentView addConstraint:hotTitleBottom];
    
    
    NSLayoutConstraint *hotImageTop = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *hotImageLeft = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *hotImageRight = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *hotImageBottom = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:-self.cellModel.titleSpaceTop];
    [self.contentView addConstraint:hotImageTop];
    [self.contentView addConstraint:hotImageLeft];
    [self.contentView addConstraint:hotImageRight];
    [self.contentView addConstraint:hotImageBottom];
}
@end
