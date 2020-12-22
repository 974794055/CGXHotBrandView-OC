//
//  ViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()<CGXHotBrandCustomViewDelegate,CGXHotBrandViewDataSource>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"icon_0",@"icon_1",@"icon_2",@"icon_3",@"icon_4",@"icon_5",@"icon_6",@"icon_7",@"icon_8",@"icon_9",@"icon_10", nil];
    
    for (int i = 0; i<3; i++) {
        CGXHotBrandView *hotBrandView = [[CGXHotBrandView alloc] init];
        hotBrandView.delegate = self;
        hotBrandView.dataSource =self;
        hotBrandView.minimumLineSpacing = 5;
        hotBrandView.minimumInteritemSpacing = 5;
        hotBrandView.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hotBrandView.itemSectionCount = 2;
        hotBrandView.itemRowCount = 5;
        if (i==0) {
            hotBrandView.pagingEnabled = YES;
            hotBrandView.itemSectionCount = 2;
            hotBrandView.itemRowCount = 5;
        } else if(i==1){
            hotBrandView.pagingEnabled = YES;
            hotBrandView.itemSectionCount = 2;
            hotBrandView.itemRowCount = 6;
        }else{
            hotBrandView.pagingEnabled = NO;
        }
        hotBrandView.bounces = YES;
//        hotBrandView.isHavePage = NO;
        CGFloat height = (ScreenHeight-kTabBarHeight-kTopHeight-40)/3.0;
        hotBrandView.frame = CGRectMake(0, 10*(i+1) + i*height,ScreenWidth,height);
        hotBrandView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        [self.view addSubview:hotBrandView];
        hotBrandView.pageHeight = 10;
        hotBrandView.tag = 10000+i;
        hotBrandView.showType = i+1;
        hotBrandView.isAnimation = i==1 ? NO:YES;
        NSMutableArray *dataArray = [NSMutableArray array];
        for (int j = 0; j< 4; j++) {
            NSMutableArray *rowArray = [NSMutableArray array];
            for (int k = 0; k< hotBrandView.itemSectionCount*hotBrandView.itemRowCount; k++) {
                CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
                model.titleStr = [NSString stringWithFormat:@"猫咪%d-%d",j,k];
                model.itemColor = [UIColor whiteColor];
                model.hotPicStr = imageArray[arc4random() % (imageArray.count)];
                model.tagStr = (arc4random() % 2 == 0) ? @"秒杀":@"";
                model.tagSpace = 10;
                [rowArray addObject:model];
            }
            [dataArray addObject:rowArray];
        }
        [hotBrandView updateWithDataArray:dataArray];
    }
}

//- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
//{
//    if (hotView.tag == 10002) {
//        return nil;
//    }
//    return CustomCollectionViewCell.class;
//}
- (void)gx_hotBrandView:(CGXHotBrandView *)hotView didSelectItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"%@---%@" , hotModel.titleStr,hotModel.dataModel);
}
- (void)gx_hotBrandView:(CGXHotBrandView *)hotView cellForItemAtIndexPath:(NSIndexPath *)indexPath AtCell:(nonnull UICollectionViewCell *)cell AtModel:(nonnull CGXHotBrandModel *)hotModel
{
    CGXHotBrandCell *newcell = (CGXHotBrandCell *)cell;
    
//    NSLog(@"cellForItemAtIndexPath： %@" , cell);

//    [newcell.hotImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.hotPicStr]];
    newcell.hotImageView.image = [UIImage imageNamed:hotModel.hotPicStr];
}
@end
