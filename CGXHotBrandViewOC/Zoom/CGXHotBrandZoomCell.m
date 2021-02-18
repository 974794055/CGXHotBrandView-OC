//
//  CGXHotBrandZoomCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "CGXHotBrandZoomCell.h"
#import "UIView+CGXHotBrandRounded.h"
#import "CGXHotBrandZoomFlowLayout.h"

#define pMaxScale 1.0//最大的拉伸比例
#define pNormalScale 0.7 //最小的缩放比例

@interface CGXHotBrandZoomCell ()

@property (nonatomic , strong) NSLayoutConstraint *tagTitleHeight;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleWidth;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleTop;

@property (nonatomic , strong) NSLayoutConstraint *hotTitleHeight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleleft;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleBottom;

@property (nonatomic , strong) NSLayoutConstraint *numHeight;
@property (nonatomic , strong) NSLayoutConstraint *numWidth;
@property (nonatomic , strong) NSLayoutConstraint *numLeft;
@property (nonatomic , strong) NSLayoutConstraint *numTop;

@end

@implementation CGXHotBrandZoomCell

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
    
    self.numLabel = [[CGXHotBrandNumLabel alloc] init];
    self.numLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.numLabel];
    [self.contentView bringSubviewToFront:self.numLabel];
    self.numLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.clipsToBounds = YES;
    self.numLabel.hidden = YES;
    
    self.numHeight = [NSLayoutConstraint constraintWithItem:self.numLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [self.numLabel addConstraint:self.numHeight];
    
    self.numWidth = [NSLayoutConstraint constraintWithItem:self.numLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:40];
    [self.numLabel addConstraint:self.numWidth];
    
    self.numLeft = [NSLayoutConstraint constraintWithItem:self.numLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.numLeft];
    
    self.numTop = [NSLayoutConstraint constraintWithItem:self.numLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.numTop];
    
    
    self.tagTitleHeight = [NSLayoutConstraint constraintWithItem:self.tagLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:15];
    [self.tagLabel addConstraint:self.tagTitleHeight];
    
    self.tagTitleWidth = [NSLayoutConstraint constraintWithItem:self.tagLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [self.tagLabel addConstraint:self.tagTitleWidth];
    
    self.tagTitleTop = [NSLayoutConstraint constraintWithItem:self.tagLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.tagTitleTop];
    
    self.tagTitleRight = [NSLayoutConstraint constraintWithItem:self.tagLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:5];
    [self.contentView addConstraint:self.tagTitleRight];
    
    
    self.hotTitleHeight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [self.titleLabel addConstraint:self.hotTitleHeight];
    
    self.hotTitleleft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    self.hotTitleRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    self.hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.cellModel.titleModel.spaceBottom];
    [self.contentView addConstraint:self.hotTitleleft];
    [self.contentView addConstraint:self.hotTitleRight];
    [self.contentView addConstraint:self.hotTitleBottom];
    
    
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
    
    self.titleLabel.text = cellModel.titleModel.text;
    self.titleLabel.textColor = cellModel.titleModel.color;
    self.titleLabel.font = cellModel.titleModel.font;
    self.titleLabel.textAlignment = cellModel.titleModel.textAlignment;
    self.hotTitleHeight.constant = cellModel.titleHeight;
    self.hotTitleleft.constant = cellModel.titleModel.spaceLeft;
    self.hotTitleRight.constant = -cellModel.titleModel.spaceRight;
    
    NSString *text = cellModel.tagModel.text ? cellModel.tagModel.text:@"";
    self.tagLabel.titleStr =  text;
    self.tagLabel.titleColor = cellModel.tagModel.color;;
    self.tagLabel.backgroundColor = cellModel.tagModel.bgColor;
    self.tagLabel.tagBorderColor = cellModel.tagModel.borderColor;
    self.tagLabel.showType =  cellModel.showType;
    self.tagLabel.roundedType =  cellModel.roundedType;
    if (cellModel.tagModel.text && cellModel.tagModel.text.length > 0 && ![cellModel.tagModel.text isEqualToString:@""]) {
        self.tagLabel.hidden = NO;
    } else{
        self.tagLabel.hidden = YES;
    }
    
    self.numLabel.hidden = NO;
    self.numLabel.backgroundColor = cellModel.numModel.bgColor;
    self.numLabel.numStr = [NSString stringWithFormat:@"%ld" , row+1];
    self.numLabel.numColor = cellModel.numModel.color;
    
    
    [self updateWithLabel:1];
    
    [self.tagLabel layoutIfNeeded];
    [self.numLabel layoutIfNeeded];
}

- (void)cellOffsetOnCollectionView:(UICollectionView *)collectionView
{
    [super cellOffsetOnCollectionView:collectionView];
    CGXHotBrandZoomFlowLayout *layout = (CGXHotBrandZoomFlowLayout *)collectionView.collectionViewLayout;
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
    self.numTop.constant = 0;
    self.numLeft.constant = self.cellModel.numModel.spaceLeft*needScale;
    self.numWidth.constant = self.cellModel.numWidth*needScale;
    self.numHeight.constant = self.cellModel.numHeight*needScale;
    self.numLabel.bottomHeight = self.cellModel.bottomHeight*needScale;
    self.numLabel.numFont =  [UIFont systemFontOfSize:self.cellModel.numModel.font.pointSize*needScale];
    
    UIFont *font = [UIFont systemFontOfSize:self.cellModel.tagModel.font.pointSize * needScale];
    NSString *text = self.cellModel.tagModel.text ? self.cellModel.tagModel.text:@"";
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    CGFloat width = ceil(size.width+self.cellModel.tagModel.space);
    
    self.tagTitleWidth.constant = width;
    self.tagTitleHeight.constant = self.cellModel.tagHeight*needScale;
    self.tagTitleTop.constant = self.cellModel.tagModel.spaceTop*needScale;
    self.tagTitleRight.constant = -self.cellModel.tagModel.spaceRight*needScale;
    
    self.tagLabel.titleFont = font;
    self.tagLabel.tagBorderRadius = self.cellModel.tagModel.borderRadius*needScale;
    self.tagLabel.tagBorderWidth = self.cellModel.tagModel.borderWidth*needScale;
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:self.cellModel.titleModel.font.pointSize * needScale];
    self.hotTitleHeight.constant = self.cellModel.titleHeight*needScale;
    self.hotTitleleft.constant = self.cellModel.titleModel.spaceLeft*needScale;
    self.hotTitleRight.constant = -self.cellModel.titleModel.spaceRight*needScale;
}


@end
