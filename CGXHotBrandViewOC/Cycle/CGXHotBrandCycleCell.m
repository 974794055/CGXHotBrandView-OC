//
//  CGXHotBrandCycleCell.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCycleCell.h"
@interface CGXHotBrandCycleCell ()

@property (nonatomic , strong) NSLayoutConstraint *hotImageTop;
@property (nonatomic , strong) NSLayoutConstraint *hotImageLeft;
@property (nonatomic , strong) NSLayoutConstraint *hotImageRight;
@property (nonatomic , strong) NSLayoutConstraint *hotImageBottom;

@end

@implementation CGXHotBrandCycleCell

- (void)initializeViews
{
    [super initializeViews];
    
    self.hotImageTop = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    self.hotImageLeft = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    self.hotImageRight = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    self.hotImageBottom = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:30];
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
    [super updateWithHotBrandCellModel:cellModel Section:section Row:row];

    self.hotImageTop.constant = 0;
    self.hotImageLeft.constant =0;
    self.hotImageRight.constant = 0;
    self.hotImageBottom.constant = 0;
    
    
    if (!([cellModel.hotPicStr hasPrefix:@"http:"] || [cellModel.hotPicStr hasPrefix:@"https:"])) {
        UIImage *image = [UIImage imageNamed:cellModel.hotPicStr];
        if (!image) {
            image = [UIImage imageWithContentsOfFile:cellModel.hotPicStr];
        }
        self.hotImageView.image = image;
    }
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}

@end
