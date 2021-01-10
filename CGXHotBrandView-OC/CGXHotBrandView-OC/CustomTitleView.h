//
//  CustomTitleView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2021/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTitleView : UIView

/** 加载图片 */
@property (nonatomic, copy) void(^titieSelectBlock)(NSInteger integer);

- (void)updateDataTitieArray:(NSMutableArray<NSString *> *)titleArray;

@end

NS_ASSUME_NONNULL_END
