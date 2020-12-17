//
//  CycleViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/17.
//

#import "CycleViewController.h"

@interface CycleViewController ()<CGXHotBrandBaseViewDelegate>


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
        hotBrandView.minimumLineSpacing = 10;
        hotBrandView.minimumInteritemSpacing = 10;
        hotBrandView.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        hotBrandView.itemRowCount = 5;
        hotBrandView.itemSectionCount = 3;
        
        
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
        hotBrandView.loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
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
        [hotBrandView updateWithDataArray:dataArray2];
    }

}
- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
{
    return CustomCollectionViewCell.class;
}
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView DidSelectItemAtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"%@" , hotModel.titleStr);
}


@end
