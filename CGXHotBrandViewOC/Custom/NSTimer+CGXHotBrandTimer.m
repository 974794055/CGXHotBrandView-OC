//
//  NSTimer+CGXHotBrandTimer.m
//  CGXBannerViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSTimer+CGXHotBrandTimer.h"
#import <objc/runtime.h>

static const void *gx_private_currentCountTime = "gx_private_currentCountTime";


@implementation NSTimer (CGXHotBrandTimer)
- (NSNumber *)gx_private_currentCountTime {
    NSNumber *obj = objc_getAssociatedObject(self, gx_private_currentCountTime);
    
    if (obj == nil) {
        obj = @(0);
        
        [self setGx_private_currentCountTime:obj];
    }
    
    return obj;
}

- (void)setGx_private_currentCountTime:(NSNumber *)time {
    objc_setAssociatedObject(self,
                             gx_private_currentCountTime,
                             time, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSTimer *)gx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         count:(NSInteger)count
                                      callback:(GXHotBrandTimerCallback)callback {
    if (count <= 0) {
        return [self gx_scheduledTimerWithTimeInterval:interval
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

+ (NSTimer *)gx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                       repeats:(BOOL)repeats
                                      callback:(GXHotBrandTimerCallback)callback {
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(gx_onTimerUpdateBlock:)
                                          userInfo:callback
                                           repeats:repeats];
}

- (void)gx_fireTimer {
    [self setFireDate:[NSDate distantPast]];
}

- (void)gx_unfireTimer {
    [self setFireDate:[NSDate distantFuture]];
}

- (void)gx_invalidate {
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
    NSInteger currentCount = [[timer gx_private_currentCountTime] integerValue];
    
    NSDictionary *userInfo = timer.userInfo;
    GXHotBrandTimerCallback callback = userInfo[@"callback"];
    NSNumber *count = userInfo[@"count"];
    
    if (currentCount < count.integerValue) {
        currentCount++;
        [timer setGx_private_currentCountTime:@(currentCount)];
        
        if (callback) {
            callback(timer);
        }
    } else {
        currentCount = 0;
        [timer setGx_private_currentCountTime:@(currentCount)];
        
        [timer gx_unfireTimer];
        [timer gx_invalidate];
    }
}
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid])
    {
        return ;
    }
    
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
@end
