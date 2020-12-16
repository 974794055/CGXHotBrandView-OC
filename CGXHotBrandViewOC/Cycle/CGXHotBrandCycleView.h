//
//  CGXHotBrandCycleView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandCycleView : CGXHotBrandBaseView

/* 比例 0.0 ～ 1.0 之间 两端无效 默认0.5 */
@property (nonatomic, assign) CGFloat offsetX; //

/* 宽度是高度的倍数。默认 1.0  */
@property (nonatomic, assign) CGFloat widthSpace; //

@property (nonatomic, strong,readonly) NSMutableArray<CGXHotBrandModel *> *dataArray;

- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
