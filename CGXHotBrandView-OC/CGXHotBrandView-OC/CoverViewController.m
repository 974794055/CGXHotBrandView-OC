//
//  CoverViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CoverViewController.h"

@interface CoverViewController ()<CGXHotBrandCustomViewDelegate>
@property (nonatomic , strong) UIScrollView *mainScrollViewH;
@end

@implementation CoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight)];
    self.mainScrollViewH.bounces = YES;
    self.mainScrollViewH.scrollEnabled = YES;
    self.mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];;
    self.mainScrollViewH.showsHorizontalScrollIndicator = NO;
    self.mainScrollViewH.showsVerticalScrollIndicator = NO;
    //控制滚动视图遇到垂直方向是否反弹
    self.mainScrollViewH.alwaysBounceVertical = YES;
    [self.view addSubview:self.mainScrollViewH];
    
    CGFloat y = 10;
    for (int i = 0; i<5; i++) {
        CGXHotBrandCoverView *hotBrandView = [[CGXHotBrandCoverView alloc] init];
        hotBrandView.delegate = self;
        hotBrandView.frame = CGRectMake(0, y,ScreenWidth , 300);
        
        y = y + 310;
//    hotBrandView.itemWidthScale = 0.4;
//    hotBrandView.itemHeightScale = 0.6;
        hotBrandView.backgroundColor = [UIColor whiteColor];
        [self.mainScrollViewH addSubview:hotBrandView];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        for (int i = 0; i< arc4random() % 5+10; i++) {
            CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
            model.titleModel.text = [NSString stringWithFormat:@" 双十二低价-%d",i];
            model.titleModel.bgColor = [UIColor whiteColor];
            model.itemColor = [UIColor colorWithWhite:0.93 alpha:1];
            model.itemColor = [UIColor whiteColor];
            model.hotPicStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];;
            model.tagModel.text =  @"秒杀";
        
            model.titleModel.color =[UIColor blackColor];
            model.titleModel.textAlignment = NSTextAlignmentCenter;
   
            model.tagModel.borderRadius = 6;
            model.tagModel.borderColor = [UIColor grayColor];
            model.tagModel.borderWidth = 0;
            model.tagModel.bgColor = [UIColor redColor];
            model.showType =  CGXHotBrandViewShowTypeRounded;
            model.roundedType =CGXHotBrandRoundedTypeBottomLeft | CGXHotBrandRoundedTypeBottomRight;
            model.titleModel.spaceLeft = 10;
            model.titleModel.spaceRight = 10;
            model.numModel.text = [NSString stringWithFormat:@"特价-%d",i];;
            model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                [hotImageView sd_setImageWithURL:hotImageURL];
            };
            [dataArray addObject:model];
        };
        [hotBrandView updateWithDataArray:dataArray];
    }
    self.mainScrollViewH.contentSize = CGSizeMake(0,y+30);
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
//    NSLog(@"%@---%@---%@" , hotModel.hotPicStr,hotModel.titleStr,hotModel.dataModel);
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
