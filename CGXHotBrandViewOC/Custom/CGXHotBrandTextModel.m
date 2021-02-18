//
//  CGXHotBrandTextModel.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandTextModel.h"

@implementation CGXHotBrandTextModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (instancetype)init
{
     self = [super init];
    if (self) {
        self.color = [UIColor blackColor];
        self.bgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];;
        self.font = [UIFont systemFontOfSize:14];
        self.space = 10;
        self.spaceLeft = 0;
        self.spaceRight = 0;
        self.spaceTop = 0;
        self.spaceBottom = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.numberOfLines = 1;
        self.borderColor = [UIColor whiteColor];
        self.borderWidth = 0;
        self.borderRadius = 0;
    }
    return self;
}
@end
