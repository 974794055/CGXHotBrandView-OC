//
//  CardViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()<CGXHotBrandCustomViewDelegate,CGXHotBrandCardViewDataSource>

@property (nonatomic , strong) NSMutableArray<NSString *> *titilArr;
@property (nonatomic , strong) UIScrollView *mainScrollViewH;

@property (nonatomic , strong) UIView *lineView;
@property (nonatomic , assign) NSInteger currentInter;
@property (nonatomic , assign) BOOL isFirst;

@end

@implementation CardViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titilArr = [NSMutableArray arrayWithObjects:@"总榜",@"电影榜",@"电视剧榜",@"综合榜",@"儿童榜",@"动漫榜",@"明星影响力",@"热搜榜", nil];
    self.isFirst = YES;
    self.currentInter = 0;
    
    self.mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight)];
    self.mainScrollViewH.bounces = YES;
    self.mainScrollViewH.scrollEnabled = YES;
    self.mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    self.mainScrollViewH.showsHorizontalScrollIndicator = NO;
    self.mainScrollViewH.showsVerticalScrollIndicator = NO;
    //控制滚动视图遇到垂直方向是否反弹
    self.mainScrollViewH.alwaysBounceVertical = YES;
    [self.view addSubview:self.mainScrollViewH];
    
    CGFloat y = 10;
    for (int i = 0; i<7; i++) {
        CGXHotBrandCardView *hotBrandView = [[CGXHotBrandCardView alloc] init];
        hotBrandView.tag = 10000+i;
        hotBrandView.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
        hotBrandView.delegate = self;
        hotBrandView.dataSource = self;
        [self.mainScrollViewH addSubview:hotBrandView];
        hotBrandView.itemAlpha = 1;
        hotBrandView.itemIsZoom = YES;
        hotBrandView.itemClickCenter = YES;
        CGFloat height = 300;
        hotBrandView.frame = CGRectMake(0, y, ScreenWidth, height);
//        hotBrandView.isHavePage = NO;
        y = y + height + 10;
        hotBrandView.itemScaleFactor = 0.3;
        hotBrandView.itemWidthScale = 0.5;
        hotBrandView.itemSpaceBottom = 20;
        hotBrandView.itemSpaceTop = 10;
        if (i==0) {
            hotBrandView.cellPosition = CGXHotBrandCellPositionCenter;
            hotBrandView.autoScroll = NO;
            hotBrandView.infiniteLoop = YES;
            hotBrandView.itemSpaceTop = 50;
            hotBrandView.itemSpaceBottom = 20;
        } else if (i==1){
            hotBrandView.cellPosition = CGXHotBrandCellPositionCenter;
            hotBrandView.autoScroll = NO;
            hotBrandView.infiniteLoop = YES;
            hotBrandView.itemSpaceBottom = 70;
        } else if (i==2){
            hotBrandView.cellPosition = CGXHotBrandCellPositionCenter;
            hotBrandView.itemWidthScale = 0.3;
        } else if (i==3){
            hotBrandView.cellPosition = CGXHotBrandCellPositionTop;
            hotBrandView.itemScaleFactor = 0.2;
            hotBrandView.itemWidthScale = 0.3;
        } else if (i==4){
            hotBrandView.cellPosition = CGXHotBrandCellPositionBottom;
            hotBrandView.itemScaleFactor = 0.2;
            hotBrandView.itemWidthScale = 0.3;
        }else if (i==5){
            hotBrandView.itemScaleFactor = 0;
            hotBrandView.itemWidthScale = 0.8;
        }else{
            hotBrandView.itemWidthScale = 0.8;
            hotBrandView.itemScaleFactor = 0.2;
        }
        hotBrandView.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
        };
        //        hotBrandView.autoScroll = NO;
        //        hotBrandView.infiniteLoop = NO;
        //        hotBrandView.isHavePage = NO;
        
        NSMutableArray *dataArray = [self loadDataArray];
        [hotBrandView updateWithDataArray:dataArray];
    }
    self.mainScrollViewH.contentSize = CGSizeMake(0,10+y);
}
- (NSMutableArray *)loadDataArray
{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i< arc4random() % 10 + 5; i++) {
        CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
        model.titleModel.text = [NSString stringWithFormat:@"猫咪-%d",i];
        model.itemColor = [UIColor colorWithWhite:0.93 alpha:1];
        model.hotPicStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];;
        model.tagModel.text = (arc4random() % 1 == 0) ? @"秒杀":@"";

//        model.tagHSpace = 10;
//        model.tagVSpace = 0;
        model.tagModel.borderRadius = 6;
        model.tagModel.borderColor = [UIColor grayColor];
        model.tagModel.borderWidth = 0;
        model.tagModel.bgColor = [UIColor redColor];
        model.titleModel.spaceLeft = 10;
        model.titleModel.spaceRight = 10;
        model.showType =  CGXHotBrandViewShowTypeRounded;
        model.roundedType =CGXHotBrandRoundedTypeBottomLeft | CGXHotBrandRoundedTypeBottomRight;
        
        model.itemBorderColor = [UIColor blackColor];
        model.itemBorderWidth = 1;
        model.itemBorderRadius = 10;
        
        model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
        };
        [dataArray addObject:model];
    };
    return dataArray;
}
/*上部分View*/
- (UIView *)gx_hotBrandCardTopView:(CGXHotBrandCardView *)hotView
{
    if (hotView.tag != 10000) {
        return nil;
    }
    __weak typeof(self) weakSelf=self;
    CustomTitleView *titleView = [[CustomTitleView alloc] init];
    //    titleView.backgroundColor = [UIColor whiteColor];
    titleView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [titleView updateDataTitieArray:self.titilArr];
    titleView.titieSelectBlock = ^(NSInteger integer) {
        weakSelf.currentInter = integer;
        NSMutableArray *dataArray = [weakSelf loadDataArray];
        [hotView updateWithDataArray:dataArray];
        
    };
    return titleView;
}

/*下部分View*/
- (UIView *)gx_hotBrandCardBottomView:(CGXHotBrandCardView *)hotView
{
    if (hotView.tag != 10001 ) {
        return nil;
    }
    __weak typeof(self) weakSelf=self;
    CustomTitleView *titleView = [[CustomTitleView alloc] init];
//    titleView.backgroundColor = [UIColor whiteColor];
    titleView.frame = CGRectMake(0, 0, ScreenWidth, 70);
    [titleView updateDataTitieArray:self.titilArr];
    titleView.titieSelectBlock = ^(NSInteger integer) {
        weakSelf.currentInter = integer;
        NSMutableArray *dataArray = [weakSelf loadDataArray];
        [hotView updateWithDataArray:dataArray];
    };
    return titleView;
}
- (void)gx_hotBrandCardBottomView:(CGXHotBrandCardView *)hotView AtInter:(NSInteger)inter ItemModel:(CGXHotBrandModel *)itemModel
{
    if (hotView.tag != 10001) {
        return;
    }
}
- (void)gx_hotBrandCardTopView:(CGXHotBrandCardView *)hotView AtInter:(NSInteger)inter ItemModel:(CGXHotBrandModel *)itemModel
{
    if (hotView.tag != 10000) {
        return;
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
