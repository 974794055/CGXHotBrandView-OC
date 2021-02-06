//
//  CGXHotBrandCoverCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCoverCell.h"
#import "CGXHotBrandCoverFlowLayout.h"

@interface CGXHotBrandCoverCell ()

@property (nonatomic , strong) NSLayoutConstraint *hotTitleHeight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleleft;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleBottom;

@property (nonatomic , strong) NSLayoutConstraint *hotSubHeight;
@property (nonatomic , strong) NSLayoutConstraint *hotSubleft;
@property (nonatomic , strong) NSLayoutConstraint *hotSubRight;
@property (nonatomic , strong) NSLayoutConstraint *hotSubBottom;

@property (nonatomic , strong) NSLayoutConstraint *tagTitleHeight;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleWidth;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleTop;

@end

@implementation CGXHotBrandCoverCell

- (void)initializeViews
{
    [super initializeViews];
    
    self.titleLabel  =[[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.tagLabel = [[CGXHotBrandTagLabel alloc] init];
    self.tagLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView bringSubviewToFront:self.tagLabel];
    self.tagLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tagLabel.layer.masksToBounds = YES;
    self.tagLabel.clipsToBounds = YES;
    
    
    self.subLabel  =[[UILabel alloc] init];
    self.subLabel.textColor = [UIColor whiteColor];
    self.subLabel.font = [UIFont systemFontOfSize:12];
    self.subLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.subLabel];
    self.subLabel.translatesAutoresizingMaskIntoConstraints = NO;


    self.hotTitleHeight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [self.titleLabel addConstraint:self.hotTitleHeight];

    self.hotTitleleft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    self.hotTitleRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    self.hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.cellModel.titleSpaceBottom];
    [self.contentView addConstraint:self.hotTitleleft];
    [self.contentView addConstraint:self.hotTitleRight];
    [self.contentView addConstraint:self.hotTitleBottom];

    self.tagTitleHeight = [NSLayoutConstraint constraintWithItem:self.tagLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:15];
    [self.tagLabel addConstraint:self.tagTitleHeight];

    self.tagTitleWidth = [NSLayoutConstraint constraintWithItem:self.tagLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [self.tagLabel addConstraint:self.tagTitleWidth];

    self.tagTitleTop = [NSLayoutConstraint constraintWithItem:self.tagLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.tagTitleTop];

    self.tagTitleRight = [NSLayoutConstraint constraintWithItem:self.tagLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:5];
    [self.contentView addConstraint:self.tagTitleRight];
    
    
    self.hotSubHeight = [NSLayoutConstraint constraintWithItem:self.subLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:15];
    [self.subLabel addConstraint:self.hotSubHeight];

    self.hotSubBottom = [NSLayoutConstraint constraintWithItem:self.subLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.hotSubBottom];

    self.hotSubleft = [NSLayoutConstraint constraintWithItem:self.subLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.hotSubleft];

    self.hotSubRight = [NSLayoutConstraint constraintWithItem:self.subLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:5];
    [self.contentView addConstraint:self.hotSubRight];
    
    
    
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
    self.hotImageBottom.constant = -cellModel.titleHeight;
    
    self.titleLabel.text = cellModel.titleStr;
    self.titleLabel.textColor = cellModel.titleColor;
    self.titleLabel.font = cellModel.titleFont;
    self.titleLabel.textAlignment = cellModel.textAlignment;
    self.hotTitleHeight.constant = cellModel.titleHeight;
    self.hotTitleleft.constant = cellModel.titleHLpace;
    self.hotTitleRight.constant = -cellModel.titleHRpace;
    
    NSString *text = cellModel.tagStr ? cellModel.tagStr:@"";
    self.tagLabel.titleStr =  text;
    self.tagLabel.titleColor = cellModel.tagColor;;
    self.tagLabel.backgroundColor = cellModel.tagBgColor;
    self.tagLabel.tagBorderColor = cellModel.tagBorderColor;
    self.tagLabel.showType =  cellModel.showType;
    self.tagLabel.roundedType =  cellModel.roundedType;
    if (cellModel.tagStr && cellModel.tagStr.length > 0 && ![cellModel.tagStr isEqualToString:@""]) {
        self.tagLabel.hidden = NO;
    } else{
        self.tagLabel.hidden = YES;
    }
    
    self.hotSubHeight.constant = 20;
    self.hotSubleft.constant =10;
    self.hotSubRight.constant = -10;
    self.hotSubBottom.constant = -cellModel.titleHeight;;
    
    [self.tagLabel layoutIfNeeded];
    
    self.subLabel.text = @"哈哈哈";

}
- (void)cellOffsetOnCollectionView:(UICollectionView *)collectionView
{
    [super cellOffsetOnCollectionView:collectionView];
    CGXHotBrandCoverFlowLayout *layout = (CGXHotBrandCoverFlowLayout *)collectionView.collectionViewLayout;
    CGFloat needScale = [layout cellOffsetAtIndex:self.row];
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear animations:^{
        [self updateWithLabel:needScale];
    } completion:^(BOOL finished) {

    }];
}
- (void)updateWithLabel:(CGFloat)needScale
{
    UIFont *font = [UIFont systemFontOfSize:self.cellModel.tagFont.pointSize * needScale];
    NSString *text = self.cellModel.tagStr ? self.cellModel.tagStr:@"";
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    CGFloat width = ceil(size.width+self.cellModel.tagSpace);

    self.hotImageBottom.constant = -self.cellModel.titleHeight*needScale;
    
    self.titleLabel.font = [UIFont systemFontOfSize:self.cellModel.titleFont.pointSize * needScale];
    self.hotTitleHeight.constant = self.cellModel.titleHeight*needScale;
    self.hotTitleleft.constant = self.cellModel.titleHLpace*needScale;
    self.hotTitleRight.constant = -self.cellModel.titleHRpace*needScale;
    
    
    self.tagTitleWidth.constant = width;
    self.tagTitleHeight.constant = self.cellModel.tagHeight*needScale;
    self.tagTitleTop.constant = self.cellModel.tagVSpace*needScale;
    self.tagTitleRight.constant = -self.cellModel.tagHSpace*needScale;
    
    self.tagLabel.titleFont = font;
    self.tagLabel.tagBorderRadius = self.cellModel.tagBorderRadius*needScale;
    self.tagLabel.tagBorderWidth = self.cellModel.tagBorderWidth*needScale;
    
    self.hotSubHeight.constant = 20*needScale;
    self.hotSubBottom.constant = -self.cellModel.titleHeight*needScale;
}

@end
