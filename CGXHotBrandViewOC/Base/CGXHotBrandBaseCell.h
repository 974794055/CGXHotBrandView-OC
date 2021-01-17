//
//  CGXHotBrandBaseCell.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXHotBrandModel;

@protocol CGXHotBrandUpdateCellDelegate <NSObject>

@required

@optional
/*
 cellModel:每个item的数据源
 index:分区所在的下标
 */
- (void)updateWithHotBrandCellModel:(CGXHotBrandModel *)cellModel Section:(NSInteger)section Row:(NSInteger)row;
// 滚动变化
- (void)cellOffsetOnCollectionView:(UICollectionView *)collectionView;

@end

@interface CGXHotBrandBaseCell : UICollectionViewCell<CGXHotBrandUpdateCellDelegate>

@property (nonatomic , strong) UIImageView *hotImageView;

@property (nonatomic , strong) CGXHotBrandModel *cellModel;
@property (nonatomic , assign ,readonly) NSInteger section;
@property (nonatomic , assign ,readonly) NSInteger row;


@property (nonatomic , strong) NSLayoutConstraint *hotImageTop;
@property (nonatomic , strong) NSLayoutConstraint *hotImageLeft;
@property (nonatomic , strong) NSLayoutConstraint *hotImageRight;
@property (nonatomic , strong) NSLayoutConstraint *hotImageBottom;

- (void)initializeViews NS_REQUIRES_SUPER;


@end

NS_ASSUME_NONNULL_END
