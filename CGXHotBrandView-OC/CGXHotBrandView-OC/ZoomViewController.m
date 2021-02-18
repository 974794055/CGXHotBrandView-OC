//
//  ZoomViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ZoomViewController.h"

@interface ZoomViewController ()<CGXHotBrandCustomViewDelegate,CGXHotBrandZoomViewDataSource>

@property (nonatomic , strong) NSMutableArray<NSString *> *titilArr;
@property (nonatomic , strong) UILabel *titleLabe1;
@property (nonatomic , assign) NSInteger currentInter;
@property (nonatomic , assign) BOOL isFirst;
@end

@implementation ZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.titilArr = [NSMutableArray arrayWithObjects:@"总榜",@"电影榜",@"电视剧榜",@"综合榜",@"儿童榜",@"动漫榜",@"明星影响力",@"热搜榜", nil];
    self.isFirst = YES;
    self.currentInter = 0;
    for (int i = 0; i<2; i++) {
        CGXHotBrandZoomView *hotBrandView = [[CGXHotBrandZoomView alloc] init];
        hotBrandView.tag = 10000+i;
        hotBrandView.delegate = self;
        hotBrandView.dataSource = self;
        hotBrandView.minimumLineSpacing = 10;
        hotBrandView.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        CGFloat height = (ScreenHeight-kTopHeight-kSafeHeight-30)/2.0;
        hotBrandView.frame = CGRectMake(0, (height +10)* i,ScreenWidth , height);
        if (i == 0) {
            hotBrandView.minimumLineSpacing = 5;
            hotBrandView.itemWidthScale = 0.5;
        } else{
            hotBrandView.minimumLineSpacing = 10;
            hotBrandView.itemWidthScale = 0.5;
        }
        hotBrandView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:hotBrandView];
        
        hotBrandView.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
        };
        if (i==0) {
            hotBrandView.itemEffectHeight = 0.8;
            hotBrandView.edgeInsets = UIEdgeInsetsMake(50, 10, 50, 10);
        }
        NSMutableArray *dataArray2 = [self listDataArray];;
        [hotBrandView updateWithDataArray:dataArray2];
        
    }
    
}

- (NSMutableArray *)listDataArray
{
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (int i = 0; i< arc4random() % 1+5; i++) {
        CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
        model.titleModel.text = [NSString stringWithFormat:@"%@:%d",self.titilArr[self.currentInter],i];;
        model.itemColor = [UIColor colorWithWhite:0.93 alpha:1];
        model.hotPicStr = model.hotPicStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];
        model.tagModel.text = (arc4random() % 1 == 0) ? @"秒杀":@"";
        model.titleModel.textAlignment = NSTextAlignmentRight;

        model.tagModel.borderRadius = 6;
        model.tagModel.borderColor = [UIColor grayColor];
        model.tagModel.borderWidth = 0;
        model.tagModel.bgColor = [UIColor redColor];
        model.showType =  CGXHotBrandViewShowTypeRounded;
        model.roundedType =CGXHotBrandRoundedTypeBottomLeft | CGXHotBrandRoundedTypeBottomRight;
        model.titleModel.spaceLeft = 10;
        model.titleModel.spaceRight = 10;
        
        
        model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
        };
        [dataArray2 addObject:model];
    }
    return dataArray2;
}

/*上部分View*/
- (UIView *)gx_hotBrandZoomTopView:(CGXHotBrandZoomView *)hotView
{
    if (hotView.tag != 10000) {
        return nil;
    }
    __weak typeof(self) weakSelf=self;
    CustomTitleView *titleView = [[CustomTitleView alloc] init];
    titleView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [titleView updateDataTitieArray:self.titilArr];
    titleView.titieSelectBlock = ^(NSInteger integer) {
        weakSelf.currentInter = integer;
        NSMutableArray *dataArray2 = [weakSelf listDataArray];;
        [hotView updateWithDataArray:dataArray2];
        
    };
    return titleView;
}
/*下部分View*/
- (UIView *)gx_hotBrandZoomBottomView:(CGXHotBrandZoomView *)hotView
{
    if (hotView.tag != 10000) {
        return nil;
    }
    UIView *vvv = [[UIView alloc] init];
    self.titleLabe1 = [[UILabel alloc] init];
    self.titleLabe1.textColor = [UIColor blackColor];
    [vvv addSubview:self.titleLabe1];
    self.titleLabe1.frame = CGRectMake(10, 0, ScreenWidth-20, 50);
    return vvv;
}
- (void)gx_hotBrandZoomTopView:(CGXHotBrandZoomView *)hotView AtInter:(NSInteger)inter ItemModel:(CGXHotBrandModel *)itemModel
{
    if (hotView.tag != 10000) {
        return;
    }
}
- (void)gx_hotBrandZoomBottomView:(CGXHotBrandZoomView *)hotView AtInter:(NSInteger)inter ItemModel:(CGXHotBrandModel *)itemModel
{
    if (hotView.tag != 10000) {
        return;
    }
    self.titleLabe1.text = itemModel.titleModel.text;
}
- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
{
    if (hotView.tag == 10000) {
        return nil;
    }
    return CustomCollectionViewCell.class;
}
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
    if (hotView.tag != 10000) {
        NSLog(@"%@---%@" , hotModel.titleModel.text,hotModel.dataModel);
    }
   
//    CustomCollectionViewCell *newcell = (CustomCollectionViewCell *)cell;
//    NSLog(@"cellForItemAtIndexPath： %@" , cell);
//    [newcell.hotImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.hotPicStr]];
//    newcell.hotImageView.image = [UIImage imageNamed:hotModel.hotPicStr];
}

@end
