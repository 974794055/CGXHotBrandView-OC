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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(updateColor)];
    self.titleArr =  [NSMutableArray arrayWithObjects:
                      @"热门菜单Banner",
                      @"仿爱奇艺错位Banner",
                      @"中心点放大",
                      @"仿爱奇艺首个放大",
                      @"纯图片轮播图",
                      @"纯文字轮播图",
                      @"图片文字轮播图",
                      nil];
    [self creatCollectionView];
    
    
    
    NSMutableArray *rowArray = [NSMutableArray array];
    for (int j = 0; j< 34; j++) {
        CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
        [rowArray addObject:model];
    }
    
    
}
- (NSArray *)splitArray:(NSArray *)array withSubSize:(NSInteger)subSize{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        NSInteger index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        NSInteger j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    return [arr copy];
}


- (void)updateColor
{
    [self.collectionView reloadData];
}
- (void)creatCollectionView
{
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        mCollectionView.backgroundColor = [UIColor whiteColor];
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

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    borderLayer.lineWidth = 1.f;
    borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame)) cornerRadius:8];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
    [cell.contentView.layer setMask:maskLayer];
}
#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr = self.titleArr[indexPath.row];
    if (indexPath.row==0) {
        HotViewController *vc = [[HotViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==1){
        CycleViewController *vc = [[CycleViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==2){
        CardViewController *vc = [[CardViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row==3){
        ZoomViewController *vc = [[ZoomViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row==4){
        ScrollViewController *vc = [[ScrollViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        vc.typeInter = 0;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==5){
        ScrollViewController *vc = [[ScrollViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        vc.typeInter = 1;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==6){
        ScrollViewController *vc = [[ScrollViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        vc.typeInter = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }  else{
        ScrollViewController *vc = [[ScrollViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
@end
