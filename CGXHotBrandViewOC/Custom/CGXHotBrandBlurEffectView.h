//
//  CGXHotBrandBlurEffectView.h
//  CGXHotBrandViewOC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXHotBrandBlurEffectView : UIView

//背景毛玻璃效果透明度 默认1
@property(assign,nonatomic) CGFloat itemEffectAlpha;
//背景图
@property(strong,nonatomic)UIImageView *effectImgView;

@end

NS_ASSUME_NONNULL_END
