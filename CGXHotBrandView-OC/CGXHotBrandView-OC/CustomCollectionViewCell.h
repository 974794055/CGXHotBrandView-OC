//
//  CustomCollectionViewCell.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CGXHotBrandViewOC/CGXHotBrandViewOC.h>
NS_ASSUME_NONNULL_BEGIN

@interface CustomCollectionViewCell : UICollectionViewCell<CGXHotBrandUpdateCellDelegate>
@property (nonatomic , strong) UIImageView *hotImageView;
@end

NS_ASSUME_NONNULL_END

