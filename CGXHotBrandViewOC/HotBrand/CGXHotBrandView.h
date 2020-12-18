//
//  CGXHotBrandView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandBaseView.h"
#import "CGXHotBrandModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandView : CGXHotBrandBaseView

@property (nonatomic, strong,readonly) NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *dataArray;

///** 只展示文字轮播 默认NO */
@property (nonatomic, assign) BOOL onlyDisplayText;

/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode;
/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;

/* 圆点所在高度 默认 20 */
@property (nonatomic, assign) CGFloat pageHeight;
///* 选中的色，默认红色 */
@property(nonatomic,strong) UIColor *selectColor;
/* 背景色，默认灰色 */
@property(nonatomic,strong) UIColor *normalColor;
/* 是否分页 默认YES*/
@property (nonatomic , assign) BOOL pagingEnabled;
/* 是否回弹 默认YES*/
@property (nonatomic , assign) BOOL bounces;
/* 是否有分页原点*/
@property (nonatomic , assign) BOOL isHavePage;

- (void)updateWithDataArray:(NSMutableArray<NSMutableArray<CGXHotBrandModel *> *> *)dataArray;

@end

NS_ASSUME_NONNULL_END

