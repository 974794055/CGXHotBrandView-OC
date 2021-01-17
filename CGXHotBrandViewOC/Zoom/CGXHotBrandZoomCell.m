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
    
    self.numLabel.hidden = NO;
    self.numLabel.backgroundColor = cellModel.numBgColor;
    self.numLabel.numStr = [NSString stringWithFormat:@"%ld" , row+1];
    self.numLabel.numColor = cellModel.numColor;
    
    
    [self updateWithLabel:1];
    
    [self.tagLabel layoutIfNeeded];
    [self.numLabel layoutIfNeeded];
}

- (void)cellOffsetOnCollectionView:(UICollectionView *)collectionView
{
    [super cellOffsetOnCollectionView:collectionView];
    
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:self.section]];
    CGRect cellFrameInSuperview = [collectionView convertRect:attributes.frame toView:[collectionView superview]];
    
    CGXHotBrandZoomFlowLayout *layout = (CGXHotBrandZoomFlowLayout *)collectionView.collectionViewLayout;
    CGSize firstSize = layout.firstCellSize;
    UIEdgeInsets edgeInsets = [layout gx_insetForSectionAtIndex:self.section];
    
    CGFloat preferXoffset = firstSize.width / 2 +edgeInsets.left;//距离collectionView左边间距为此值时视图恢复正常大小
    
    CGFloat itemGaps = 0.0;//item的间距
    
    CGFloat itemXoffset = cellFrameInSuperview.origin.x;
    
    CGFloat animationMinOffset = -(cellFrameInSuperview.size.width - (preferXoffset-cellFrameInSuperview.size.width/2-itemGaps));//item子视图开始动画的最小x偏移量
    
    CGFloat animationMaxOffset = preferXoffset + cellFrameInSuperview.size.width/2 + itemGaps;//item子视图开始动画的最大x偏移量
    
    CGFloat normalOffset = preferXoffset - cellFrameInSuperview.size.width/2;//item子视图为1倍大小时的x方向偏移量
    
    CGFloat needScale = 0;
    if (itemXoffset > animationMinOffset && itemXoffset < animationMaxOffset) {
        if (itemXoffset<normalOffset) {//开始缩小
            CGFloat config = normalOffset - animationMinOffset;
            needScale =(itemXoffset-animationMinOffset)/config*(pMaxScale-pNormalScale)+pNormalScale;
        }else if (itemXoffset>normalOffset){//开始缩小
            CGFloat config = animationMaxOffset - normalOffset;
            needScale =(animationMaxOffset-itemXoffset)/config*(pMaxScale-pNormalScale)+pNormalScale;
        }else{//恢复正常(最大)
            needScale = pMaxScale;
        }
    }else{
        needScale = pNormalScale;
    }
    
    
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
    self.numLeft.constant = self.cellModel.numHSpace*needScale;
    self.numWidth.constant = self.cellModel.numWidth*needScale;
    self.numHeight.constant = self.cellModel.numHeight*needScale;
    self.numLabel.bottomHeight = self.cellModel.bottomHeight*needScale;
    self.numLabel.numFont =  [UIFont systemFontOfSize:self.cellModel.numFont.pointSize*needScale];
    
    UIFont *font = [UIFont systemFontOfSize:self.cellModel.tagFont.pointSize * needScale];
    NSString *text = self.cellModel.tagStr ? self.cellModel.tagStr:@"";
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    CGFloat width = ceil(size.width+self.cellModel.tagSpace);
    
    self.tagTitleWidth.constant = width;
    self.tagTitleHeight.constant = self.cellModel.tagHeight*needScale;
    self.tagTitleTop.constant = self.cellModel.tagVSpace*needScale;
    self.tagTitleRight.constant = -self.cellModel.tagHSpace*needScale;
    
    self.tagLabel.titleFont = font;
    self.tagLabel.tagBorderRadius = self.cellModel.tagBorderRadius*needScale;
    self.tagLabel.tagBorderWidth = self.cellModel.tagBorderWidth*needScale;
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:self.cellModel.titleFont.pointSize * needScale];
    self.hotTitleHeight.constant = self.cellModel.titleHeight*needScale;
    self.hotTitleleft.constant = self.cellModel.titleHLpace*needScale;
    self.hotTitleRight.constant = -self.cellModel.titleHRpace*needScale;
}


@end
