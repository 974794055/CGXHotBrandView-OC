//
//  CycleViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CycleViewController.h"

@interface CycleViewController ()<CGXHotBrandCustomViewDelegate>


@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    for (int i = 0; i<2; i++) {
        CGXHotBrandCycleView *hotBrandView = [[CGXHotBrandCycleView alloc] init];
        hotBrandView.delegate = self;
        hotBrandView.minimumLineSpacing = 10;
        hotBrandView.minimumInteritemSpacing = 10;
        hotBrandView.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        hotBrandView.itemRowCount = 5;
        hotBrandView.itemSectionCount = 3;
        hotBrandView.autoScroll = (i == 0 ? YES : NO);
        hotBrandView.offsetX = 0.5;
        CGFloat height = (ScreenHeight-kTopHeight-kSafeHeight-30)/2.0;
        if (i == 0) {
            hotBrandView.widthSpace = 1;
            hotBrandView.frame = CGRectMake(0, 10,ScreenWidth , height);
        } else {
            hotBrandView.widthSpace = 0.8;
            hotBrandView.frame = CGRectMake(0, 20+height,ScreenWidth , height);
        }
        hotBrandView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        [self.view addSubview:hotBrandView];
        
        NSMutableArray *dataArray2 = [NSMutableArray array];
        for (int i = 0; i< 15; i++) {
            CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
            model.itemColor = [UIColor whiteColor];
            model.hotPicStr = @"HotIcon0";
            [dataArray2 addObject:model];
            model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                [hotImageView sd_setImageWithURL:hotImageURL];
            };
        }
        [hotBrandView updateWithDataArray:dataArray2];
    }
    
}
//- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
//{
//    return CustomCollectionViewCell.class;
//}
/*点击cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView didSelectItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"didSelectItemAtIndexPath：%@---%@" , hotModel.titleModel.text,hotModel.dataModel);
}
/*滚动结束cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView ScrollItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"ScrollItemAtIndexPath：%@---%@" , hotModel.titleModel.text,hotModel.dataModel);

}
/* cell数据交互处理*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView cellForItemAtIndexPath:(NSIndexPath *)indexPath AtCell:(UICollectionViewCell *)cell AtModel:(CGXHotBrandModel *)hotModel
{
//    NSLog(@"%@---%@" , hotModel.titleStr,hotModel.dataModel);
//    CustomCollectionViewCell *newcell = (CustomCollectionViewCell *)cell;
//    NSLog(@"cellForItemAtIndexPath： %@" , cell);
//    [newcell.hotImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.hotPicStr]];
//    newcell.hotImageView.image = [UIImage imageNamed:hotModel.hotPicStr];
}

@end
