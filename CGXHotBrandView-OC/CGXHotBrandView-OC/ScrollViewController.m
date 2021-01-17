//
//  ScrollViewController.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()<CGXHotBrandCustomViewDelegate>

@property (nonatomic , strong) UIScrollView *mainScrollViewH;
@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight)];
    self.mainScrollViewH.bounces = YES;
    self.mainScrollViewH.scrollEnabled = YES;
    self.mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];;
    self.mainScrollViewH.showsHorizontalScrollIndicator = NO;
    self.mainScrollViewH.showsVerticalScrollIndicator = NO;
    //控制滚动视图遇到垂直方向是否反弹
    self.mainScrollViewH.alwaysBounceVertical = YES;
    [self.view addSubview:self.mainScrollViewH];
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i< arc4random() % 5+3; i++) {
        CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
        model.titleStr = [NSString stringWithFormat:@" 🔊🐂双十二超级低价大优惠、五折抢购🐑🐑🐑-%d",i];
        if (self.typeInter==2) {
        model.titleBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        } else{
            model.titleBgColor = [UIColor whiteColor];
        }
        model.itemColor = [UIColor colorWithWhite:0.93 alpha:1];
        model.hotPicStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];;
        model.tagStr = (arc4random() % 2 == 0) ? @"秒杀":@"";
        model.tagSpace = 10;
        model.tagBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        if (self.typeInter < 2) {
            model.titleColor =[UIColor blackColor];
            model.textAlignment = NSTextAlignmentCenter;
        }else{
            model.titleColor = [UIColor whiteColor];
            model.textAlignment = NSTextAlignmentLeft;
        }
        model.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
        };
        [dataArray addObject:model];
    };
    
    
    NSInteger inter = 7;
    CGFloat height = (ScreenHeight-kTopHeight-kSafeHeight-40)/4;
    CGFloat y = 10;
    for (int i = 0; i<inter; i++) {
        CGXHotBrandScrollView *hotBrandView = [[CGXHotBrandScrollView alloc] init];
        hotBrandView.delegate = self;
        hotBrandView.backgroundColor =[UIColor whiteColor];
        hotBrandView.scrollType = CGXHotBrandScrollTypeOnlyImage;
        hotBrandView.fadeOpen = NO;
        hotBrandView.marquee = NO;
        hotBrandView.autoScrollTimeInterval = 2;
        if (self.typeInter==0) {
            hotBrandView.scrollType = CGXHotBrandScrollTypeOnlyImage;
            hotBrandView.frame = CGRectMake(0, y,ScreenWidth , height);
            y = y + height;
            hotBrandView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            if (i % 3 == 0) {
                hotBrandView.pageContolAliment = CGXHotBrandPageContolAlimentCenter;
            } else if (i % 3 == 1) {
                hotBrandView.pageContolAliment = CGXHotBrandPageContolAlimentLeft;
            } else{
                hotBrandView.pageContolAliment = CGXHotBrandPageContolAlimentRight;
            }
            if (i<2) {
                hotBrandView.isHaveSpaceBottom = YES;
            }
            
        } else if (self.typeInter==1){
            hotBrandView.scrollType = CGXHotBrandScrollTypeOnlyTitle;
            hotBrandView.frame = CGRectMake(0, y,ScreenWidth , 30);
            [hotBrandView disableScrollGesture];
            y = y + 40;
            hotBrandView.scrollDirection = UICollectionViewScrollDirectionVertical;
        } else {
            hotBrandView.scrollType = CGXHotBrandScrollTypeImageTitle;
            hotBrandView.pageContolAliment = CGXHotBrandPageContolAlimentRight;
            hotBrandView.frame = CGRectMake(0, y,ScreenWidth , height);
            y = y + height;
            hotBrandView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            if (i<2) {
                hotBrandView.isHaveSpaceBottom = YES;
            }
        }
        
        y = y + 10;
        [self.mainScrollViewH addSubview:hotBrandView];

        if (i>2 && i<6) {
            hotBrandView.fadeOpen = YES;
        }
        if (i>=6) {
            hotBrandView.marquee = YES;
            hotBrandView.autoScrollTimeInterval = 0.1;
            hotBrandView.marqueeRate = 20;
        }
        [hotBrandView updateWithDataArray:dataArray];
    }
    self.mainScrollViewH.contentSize = CGSizeMake(0,y+30);
    
    
}
//- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView
//{
//    return CustomCollectionViewCell.class;
//}
/*点击cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView didSelectItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
    NSLog(@"didSelectItemAtIndexPath：%@---%@" , hotModel.titleStr,hotModel.dataModel);
}
/*滚动结束cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView ScrollItemAtIndexPath:(NSIndexPath *)indexPath AtModel:(CGXHotBrandModel *)hotModel
{
    //    NSLog(@"ScrollItemAtIndexPath：%@---%@" , hotModel.titleStr,hotModel.dataModel);
    
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
