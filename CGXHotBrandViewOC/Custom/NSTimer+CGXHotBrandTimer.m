//
//  NSTimer+CGXHotBrandTimer.m
//  CGXBannerViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSTimer+CGXHotBrandTimer.h"
#import <objc/runtime.h>

static const void *gx_private_hotBrandCurrentCountTime = "gx_private_hotBrandCurrentCountTime";


@implementation NSTimer (CGXHotBrandTimer)
- (NSNumber *)gx_private_hotBrandCurrentCountTime {
    NSNumber *obj = objc_getAssociatedObject(self, gx_private_hotBrandCurrentCountTime);
    if (obj == nil) {
        obj = @(0);
        [self setGx_private_hotBrandCurrentCountTime:obj];
    }
    return obj;
}

- (void)setGx_private_hotBrandCurrentCountTime:(NSNumber *)time {
    objc_setAssociatedObject(self,
                             gx_private_hotBrandCurrentCountTime,
                             time, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSTimer *)gx_hotBrandTimerWithTimeInterval:(NSTimeInterval)interval
                                         count:(NSInteger)count
                                      callback:(GXHotBrandTimerCallback)callback {
    if (count <= 0) {
        return [self gx_hotBrandTimerWithTimeInterval:interval
                                               repeats:YES
                                              callback:callback];
    }
    
    NSDictionary *userInfo = @{@"callback"     : callback,
                               @"count"        : @(count)};
    
    
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(gx_onTimerUpdateCountBlock:)
                                          userInfo:userInfo
                                           repeats:YES];
}

+ (NSTimer *)gx_hotBrandTimerWithTimeInterval:(NSTimeInterval)interval
                                       repeats:(BOOL)repeats
                                      callback:(GXHotBrandTimerCallback)callback {
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(gx_onTimerUpdateBlock:)
                                          userInfo:callback
                                           repeats:repeats];
}

- (void)gx_hotFireTimer {
    [self setFireDate:[NSDate distantPast]];
}

- (void)gx_hotUnfireTimer {
    [self setFireDate:[NSDate distantFuture]];
}

- (void)gx_hotInvalidate {
    if (self.isValid) {
        [self invalidate];
    }
}

#pragma mark - Private
+ (void)gx_onTimerUpdateBlock:(NSTimer *)timer {
    GXHotBrandTimerCallback block = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

+ (void)gx_onTimerUpdateCountBlock:(NSTimer *)timer {
    NSInteger currentCount = [[timer gx_private_hotBrandCurrentCountTime] integerValue];
    
    NSDictionary *userInfo = timer.userInfo;
    GXHotBrandTimerCallback callback = userInfo[@"callback"];
    NSNumber *count = userInfo[@"count"];
    
    if (currentCount < count.integerValue) {
        currentCount++;
        [timer setGx_private_hotBrandCurrentCountTime:@(currentCount)];
        
        if (callback) {
            callback(timer);
        }
    } else {
        currentCount = 0;
        [timer setGx_private_hotBrandCurrentCountTime:@(currentCount)];
        
        [timer gx_hotUnfireTimer];
        [timer gx_hotInvalidate];
    }
}
- (void)gx_hotResumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid])
    {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
@end
