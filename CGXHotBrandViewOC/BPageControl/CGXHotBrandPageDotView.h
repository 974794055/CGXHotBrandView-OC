//
//  CGXHotBrandPageDotView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHotBrandPageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandPageDotView : UIView

@property(nonatomic, strong) CGXHotBrandPageModel *dotModel;
/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *  You can customize dot view and change annimation must implement this method to do something
 *
 *  @param  active  BOOL to tell if view is active or not
 *
 */
- (void)changActiveState:(BOOL)active;


- (void)updateWithModel:(CGXHotBrandPageModel *)model ActiveState:(BOOL)active DotInter:(NSInteger)dotInter;

@end

NS_ASSUME_NONNULL_END
