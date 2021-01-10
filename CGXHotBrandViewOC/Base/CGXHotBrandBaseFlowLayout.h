//
//  CGXHotBrandBaseFlowLayout.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandBaseFlowLayout : UICollectionViewFlowLayout

- (void)initializeData NS_REQUIRES_SUPER;


- (NSArray *)getCopyOfAttributes:(NSArray *)attributes;

@end

@interface CGXHotBrandBaseFlowLayout (CGXHotBrandAttributes)
/// item水平间距
/// @param section  分区
- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
/// item垂直间距
/// @param section  分区
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section;
/// 分区边距
/// @param section  分区
- (UIEdgeInsets)gx_insetForSectionAtIndex:(NSInteger)section;
/// 头分区高度
/// @param section  分区
- (CGSize)gx_referenceSizeForHeaderInSection:(NSInteger)section;
/// 脚分区高度
/// @param section  分区
- (CGSize)gx_referenceSizeForFooterInSection:(NSInteger)section;
/// item的宽高
/// @param indexPath  分区
- (CGSize)gx_sizeForItemAtIndexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
