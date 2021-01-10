//
//  CGXHotBrandZoomFlowLayout.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FirstCellZoomInLayoutTwoDelegate <UICollectionViewDelegateFlowLayout>

@required

- (CGSize)gx_hotBrandSizeForFirstCell;

@optional

/*滚动结束*/
- (void)gx_hotBrandZoomScrollEndAtIndex:(NSInteger)index;

@end

@interface CGXHotBrandZoomFlowLayout : CGXHotBrandBaseFlowLayout

@property (nonatomic, weak) id<FirstCellZoomInLayoutTwoDelegate> delegate;

@property(nonatomic,assign,readonly) CGSize firstCellSize;

@property(nonatomic,assign,readonly) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
