//
//  SliderViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()<CGXHotBrandCustomViewDelegate>

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    CGFloat y = 10;
    for (int i = 0; i<3; i++) {
        CGXHotBrandSliderView *hotBrandView = [[CGXHotBrandSliderView alloc] init];
        hotBrandView.delegate = self;
        CGFloat height = (ScreenHeight-kTopHeight-kSafeHeight-40)/2.0;
        if (i == 0) {
            hotBrandView.frame = CGRectMake(0, y,ScreenWidth , height);
            y=y+height+10;
        } else {
            hotBrandView.frame = CGRectMake(0, y,ScreenWidth , height/2);
            y=y+height/2+10;
        }
        hotBrandView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:hotBrandView];

        hotBrandView.isHavePage = i == 0 ? YES:NO;
//        hotBrandView.visibleItemsCount = 5;
//        hotBrandView.minScale = 0.6;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        for (int i = 0; i< arc4random() % 5+3; i++) {
            CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
            model.titleModel.text = [NSString stringWithFormat:@" 🔊🐂双十二超级低价大优惠、五折抢购🐑🐑🐑-%d",i];
            model.titleModel.bgColor = [UIColor whiteColor];
            model.itemColor = [UIColor colorWithWhite:0.93 alpha:1];
            model.hotPicStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];;
            model.tagModel.text = (arc4random() % 2 == 0) ? @"秒杀":@"";
            model.tagModel.bgColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
                model.titleModel.color =[UIColor blackColor];
                model.titleModel.textAlignment = NSTextAlignmentCenter;
            model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                [hotImageView sd_setImageWithURL:hotImageURL];
            };
            [dataArray addObject:model];
        };
        [hotBrandView updateWithDataArray:dataArray];
    }
    
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
    NSLog(@"%@---%@---%@" , hotModel.hotPicStr,hotModel.titleModel.text,hotModel.dataModel);
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
