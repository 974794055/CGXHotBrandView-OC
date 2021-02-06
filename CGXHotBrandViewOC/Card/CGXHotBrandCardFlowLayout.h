//
//  CGXHotBrandCardFlowLayout.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseFlowLayout.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CGXHotBrandDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CGXHotBrandCardFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@optional

/*
 当前放大的item
 */
- (void)gx_hotBrandAtCurrentInter:(NSInteger)currentInter;

@end

@interface CGXHotBrandCardFlowLayout : CGXHotBrandBaseFlowLayout

@property (nonatomic , weak) id<CGXHotBrandCardFlowLayoutDelegate>cardDelegate;

//缩放系数 数值越大缩放越大 default 0.5
@property(nonatomic,assign) CGFloat itemScaleFactor;
// 停留的中心比例 0～1之间 默认 0.5
@property(nonatomic,assign) CGFloat itemContentOffsetX;
//左右的透明度 default 1
@property(nonatomic,assign) CGFloat itemAlpha;
//开启缩放 default NO
@property(nonatomic,assign) BOOL itemIsZoom;
/*放大对其的的位置*/
@property(nonatomic,assign) CGXHotBrandCellPosition   cellPosition;


// 滚动时cell的缩放放大比例
- (CGFloat)cellOffsetAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
