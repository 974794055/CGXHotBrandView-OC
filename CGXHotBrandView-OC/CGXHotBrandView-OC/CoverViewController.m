//
//  CoverViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CoverViewController.h"

@interface CoverViewController ()<CGXHotBrandCustomViewDelegate>

@end

@implementation CoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];

        CGXHotBrandCoverView *hotBrandView = [[CGXHotBrandCoverView alloc] init];
        hotBrandView.delegate = self;
        hotBrandView.frame = CGRectMake(0, 10,ScreenWidth , 300);
//    hotBrandView.itemWidthScale = 0.4;
//    hotBrandView.itemHeightScale = 0.6;
        hotBrandView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:hotBrandView];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        for (int i = 0; i< arc4random() % 5+10; i++) {
            CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
            model.titleStr = [NSString stringWithFormat:@" 双十二低价-%d",i];
            model.titleBgColor = [UIColor whiteColor];
            model.itemColor = [UIColor colorWithWhite:0.93 alpha:1];
            model.itemColor = [UIColor whiteColor];
            model.hotPicStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];;
            model.tagStr = (arc4random() % 2 == 0) ? @"秒杀":@"";
            model.tagSpace = 10;
            model.tagBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            model.titleColor =[UIColor blackColor];
            model.textAlignment = NSTextAlignmentCenter;
            model.tagSpace = 15;
            model.tagBorderRadius = 6;
            model.tagBorderColor = [UIColor grayColor];
            model.tagBorderWidth = 0;
            model.tagBgColor = [UIColor redColor];
            model.showType =  CGXHotBrandViewShowTypeRounded;
            model.roundedType =CGXHotBrandRoundedTypeBottomLeft | CGXHotBrandRoundedTypeBottomRight;
            model.titleHLpace = 10;
            model.titleHRpace = 10;
            model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                [hotImageView sd_setImageWithURL:hotImageURL];
            };
            [dataArray addObject:model];
        };
        [hotBrandView updateWithDataArray:dataArray];
}
//- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
//{
//    return CustomCollectionViewCell.class;
//}
/*点击cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView didSelectItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
//    NSLog(@"didSelectItemAtIndexPath：%@---%@" , hotModel.titleStr,hotModel.dataModel);
}
/*滚动结束cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView ScrollItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
//    NSLog(@"ScrollItemAtIndexPath：%@---%@" , hotModel.titleStr,hotModel.dataModel);

}
/* cell数据交互处理*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView cellForItemAtIndexPath:(NSIndexPath *)indexPath AtCell:(UICollectionViewCell *)cell AtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"%@---%@---%@" , hotModel.hotPicStr,hotModel.titleStr,hotModel.dataModel);
//    CustomCollectionViewCell *newcell = (CustomCollectionViewCell *)cell;
//    NSLog(@"cellForItemAtIndexPath： %@" , cell);
//    [newcell.hotImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.hotPicStr]];
//    newcell.hotImageView.image = [UIImage imageNamed:hotModel.hotPicStr];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
