//
//  CGXHotBrandSliderView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandSliderView : CGXHotBrandBaseView
@property (nonatomic,strong,readonly) NSMutableArray<CGXHotBrandModel *>  *dataArray;
- (void)updateWithDataArray:(NSMutableArray<CGXHotBrandModel *> *)dataArray;

// 展示个数
@property (nonatomic,assign) NSInteger visibleItemsCount;
// 缩放比例
@property (nonatomic,assign) CGFloat minScale;

@end

NS_ASSUME_NONNULL_END
