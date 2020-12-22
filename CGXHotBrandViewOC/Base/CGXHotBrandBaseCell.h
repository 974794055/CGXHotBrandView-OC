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

@end

@interface CGXHotBrandBaseCell : UICollectionViewCell<CGXHotBrandUpdateCellDelegate>
@property (nonatomic , strong) UIImageView *hotImageView;

@property (nonatomic , strong) CGXHotBrandModel *cellModel;

- (void)initializeViews NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
