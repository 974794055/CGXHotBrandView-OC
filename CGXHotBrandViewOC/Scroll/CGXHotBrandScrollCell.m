//
//  CGXHotBrandScrollCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2021/1/4.
//

#import "CGXHotBrandScrollCell.h"

@interface CGXHotBrandScrollCell ()

@property (nonatomic , strong) NSLayoutConstraint *hotTitleTop;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleleft;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleBottom;

@end

@implementation CGXHotBrandScrollCell
- (void)initializeViews
{
    [super initializeViews];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView bringSubviewToFront:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    
    self.hotTitleTop = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    self.hotTitleleft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.hotTitleRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    self.hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30];
    [self.contentView addConstraint:self.hotTitleTop];
    [self.contentView addConstraint:self.hotTitleleft];
    [self.contentView addConstraint:self.hotTitleRight];
    [self.contentView addConstraint:self.hotTitleBottom];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.hotImageView.hidden = YES;
    self.titleLabel.hidden = YES;
    switch (self.scrollType) {
        case CGXHotBrandScrollTypeOnlyImage:
        {
            self.hotImageView.hidden = NO;
            self.hotImageTop.constant = 0;
            self.hotImageLeft.constant =0;
            self.hotImageRight.constant = 0;
            self.hotImageBottom.constant = 0;
        }
            break;
        case CGXHotBrandScrollTypeOnlyTitle:
        {
            self.titleLabel.hidden = NO;
            self.hotTitleTop.constant = 0;
            self.hotTitleleft.constant = self.cellModel.titleHLpace;
            self.hotTitleRight.constant = -self.cellModel.titleHRpace;
            self.hotTitleBottom.constant = 0;
            self.titleLabel.backgroundColor = self.cellModel.titleBgColor;
        }
            break;
        case CGXHotBrandScrollTypeImageTitle:
        {
            self.hotImageView.hidden = NO;
            self.titleLabel.hidden = NO;
            
            self.hotImageTop.constant = 0;
            self.hotImageLeft.constant = 0;
            self.hotImageRight.constant = 0;
            self.hotImageBottom.constant = 0;
            
            
            NSString *text = self.cellModel.titleStr ? self.cellModel.titleStr:@"";
            NSDictionary *attrs = @{NSFontAttributeName:self.cellModel.tagFont};
            CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
            
            self.hotTitleTop.constant = CGRectGetHeight(self.contentView.frame) - size.height-20;
            self.hotTitleleft.constant = self.cellModel.titleHLpace;
            self.hotTitleRight.constant = -self.cellModel.titleHRpace;
            self.hotTitleBottom.constant = 0;
            self.titleLabel.backgroundColor = [self.cellModel.titleBgColor colorWithAlphaComponent:0.5];
        }
            break;
        default:
            break;
    }
}

- (void)updateWithHotBrandCellModel:(CGXHotBrandModel *)cellModel Section:(NSInteger)section Row:(NSInteger)row
{
    [super updateWithHotBrandCellModel:cellModel Section:section Row:row];
    self.titleLabel.text = cellModel.titleStr;
    self.titleLabel.textAlignment = cellModel.textAlignment;
    self.titleLabel.textColor = cellModel.titleColor;
    self.titleLabel.font = cellModel.titleFont;
    self.titleLabel.numberOfLines = cellModel.numberOfLines;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setScrollType:(CGXHotBrandScrollType)scrollType
{
    _scrollType = scrollType;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
