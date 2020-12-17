//
//  CGXHotBrandModel.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandModel.h"
#import "UIColor+CGXHotBrand.h"
@implementation CGXHotBrandModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (instancetype)init
{
     self = [super init];
    if (self) {
        self.itemColor = [UIColor whiteColor];
        self.titleColor = [UIColor blackColor];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleHeight = 30;
        self.titleSpaceTop = 0;
        self.titleSpaceBottom = 0;
        
        self.borderColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.borderWidth = 0;
        self.borderRadius = 0;
    }
    return self;
}
@end
