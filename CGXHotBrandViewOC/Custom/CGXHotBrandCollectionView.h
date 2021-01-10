//
//  CGXHotBrandCollectionView.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
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
