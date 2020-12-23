//
//  CycleViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CycleViewController.h"

@interface CycleViewController ()<CGXHotBrandCustomViewDelegate,CGXHotBrandCycleViewDataSource>


@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    for (int i = 0; i<2; i++) {
        CGXHotBrandCycleView *hotBrandView = [[CGXHotBrandCycleView alloc] init];
        hotBrandView.delegate = self;
        hotBrandView.dataSource = self;
        hotBrandView.minimumLineSpacing = 10;
        hotBrandView.minimumInteritemSpacing = 10;
        hotBrandView.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        hotBrandView.itemRowCount = 5;
        hotBrandView.itemSectionCount = 3;
        
        hotBrandView.autoScroll = (i == 0 ? YES : NO);
        hotBrandView.offsetX = 0.5;
        CGFloat height = (ScreenHeight-kTopHeight-kTabBarHeight-30)/2.0;
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
            model.hotPicStr = @"HotIcon";
            [dataArray2 addObject:model];
        }
        [hotBrandView updateWithDataArray:dataArray2];
    }
    
}
- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
{
    return CustomCollectionViewCell.class;
}
- (void)gx_hotBrandCycleView:(CGXHotBrandCycleView *)hotView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath AtModel:(nonnull CGXHotBrandModel *)hotModel
{
    NSLog(@"didSelectItemAtIndexPath: %@" , hotModel.hotPicStr);
}
- (void)gx_hotBrandCycleView:(CGXHotBrandCycleView *)hotView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath AtCell:(nonnull UICollectionViewCell *)cell AtModel:(nonnull CGXHotBrandModel *)hotModel
{
    CustomCollectionViewCell *newcell = (CustomCollectionViewCell *)cell;
    newcell.hotImageView.image = [UIImage imageNamed:hotModel.hotPicStr];
    //    [newcell.hotImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.hotPicStr]];
}

@end
