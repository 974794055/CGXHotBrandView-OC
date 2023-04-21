//
//  ViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "ViewController.h"
#import "ListCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *titleArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    UIImage *image = [self imageWithColor:[UIColor whiteColor] Size:CGSizeMake(ScreenWidth, kTopHeight)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance * appearance = [[UINavigationBarAppearance alloc] init];
        // 背景色
        appearance.backgroundColor = [UIColor whiteColor];
        // 去除导航栏阴影（如果不设置clear，导航栏底下会有一条阴影线）
        appearance.shadowColor = [UIColor clearColor];
        // 字体颜色、尺寸等
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        // 带scroll滑动的页面
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        // 常规页面
        self.navigationController.navigationBar.standardAppearance = appearance;
    }
    // iOS 15适配
    if (@available(iOS 15.0, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance setBackgroundColor:[UIColor whiteColor]];
        // UINavigationBarAppearance 会覆盖原有的导航栏设置，这里需要重新设置返回按钮隐藏，不隐藏可注释或删掉
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffsetMake(-200, 0);
        [[UINavigationBar appearance] setScrollEdgeAppearance:appearance];
        [[UINavigationBar appearance] setStandardAppearance:appearance];
    }
    self.titleArr =  [NSMutableArray arrayWithObjects:
                      @"热门菜单Banner",
                      @"仿爱奇艺错位Banner",
                      @"中心点放大",
                      @"仿爱奇艺首个放大",
                      @"中心置顶放大",
                      @"纯图片轮播图",
                      @"纯文字轮播图",
                      @"图片文字轮播图",
                      @"旋转",
                      @"滑块",
                      nil];
    [self creatCollectionView];
    NSMutableArray *rowArray = [NSMutableArray array];
    for (int j = 0; j< 34; j++) {
        CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
        [rowArray addObject:model];
    }
}

- (void)creatCollectionView
{
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        mCollectionView.backgroundColor = [UIColor clearColor];
        mCollectionView.showsHorizontalScrollIndicator = YES;
        mCollectionView.showsVerticalScrollIndicator = YES;
        mCollectionView.dataSource = self;
        mCollectionView.delegate = self;
        [mCollectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ListCollectionViewCell class])];
        mCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //给collectionView注册头分区的Id
        [mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        //给collection注册脚分区的id
        [mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        if (@available(iOS 11.0, *)) {
            mCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        mCollectionView;
    });
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 0);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width-20,80);
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        return view;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ListCollectionViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    return cell;
}
#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr = self.titleArr[indexPath.row];
    if ([titleStr isEqualToString:@"热门菜单Banner"]) {
        HotViewController *vc = [[HotViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"仿爱奇艺错位Banner"]){
        CycleViewController *vc = [[CycleViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"中心点放大"]){
        CardViewController *vc = [[CardViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"仿爱奇艺首个放大"]){
        ZoomViewController *vc = [[ZoomViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"中心置顶放大"]){
        CoverViewController *vc = [[CoverViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"纯图片轮播图"]){
        ScrollViewController *vc = [[ScrollViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        vc.typeInter = 0;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"纯文字轮播图"]){
        ScrollViewController *vc = [[ScrollViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        vc.typeInter = 1;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"图片文字轮播图"]){
        ScrollViewController *vc = [[ScrollViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        vc.typeInter = 2;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"旋转"]){
        RotaryViewController *vc = [[RotaryViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleStr isEqualToString:@"滑块"]){
        SliderViewController *vc = [[SliderViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
/**
 *  生成图片
 *  @return 生成的图片
 */
- (UIImage*)imageWithColor:(UIColor*)color Size:(CGSize)size
{
    CGRect r= CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
