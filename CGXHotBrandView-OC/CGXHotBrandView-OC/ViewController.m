//
//  ViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()<CGXHotBrandBaseViewDelegate>


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
    for (int i = 0; i<3; i++) {
        CGXHotBrandView *hotBrandView = [[CGXHotBrandView alloc] init];
        hotBrandView.delegate = self;
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
        hotBrandView.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
        };
        hotBrandView.pageHeight = 10;

        
        hotBrandView.tag = 10000+i;
        NSMutableArray *dataArray = [NSMutableArray array];
        for (int i = 0; i< 4; i++) {
            NSMutableArray *rowArray = [NSMutableArray array];
            for (int j = 0; j< hotBrandView.itemSectionCount*hotBrandView.itemRowCount; j++) {
                CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
                model.titleStr = [NSString stringWithFormat:@"猫咪%d-%d",i,j];
                model.itemColor = [UIColor whiteColor];
                model.hotPicStr = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547703274,3363083080&fm=11&gp=0.jpg";
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
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView DidSelectItemAtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"%@---%@" , hotModel.titleStr,hotModel.dataModel);
}
@end
