//
//  CGXHotBrandView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"
#import "CGXHotBrandModel.h"
#import "CGXHotBrandCell.h"
NS_ASSUME_NONNULL_BEGIN


@interface CGXHotBrandView : CGXHotBrandBaseView

/** 多少行  默认2行 */
@property (nonatomic, assign) NSInteger itemSectionCount;
/** 每行展示多少个item  默认5个*/
@property (nonatomic, assign) NSInteger itemRowCount;
// 角标是否有动画
@property (nonatomic , assign) BOOL isAnimation;

/** 初始化更新数据源   */
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;

// 更新某个item
- (void)updateWithItemModel:(CGXHotBrandModel *)itemModel AtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

