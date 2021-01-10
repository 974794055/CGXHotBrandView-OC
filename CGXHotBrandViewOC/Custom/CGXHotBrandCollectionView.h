//
//  CGXHotBrandCollectionView.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2021/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CGXHotBrandCollectionView;

@protocol CGXHotBrandCollectionViewGestureDelegate <NSObject>
@optional
- (BOOL)categoryCollectionView:(CGXHotBrandCollectionView *)collectionView
  gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
- (BOOL)categoryCollectionView:(CGXHotBrandCollectionView *)collectionView
             gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end
@interface CGXHotBrandCollectionView : UICollectionView

@property (nonatomic, weak) id<CGXHotBrandCollectionViewGestureDelegate> gestureDelegate;

@end

NS_ASSUME_NONNULL_END
