//
//  CGXHotBrandTools.h
//  CGXHotBrandViewOC
//
//  Created by MacMini-1 on 2021/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandTools : NSObject

+ (UIViewController*)getTopViewController:(UIView *)view;

+ (void)showAninationWithView:(UIView*)view;
+ (void)hideAninationWithView:(UIView*)view;

// 将数组分割成 含多个子数组，每个子数组的个数为subSize
+ (NSMutableArray *)splitArray:(NSMutableArray *)array withSubSize:(NSInteger)subSize;

@end

NS_ASSUME_NONNULL_END
