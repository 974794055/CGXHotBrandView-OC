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
        self.titleHeight = 30;
        self.hotPicSpace = 10;
        self.hotPicSpaceTop = 10;

        self.showType = CGXHotBrandViewShowTypeRounded;
        self.roundedType = CGXHotBrandRoundedTypeAll;
        self.isAnimation = NO;
        self.tagHeight = 15;
        
        self.numHeight = 35;
        self.numWidth = 30;
        self.bottomHeight = 10;

        self.itemBorderColor = [UIColor redColor];
        self.itemBorderWidth = 0;
        self.itemBorderRadius = 0;
        
        
        self.titleModel.color = [UIColor blackColor];
        self.titleModel.bgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];;;
        self.titleModel.font = [UIFont systemFontOfSize:14];
        self.titleModel.spaceLeft = 0;
        self.titleModel.spaceRight = 0;
        self.titleModel.spaceTop = 0;
        self.titleModel.spaceBottom = 0;
        self.titleModel.textAlignment = NSTextAlignmentCenter;
        self.titleModel.numberOfLines = 1;
        self.titleModel.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0];;;
        self.titleModel.borderWidth = 0;
        self.titleModel.borderRadius = 0;
        
        self.tagModel.color = [UIColor whiteColor];
        self.tagModel.bgColor = [UIColor redColor];
        self.tagModel.font = [UIFont systemFontOfSize:10];
        self.tagModel.spaceLeft = 5;
        self.tagModel.spaceRight = 5;
        self.tagModel.spaceTop = 0;
        self.tagModel.spaceBottom = 0;
        self.tagModel.textAlignment = NSTextAlignmentCenter;
        self.tagModel.numberOfLines = 1;
        self.tagModel.borderColor = [UIColor redColor];;
        self.tagModel.borderWidth = 0;
        self.tagModel.borderRadius = 0;
        self.tagModel.space = 10;
        
        
        self.numModel.color = [UIColor whiteColor];
        self.numModel.bgColor = [UIColor redColor];
        self.numModel.font = [UIFont systemFontOfSize:12];
        self.numModel.spaceLeft = 5;
        self.numModel.spaceRight = 5;
        self.numModel.spaceTop = 0;
        self.numModel.spaceBottom = 0;
        self.numModel.textAlignment = NSTextAlignmentCenter;
        self.numModel.numberOfLines = 1;
        self.numModel.borderColor = [UIColor redColor];;
        self.numModel.borderWidth = 0;
        self.numModel.borderRadius = 0;
        self.numModel.space = 10;
        
    }
    return self;
}
- (CGXHotBrandTextModel *)titleModel
{
    if (!_titleModel) {
        _titleModel = [[CGXHotBrandTextModel alloc] init];
    }
    return _titleModel;
}
- (CGXHotBrandTextModel *)tagModel
{
    if (!_tagModel) {
        _tagModel = [[CGXHotBrandTextModel alloc] init];
    }
    return _tagModel;
}
- (CGXHotBrandTextModel *)numModel
{
    if (!_numModel) {
        _numModel = [[CGXHotBrandTextModel alloc] init];
    }
    return _numModel;
}
@end
