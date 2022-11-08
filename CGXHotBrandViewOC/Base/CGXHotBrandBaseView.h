//
//  CGXHotBrandBaseView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandModel.h"
#import "CGXHotBrandBaseCell.h"
#import "CGXHotBrandCollectionView.h"
#import "CGXHotBrandPageControl.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXHotBrandBaseView;

@protocol CGXHotBrandCustomViewDelegate <NSObject>

@required

@optional

/* 🔊🔊🔊： 轮播自定义cell 如果设置多个当根据tag值判断时， 先设置tag再设置delegate */

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView;
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (UINib *)gx_hotBrandCellNibForBaseView:(CGXHotBrandBaseView *)hotView;

/*点击cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView
   didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                    AtModel:(CGXHotBrandModel *)hotModel;

/*滚动结束cell CGXHotBrandCycleView、CGXHotBrandView无效  */
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView
      ScrollEndItemAtIndexPath:(NSIndexPath *)indexPath
                    AtModel:(CGXHotBrandModel *)hotModel;
/* cell数据交互处理*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView
     cellForItemAtIndexPath:(NSIndexPath *)indexPath
                     AtCell:(UICollectionViewCell *)cell
                    AtModel:(CGXHotBrandModel *)hotModel;

/* 正在滚动 */
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView
              ScrollAtPoint:(UIScrollView *)scrollView;


@end

@interface CGXHotBrandBaseView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong,readonly) CGXHotBrandCollectionView *collectionView;

/*界面设置代理*/
@property (nonatomic , weak) id<CGXHotBrandCustomViewDelegate>delegate;
/** 列间距 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/** 行间距 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
/** collectionView的内边距 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
/** 加载图片 */
@property (nonatomic, copy) void(^hotBrand_loadImageCallback)(UIImageView *hotImageView, NSURL *hotImageURL);
/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL infiniteLoop;
/** 是否自动滚动,默认NO */
@property (nonatomic,assign) BOOL autoScroll;
/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
/* 是否回弹 默认YES*/
@property (nonatomic , assign) BOOL bounces;



/** 滚动手势禁用（文字轮播较实用） */
- (void)disableScrollGesture;


/*   内部使用 不要传值 */
@property (nonatomic, assign) NSInteger totalInter;
@property (nonatomic, assign,readonly) NSInteger groudInter;
// 启动定时器
- (void)setupTimer;
// 停止定时器
- (void)invalidateTimer;

@end

@interface CGXHotBrandBaseView (CGXHotBrand)

- (void)automaticScroll NS_REQUIRES_SUPER;

- (void)initializeData NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;

/*自定义layou */
- (UICollectionViewLayout *)preferredFlowLayout NS_REQUIRES_SUPER;
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass NS_REQUIRES_SUPER;
- (NSInteger)gx_hotBrandNumberOfSectionsInCollectionView:(UICollectionView *)collectionView NS_REQUIRES_SUPER;
- (NSInteger)gx_hotBrandCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section NS_REQUIRES_SUPER;
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

- (int)currentIndex NS_REQUIRES_SUPER;
- (CGXHotBrandModel *)pageIndexWithCurrentCellModelAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;
- (void)gx_hotBrandCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
