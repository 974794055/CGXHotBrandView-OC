//
//  CGXHotBrandZoomFlowLayout.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CGXHotBrandZoomFlowLayoutFirstDelegate <UICollectionViewDelegateFlowLayout>

@required

- (CGSize)gx_hotBrandSizeForFirstCell;

@optional

/*滚动结束*/
- (void)gx_hotBrandZoomScrollEndAtIndex:(NSInteger)index;

@end

@interface CGXHotBrandZoomFlowLayout : CGXHotBrandBaseFlowLayout

@property (nonatomic, weak) id<CGXHotBrandZoomFlowLayoutFirstDelegate> delegate;

// 滚动时cell的缩放放大比例
- (CGFloat)cellOffsetAtIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
