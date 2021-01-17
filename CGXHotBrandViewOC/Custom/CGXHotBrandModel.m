//
//  CGXHotBrandModel.m
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXHotBrandModel.h"

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
        self.titleHLpace = 0;
        self.titleHRpace = 0;
        self.titleHeight = 30;
        self.titleSpaceTop = 0;
        self.titleSpaceBottom = 0;
        self.hotPicSpace = 10;
        self.tagBorderWidth = 0;
        self.tagBorderRadius = 0;
        self.hotPicSpaceTop = 10;
        self.titleBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        self.tagColor = [UIColor whiteColor];
        self.tagBgColor = [UIColor redColor];
        self.tagFont = [UIFont systemFontOfSize:10];
        self.tagSpace = 10;
        self.tagBorderColor = [UIColor redColor];
     
        
        self.textAlignment = NSTextAlignmentCenter;
        self.numberOfLines = 1;
        
        self.showType = CGXHotBrandViewShowTypeRounded;
        self.tagHSpace = 5;
        self.tagVSpace = 0;
        
        self.roundedType = CGXHotBrandRoundedTypeAll;
        self.isAnimation = NO;
        
        self.tagHeight = 15;
        
        
  
        self.numColor = [UIColor whiteColor]; ;
        self.numBgColor = [UIColor redColor]; ;
        self.numFont = [UIFont systemFontOfSize:12];
        self.numHeight = 35;
        self.numWidth = 30;
        self.bottomHeight = 10;
        self.numHSpace = 5;
        
        self.itemBorderColor = [UIColor whiteColor];
        self.itemBorderWidth = 0;
        self.itemBorderRadius = 0;
    }
    return self;
}
@end
