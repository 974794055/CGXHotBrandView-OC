//
//  CGXHotBrandPageModel.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandPageModel.h"

@implementation CGXHotBrandPageModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dotStyle = CGXHotBrandPageModelSystem;
        self.dotColor = [UIColor grayColor];
        self.dotCurrentColor = [UIColor redColor];
        self.dotImage = [self imageWithColor:[UIColor grayColor]];
        self.dotCurrentImage = [self imageWithColor:[UIColor redColor]];
        self.titleColor = [UIColor blackColor];
        self.titleFont = [UIFont systemFontOfSize:14];
    }
    return self;
}
- (UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
}
@end
