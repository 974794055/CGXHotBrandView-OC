//
//  HotViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2021/1/4.
//

#import "HotViewController.h"

@interface HotViewController ()<CGXHotBrandCustomViewDelegate>

@property (nonatomic , strong) UIScrollView *mainScrollViewH;

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight)];
    self.mainScrollViewH.bounces = YES;
    self.mainScrollViewH.scrollEnabled = YES;
    self.mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    self.mainScrollViewH.showsHorizontalScrollIndicator = NO;
    self.mainScrollViewH.showsVerticalScrollIndicator = NO;
    //控制滚动视图遇到垂直方向是否反弹
    self.mainScrollViewH.alwaysBounceVertical = YES;
    [self.view addSubview:self.mainScrollViewH];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"icon_0",@"icon_1",@"icon_2",@"icon_3",@"icon_4",@"icon_5",@"icon_6",@"icon_7",@"icon_8",@"icon_9",@"icon_10", nil];
    NSInteger countInter = 4;
    CGFloat y = 10;
    for (int i = 0; i<countInter; i++) {
        CGXHotBrandView *hotBrandView = [[CGXHotBrandView alloc] init];
        [self.mainScrollViewH addSubview:hotBrandView];
        hotBrandView.tag = 10000+i;
        hotBrandView.delegate = self;
        hotBrandView.minimumLineSpacing = 0;
        hotBrandView.minimumInteritemSpacing = 0;
        hotBrandView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        hotBrandView.bounces = YES;
//                hotBrandView.isHavePage = NO;
        hotBrandView.backgroundColor = [UIColor whiteColor];
        hotBrandView.pageHeight = 15;
        hotBrandView.isAnimation = i==1 ? NO:YES;
        hotBrandView.itemSectionCount = 2;
        hotBrandView.itemRowCount =  5;
        if (i<3) {
            hotBrandView.pagingEnabled = YES;
            if(i==1){
                hotBrandView.itemSectionCount = 2;
                hotBrandView.itemRowCount = 6;
            }
        } else{
            hotBrandView.pagingEnabled = NO;
        }
        hotBrandView.pageSelectColor = [UIColor redColor];
        hotBrandView.pageNormalColor = [UIColor grayColor];
//        hotBrandView.pageNormalImage = [UIImage imageNamed:@"TriangleDefault"];
//        hotBrandView.pageSelectImage = [UIImage imageNamed:@"TriangleCurrent"];
  
        CGFloat height = (ScreenHeight-kSafeHeight-kTopHeight-40)/3.0;
        if (i>=3) {
            height = 200;
        }
        hotBrandView.frame = CGRectMake(0, y, ScreenWidth, height);
        y = y + height + 10;

        NSMutableArray *dataArray = [NSMutableArray array];
        for (int j = 0; j< 4*hotBrandView.itemSectionCount*hotBrandView.itemRowCount; j++) {
            CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
            model.titleStr = [NSString stringWithFormat:@"猫咪--%d",i];
            model.itemColor = [UIColor whiteColor];
            model.hotPicStr = imageArray[arc4random() % (imageArray.count)];
            model.tagStr = (arc4random() % 2 == 0) ? @"秒杀":@"";
            model.tagSpace = 5;
            model.tagVSpace = 5;
            model.tagHSpace= 5;
            model.tagBorderRadius = 10;
            model.tagBorderColor = [UIColor grayColor];
            model.tagBorderWidth = 0;
            model.tagBgColor = [UIColor redColor];
            model.showType =  i;
            model.roundedType = i<3 ? CGXHotBrandRoundedTypeBottomLeft:CGXHotBrandRoundedTypeAll;
            model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                [hotImageView sd_setImageWithURL:hotImageURL];
            };
            [dataArray addObject:model];
        }
        [hotBrandView updateWithDataArray:dataArray];
    }
    self.mainScrollViewH.contentSize = CGSizeMake(0,30+y);

    
}

//
//- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
//{
//    if (hotView.tag < 10003) {
//        return nil;
//    }
//    return CustomCollectionViewCell.class;
//}
/*点击cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView didSelectItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"didSelectItemAtIndexPath：%@---%@" , hotModel.titleStr,hotModel.dataModel);
    
    hotModel.titleStr = [NSString stringWithFormat:@"猫咪%u",arc4random() % 10+100];
    CGXHotBrandView *hotBrandView = (CGXHotBrandView *)hotView;
    [hotBrandView updateWithItemModel:hotModel AtIndexPath:indexPath];
}
/*滚动结束cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView ScrollItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"ScrollItemAtIndexPath：%@---%@" , hotModel.titleStr,hotModel.dataModel);

}
/* cell数据交互处理*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView cellForItemAtIndexPath:(NSIndexPath *)indexPath AtCell:(UICollectionViewCell *)cell AtModel:(CGXHotBrandModel *)hotModel
{
//    NSLog(@"%@---%@" , hotModel.titleStr,hotModel.dataModel);
//    CGXHotBrandCell *newcell = (CGXHotBrandCell *)cell;
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
