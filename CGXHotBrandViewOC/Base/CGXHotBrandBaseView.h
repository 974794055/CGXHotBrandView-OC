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
NS_ASSUME_NONNULL_BEGIN

@class CGXHotBrandBaseView;

@protocol CGXHotBrandBaseViewDelegate <NSObject>

@required

@optional
/*点击cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView DidSelectItemAtModel:(CGXHotBrandModel *)hotModel;
// ========== 轮播自定义cell ==========
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView;
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (UINib *)gx_hotBrandCellNibForBaseView:(CGXHotBrandBaseView *)hotView;

@end
/**点击cell**/
typedef void (^CGXHotBrandBaseViewDidSelectItemBlock)(CGXHotBrandBaseView *hotView,CGXHotBrandModel *hotModel);

@interface CGXHotBrandBaseView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic,copy) CGXHotBrandBaseViewDidSelectItemBlock didSelectItemBlock;
/*界面设置代理*/
@property (nonatomic , weak) id<CGXHotBrandBaseViewDelegate>delegate;
/** 多少行  默认2行 */
@property (nonatomic, assign) NSInteger itemSectionCount;
/** 每行展示多少个item  默认5个*/
@property (nonatomic, assign) NSInteger itemRowCount;
/** 列间距 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/** 行间距 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
/** collectionView的内边距 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, copy) void(^hotBrand_loadImageCallback)(UIImageView *hotImageView, NSURL *hotImageURL);



- (void)initializeData NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;

/*自定义layou */
- (UICollectionViewLayout *)preferredFlowLayout NS_REQUIRES_SUPER;
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
