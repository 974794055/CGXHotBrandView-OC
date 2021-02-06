//
//  RotaryViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "RotaryViewController.h"

@interface RotaryViewController ()<CGXHotBrandCustomViewDelegate>


@end

@implementation RotaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i = 0; i<2; i++) {
        CGXHotBrandRotaryView *hotBrandView = [[CGXHotBrandRotaryView alloc] init];
        hotBrandView.delegate = self;
        hotBrandView.itemScaleFactor = 0.5;
        CGFloat height = (ScreenHeight-kTopHeight-kSafeHeight-30)/3.0;
        if (i == 0) {
            hotBrandView.frame = CGRectMake(0, 10,ScreenWidth , height);
        } else {
            hotBrandView.frame = CGRectMake(0, 20+height,ScreenWidth , height);
        }
        hotBrandView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        [self.view addSubview:hotBrandView];
        
        NSMutableArray *dataArray2 = [NSMutableArray array];
        for (int i = 0; i< 7; i++) {
            CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
            model.itemColor = [UIColor whiteColor];
            model.hotPicStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];;
            model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                [hotImageView sd_setImageWithURL:hotImageURL];
            };
            [dataArray2 addObject:model];
        }
        hotBrandView.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
        };
        [hotBrandView updateWithDataArray:dataArray2];
    }
    
}
//- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
//{
//    return CustomCollectionViewCell.class;
//}
/*点击cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath AtModel:(nonnull CGXHotBrandModel *)hotModel
{
    NSLog(@"didSelectItemAtIndexPath：%@---%@" , hotModel.titleStr,hotModel.dataModel);
}
/*滚动结束cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView ScrollEndItemAtIndexPath:(nonnull NSIndexPath *)indexPath AtModel:(nonnull CGXHotBrandModel *)hotModel
{
    NSLog(@"ScrollItemAtIndexPath：%@---%@" , hotModel.titleStr,hotModel.dataModel);
    hotView.backgroundColor = RandomColor;
}

/* cell数据交互处理*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath AtCell:(nonnull UICollectionViewCell *)cell AtModel:(nonnull CGXHotBrandModel *)hotModel
{
//    NSLog(@"%@---%@" , hotModel.titleStr,hotModel.dataModel);
//    CustomCollectionViewCell *newcell = (CustomCollectionViewCell *)cell;
//    NSLog(@"cellForItemAtIndexPath： %@" , cell);
//    [newcell.hotImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.hotPicStr]];
//    newcell.hotImageView.image = [UIImage imageNamed:hotModel.hotPicStr];
}

@end
