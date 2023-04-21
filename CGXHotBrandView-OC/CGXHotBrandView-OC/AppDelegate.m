//
//  AppDelegate.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (@available(iOS 15.0, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance setBackgroundColor:[UIColor whiteColor]];
        // UINavigationBarAppearance 会覆盖原有的导航栏设置，这里需要重新设置返回按钮隐藏，不隐藏可注释或删掉
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffsetMake(-200, 0);
        
        [[UINavigationBar appearance] setScrollEdgeAppearance: appearance];
        [[UINavigationBar appearance] setStandardAppearance:appearance];
    }
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    if(@available(iOS 13.0,*)){
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
#endif
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

@end
