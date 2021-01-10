//
//  CGXHotBrandBaseCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseCell.h"
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
    self.hotImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.hotImageView.layer.masksToBounds = YES;
    self.hotImageView.clipsToBounds = YES;
    self.hotImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:self.hotImageView];
    [self.contentView sendSubviewToBack:self.hotImageView];
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
}
- (void)cellOffsetOnCollectionView:(UICollectionView *)collectionView
{
    
}
@end
