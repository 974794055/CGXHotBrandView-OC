//
//  CGXHotBrandPageDotView.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2021/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandPageDotView : UIView
/**
 *  if change the custom dot view's color, you should implement this method in subcalss
 *
 *  @param  dotColor    dot color not in current page
 *
 */
- (void)setDotColor:(UIColor *)dotColor;

/**
 *  if change the custom dot view's color, you should implement this method in subcalss
 *
 *  @param  currentDotColor    dot color in current page
 *
 */
- (void)setCurrentDotColor:(UIColor *)currentDotColor;

/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *  You can customize dot view and change annimation must implement this method to do something
 *
 *  @param  active  BOOL to tell if view is active or not
 *
 */
- (void)changActiveState:(BOOL)active;
@end

NS_ASSUME_NONNULL_END
