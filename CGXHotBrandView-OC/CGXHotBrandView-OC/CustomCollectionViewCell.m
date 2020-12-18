//
//  CustomCollectionViewCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    self.hotImageView = [[UIImageView alloc] init];
    self.hotImageView.layer.masksToBounds = YES;
    self.hotImageView.clipsToBounds = YES;
    self.hotImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.hotImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:self.hotImageView];
    self.hotImageView.translatesAutoresizingMaskIntoConstraints = NO;
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
    self.hotImageView.backgroundColor = [UIColor blackColor];
    if (cellModel.hotBrand_loadImageCallback != nil) {
        cellModel.hotBrand_loadImageCallback(self.hotImageView, [NSURL URLWithString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547703274,3363083080&fm=11&gp=0.jpg"]);
    }
}
@end
