//
//  CGXHotBrandCell.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandCell.h"
#import "CGXHotBrandTagLabel.h"
#import "NSTimer+CGXHotBrandTimer.h"
@interface CGXHotBrandCell ()

@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic , strong) NSLayoutConstraint *hotTitleHeight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleleft;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleBottom;

@property (nonatomic , strong) NSLayoutConstraint *tagTitleHeight;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleWidth;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *tagTitleTop;

/* 是否回弹 默认YES*/
@property (nonatomic , assign) CGXHotBrandViewShowType showType;
// 角标是否有动画
@property (nonatomic , assign) BOOL isAnimation;


@end

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
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.tagLabel = [[CGXHotBrandTagLabel alloc] init];
    self.tagLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView bringSubviewToFront:self.tagLabel];
    self.tagLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.hotImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.hotTitleHeight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [self.titleLabel addConstraint:self.hotTitleHeight];

    self.hotTitleleft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    self.hotTitleRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    self.hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.cellModel.titleModel.spaceBottom];
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
    

    self.timer = [NSTimer gx_hotBrandTimerWithTimeInterval:3 repeats:YES callback:^(NSTimer * _Nonnull timer) {
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 1.5;// 动画时间
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];

        animation.values = values;

        [self.tagLabel.layer addAnimation:animation forKey:nil];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    self.tagLabel.hidden = YES;
    
}
- (void)dealloc
{
    [self.timer gx_hotInvalidate];
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
    self.titleLabel.text = cellModel.titleModel.text;
    self.titleLabel.textColor = cellModel.titleModel.color;
    self.titleLabel.font = cellModel.titleModel.font;
    self.titleLabel.backgroundColor = cellModel.titleModel.bgColor;
    self.titleLabel.textAlignment = cellModel.titleModel.textAlignment;
    self.hotTitleHeight.constant = self.cellModel.titleHeight;
    self.hotTitleleft.constant = cellModel.titleModel.spaceLeft;
    self.hotTitleleft.constant = cellModel.titleModel.spaceRight;
    
    self.hotImageTop.constant = cellModel.hotPicSpaceTop;
    self.hotImageLeft.constant = cellModel.hotPicSpace;
    self.hotImageRight.constant = -cellModel.hotPicSpace;
    self.hotImageBottom.constant = -cellModel.titleModel.spaceTop-self.cellModel.titleModel.spaceBottom-self.cellModel.titleHeight;
    
    NSString *text = cellModel.tagModel.text ? cellModel.tagModel.text:@"";
    NSDictionary *attrs = @{NSFontAttributeName:cellModel.tagModel.font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    CGFloat width = ceil(size.width + cellModel.tagModel.space);
    CGFloat height = ceil(size.height)+2;
    if (cellModel.showType == CGXHotBrandViewShowTypeJDChat) {
        height = height + 5;
    } else if (cellModel.showType == CGXHotBrandViewShowTypeChat) {
        height = height + 5;
    }
    
    self.tagLabel.triangleH = 4;
    self.tagLabel.triangleW = 6;
    self.tagLabel.titleFont = cellModel.tagModel.font;
    self.tagLabel.backgroundColor = cellModel.tagModel.bgColor;
    self.tagLabel.tagBorderRadius = cellModel.tagModel.borderRadius;
    self.tagLabel.tagBorderColor = cellModel.tagModel.borderColor;
    self.tagLabel.tagBorderWidth = cellModel.tagModel.borderWidth;

    self.tagTitleWidth.constant = width;
    self.tagTitleHeight.constant = height;
    self.tagTitleTop.constant = cellModel.tagModel.spaceTop;
    self.tagTitleRight.constant = -cellModel.tagModel.spaceRight;
    self.tagLabel.showType =  cellModel.showType;
    self.tagLabel.roundedType =  cellModel.roundedType;
    self.tagLabel.titleStr =  text;
    [self.tagLabel layoutIfNeeded];
    if (text && text.length > 0 && ![text isEqualToString:@""]) {
        self.tagLabel.hidden = NO;
        if (cellModel.isAnimation) {
            [self.timer gx_hotFireTimer];
        }else{
            [self.timer gx_hotUnfireTimer];
        }
    } else{
        self.tagLabel.hidden = YES;
        [self.timer gx_hotUnfireTimer];
    }
    
}

@end
