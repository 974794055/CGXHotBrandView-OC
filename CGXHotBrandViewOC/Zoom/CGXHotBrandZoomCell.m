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
@interface CGXHotBrandZoomCell ()

@property (nonatomic , strong) NSLayoutConstraint *hotImageTop;
@property (nonatomic , strong) NSLayoutConstraint *hotImageLeft;
@property (nonatomic , strong) NSLayoutConstraint *hotImageRight;
@property (nonatomic , strong) NSLayoutConstraint *hotImageBottom;

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
    
    self.hotImageTop = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    self.hotImageLeft = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.hotImageRight = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    self.hotImageBottom = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30];
    [self.contentView addConstraint:self.hotImageTop];
    [self.contentView addConstraint:self.hotImageLeft];
    [self.contentView addConstraint:self.hotImageRight];
    [self.contentView addConstraint:self.hotImageBottom];
    
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
    self.hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.cellModel.titleSpaceBottom];
    [self.contentView addConstraint:self.hotTitleleft];
    [self.contentView addConstraint:self.hotTitleRight];
    [self.contentView addConstraint:self.hotTitleBottom];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.hotImageTop.constant = 0;
    self.hotImageLeft.constant =0;
    self.hotImageRight.constant = 0;
    self.hotImageBottom.constant = 0;
    
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
    
    self.titleLabel.text = cellModel.titleStr;
    self.titleLabel.textColor = cellModel.titleColor;
    self.titleLabel.font = cellModel.titleFont;
    self.titleLabel.textAlignment = cellModel.textAlignment;
    self.hotTitleHeight.constant = cellModel.titleHeight;
    self.hotTitleleft.constant = cellModel.titleHLpace;
    self.hotTitleRight.constant = -cellModel.titleHRpace;
    NSString *text = cellModel.tagStr ? cellModel.tagStr:@"";
    NSDictionary *attrs = @{NSFontAttributeName:cellModel.tagFont};
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    CGFloat width = ceil(size.width+cellModel.tagSpace);
    
    
    self.tagTitleWidth.constant = width;
    self.tagTitleHeight.constant = cellModel.tagHeight;
    self.tagTitleTop.constant = cellModel.tagVSpace;
    self.tagTitleRight.constant = -cellModel.tagHSpace;
    
    self.tagLabel.titleStr =  text;
    self.tagLabel.titleColor = cellModel.tagColor;;
    self.tagLabel.titleFont = cellModel.tagFont;
    self.tagLabel.backgroundColor = cellModel.tagBgColor;
    self.tagLabel.tagBorderRadius = cellModel.tagBorderRadius;
    self.tagLabel.tagBorderColor = cellModel.tagBorderColor;
    self.tagLabel.tagBorderWidth = cellModel.tagBorderWidth;
    self.tagLabel.showType =  cellModel.showType;
    self.tagLabel.roundedType =  cellModel.roundedType;
    
    if (cellModel.tagStr && cellModel.tagStr.length > 0 && ![cellModel.tagStr isEqualToString:@""]) {
        self.tagLabel.hidden = NO;
    } else{
        self.tagLabel.hidden = YES;
    }
    
    self.numLabel.hidden = NO;
    self.numTop.constant = 0;
    self.numLeft.constant = cellModel.numHSpace;
    self.numWidth.constant = cellModel.numWidth;
    self.numHeight.constant = cellModel.numHeight;
    self.numLabel.bottomHeight = cellModel.bottomHeight;
    
    self.numLabel.backgroundColor = cellModel.numBgColor;
    self.numLabel.numStr = [NSString stringWithFormat:@"%ld" , row+1];
    self.numLabel.numFont = cellModel.numFont;
    self.numLabel.numColor = cellModel.numColor;
    
    self.numLabel.hidden = NO;
    
    
    
    //    self.numLabel.transform = CGAffineTransformMakeScale(1, 1);
    [self.tagLabel layoutIfNeeded];
    [self.numLabel layoutIfNeeded];
}

- (void)cellOffsetOnCollectionView:(UICollectionView *)collectionView
{
    [super cellOffsetOnCollectionView:collectionView];
    
    CGXHotBrandZoomFlowLayout *layout = (CGXHotBrandZoomFlowLayout *)collectionView.collectionViewLayout;
    CGSize firstSize = layout.firstCellSize;
    CGSize itemSize = [layout gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:self.section]];
    
    CGFloat space = 0.7;
    
    CGFloat firstSizeheight = floor(firstSize.height);
    CGFloat cellheight = floor(CGRectGetHeight(self.contentView.frame));
    CGFloat itemSizeheight = floor(itemSize.height);
    
    if ((cellheight-itemSizeheight)>0) {
        space = (firstSizeheight-cellheight)/(firstSizeheight-itemSizeheight);
        if (space<0.7) {
            space = 1;
        }
    }
    if (collectionView.contentOffset.x==0) {
        if (layout.currentIndex==self.row) {
            space = 1;
        } else{
            space = 0.7;
        }
    }

    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear animations:^{
        self.numLeft.constant = self.cellModel.numHSpace*space;
        self.numWidth.constant = self.cellModel.numWidth*space;
        self.numHeight.constant = self.cellModel.numHeight*space;
        self.numLabel.bottomHeight = self.cellModel.bottomHeight*space;
        self.numLabel.numFont =  [UIFont systemFontOfSize:self.cellModel.numFont.pointSize*space];
        
    } completion:^(BOOL finished) {
        
    }];
}
@end
