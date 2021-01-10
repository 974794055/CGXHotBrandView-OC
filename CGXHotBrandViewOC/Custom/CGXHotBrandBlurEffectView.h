//
//  CGXHotBrandBlurEffectView.h
//  CGXHotBrandViewOC
//
//  Created by MacMini-1 on 2021/1/6.
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
