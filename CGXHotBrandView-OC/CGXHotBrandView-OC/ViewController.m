//
//  ViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()<CGXHotBrandBaseViewDelegate>

@property (nonatomic, strong) CGXHotBrandView *hotBrandView;

@property (nonatomic, strong) CGXHotBrandCycleView *hotBrandView2;

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
    
    self.hotBrandView = [[CGXHotBrandView alloc] init];
    self.hotBrandView.delegate = self;
    self.hotBrandView.minimumLineSpacing = 5;
    self.hotBrandView.minimumInteritemSpacing = 5;
    self.hotBrandView.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.hotBrandView.itemSectionCount = 2;
    self.hotBrandView.itemRowCount = 5;
    self.hotBrandView.frame = CGRectMake(0, 20,[UIScreen mainScreen].bounds.size.width , (([UIScreen mainScreen].bounds.size.width-50)/5+30)*2+30+20);
    self.hotBrandView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self.view addSubview:self.hotBrandView];
    self.hotBrandView.loadImageCallback = ^(UIImageView * _Nonnull imageView, NSURL * _Nonnull imageURL) {
        [imageView sd_setImageWithURL:imageURL];
    };
    self.hotBrandView.pageHeight = 10;
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i< 4; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j< self.hotBrandView.itemSectionCount*self.hotBrandView.itemRowCount; j++) {
            CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
            model.titleStr = [NSString stringWithFormat:@"猫咪%d-%d",i,j];
            model.itemColor = [UIColor whiteColor];
            model.hotPicStr = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547703274,3363083080&fm=11&gp=0.jpg";
            [rowArray addObject:model];
        }
        [dataArray addObject:rowArray];
    }
    [self.hotBrandView updateWithDataArray:dataArray];
    
    
    self.hotBrandView2 = [[CGXHotBrandCycleView alloc] init];
    self.hotBrandView2.delegate = self;
    self.hotBrandView2.minimumLineSpacing = 10;
    self.hotBrandView2.minimumInteritemSpacing = 10;
    self.hotBrandView2.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.hotBrandView2.itemRowCount = 5;
    self.hotBrandView2.itemSectionCount = 3;
    self.hotBrandView2.widthSpace = 1;
    self.hotBrandView2.frame = CGRectMake(0, CGRectGetMaxY(_hotBrandView.frame)+30,[UIScreen mainScreen].bounds.size.width , 300);
    self.hotBrandView2.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self.view addSubview:self.hotBrandView2];
    self.hotBrandView2.loadImageCallback = ^(UIImageView * _Nonnull imageView, NSURL * _Nonnull imageURL) {
        [imageView sd_setImageWithURL:imageURL];
    };
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"跑步鞋",@"运动袜",@"运动帽",@"单肩包",@"双肩包",@"男童鞋",@"女童鞋",@"男童装",@"女童装",@"跑步鞋",@"休闲鞋",@"训练鞋", @"羽绒服",@"紧身服",@"比赛服",nil];
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (int i = 0; i< titleArr.count; i++) {
        CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
        model.titleStr = titleArr[i];
        model.itemColor = [UIColor whiteColor];
        model.hotPicStr = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547703274,3363083080&fm=11&gp=0.jpg";
        [dataArray2 addObject:model];
    }
    [self.hotBrandView2 updateWithDataArray:dataArray2];
}

- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
{
    if (hotView == self.hotBrandView) {
        return nil;
    }
    return CustomCollectionViewCell.class;
}
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView DidSelectItemAtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"%@" , hotModel.titleStr);
}
@end
