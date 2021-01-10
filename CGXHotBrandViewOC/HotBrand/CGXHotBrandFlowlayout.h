//
//  CGXHotBrandFlowlayout.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CGXHotBrandFlowlayoutHotDelegate <UICollectionViewDelegateFlowLayout>
@optional
/*
  几行
 */
- (NSInteger)hotBrandItemSectionAtIndex:(NSInteger)section;
/*
 每行几个item
 */
- (NSInteger)hotBrandItemRowAtIndex:(NSInteger)section;

@end

@interface CGXHotBrandFlowlayout : CGXHotBrandBaseFlowLayout

@property (nonatomic , weak) id<CGXHotBrandFlowlayoutHotDelegate>hotDelegate;

/** 多少行 */
@property (nonatomic, assign) NSInteger itemSectionCount;
/** 每行展示多少个item */
@property (nonatomic, assign) NSInteger itemRowCount;

@end

NS_ASSUME_NONNULL_END
