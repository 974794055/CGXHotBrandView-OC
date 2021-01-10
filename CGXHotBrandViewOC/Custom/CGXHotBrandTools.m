//
//  CGXHotBrandTools.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "CGXHotBrandTools.h"

@implementation CGXHotBrandTools

+ (UIViewController*)getTopViewController:(UIView *)view
{
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self topViewControllerWithRootViewController:rootVc View:view];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController View:(UIView *)view
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController View:view];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController View:view];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController View:view];
    } else {
        return rootViewController;
    }
}


+ (void)showAninationWithView:(UIView*)view{
    [view.layer removeAllAnimations];
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.fromValue = [NSNumber numberWithFloat:1.2];
    scale.toValue = [NSNumber numberWithFloat:1.0];

    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.5];
    showViewAnn.toValue = [NSNumber numberWithFloat:1];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scale, showViewAnn];
    group.duration = 0.5;
    [view.layer addAnimation:group forKey:nil];
}
+ (void)hideAninationWithView:(UIView*)view{
    [view.layer removeAllAnimations];
     CABasicAnimation *scale = [CABasicAnimation animation];
     scale.keyPath = @"transform.scale";
     scale.fromValue = [NSNumber numberWithFloat:1];
     scale.toValue = [NSNumber numberWithFloat:1.2];

     CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
     showViewAnn.fromValue = [NSNumber numberWithFloat:1];
     showViewAnn.toValue = [NSNumber numberWithFloat:0];

     CAAnimationGroup *group = [CAAnimationGroup animation];
     group.animations = @[scale, showViewAnn];
     group.duration = 0.5;
     [view.layer addAnimation:group forKey:nil];
}

// 
+ (NSMutableArray *)splitArray:(NSMutableArray *)array withSubSize:(NSInteger)subSize
{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        NSInteger index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        NSInteger j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    return [arr copy];
}
@end
