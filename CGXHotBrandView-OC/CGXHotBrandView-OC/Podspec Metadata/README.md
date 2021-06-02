# CGXHotBrandView-OC

[![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
[![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
[![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/CGXHotBrandView-OC)
[![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 

## 热门菜单
- 下载链接：https://github.com/974794055/CGXHotBrandView-OC.git
- QQ号：974794055
- 群名称：
- 群   号：
- 版本： 0.0.7

## 功能：    
- 仿淘宝、京东等主流APP热门菜单切换的滚动视图

## 优点：
- 1、提供更加全面丰富、高度自定义的效果；
- 2、使用子类化管理cell样式，逻辑更清晰，扩展更简单；
- 3、高度封装列表容器，使用便捷，完美支持列表的生命周期调用； 
- 4、角标提醒 ； 

## 效果预览
### 效果预览图
说明 | Gif |
----|------|
热门菜单  |  <img src="https://github.com/974794055/CGXHotBrandView-OC/blob/master/CGXCategoryViewGif/hotBrand1.gif" width="287" height="600"> |
Appstore滚动  |  <img src="https://github.com/974794055/CGXHotBrandView-OC/blob/master/CGXCategoryViewGif/hotBrand2.gif" width="287" height="600"> |
中心点放大  |  <img src="https://github.com/974794055/CGXHotBrandView-OC/blob/master/CGXCategoryViewGif/hotBrand3.gif" width="287" height="600"> |
仿爱奇艺首个放大  |  <img src="https://github.com/974794055/CGXHotBrandView-OC/blob/master/CGXCategoryViewGif/hotBrand4.gif" width="287" height="600"> |
存图片轮播  |  <img src="https://github.com/974794055/CGXHotBrandView-OC/blob/master/CGXCategoryViewGif/hotBrand5.gif" width="287" height="600"> |
存文字轮播 |  <img src="https://github.com/974794055/CGXHotBrandView-OC/blob/master/CGXCategoryViewGif/hotBrand6.gif" width="287" height="600"> |
图文轮播  |  <img src="https://github.com/974794055/CGXHotBrandView-OC/blob/master/CGXCategoryViewGif/hotBrand7.gif" width="287" height="600"> |

## 要求

- iOS 8.0+
- Xcode 9+
- Objective-C

## 安装
### 手动
- Clone代码，把CGXHotBrandViewOC文件夹拖入项目，#import "CGXHotBrandViewOC.h"，就可以使用了；

### CocoaPods
```ruby
target '<Your Target Name>' do
    pod 'CGXHotBrandViewOC'
end
```
- 先执行`pod repo update`，再执行`pod install`
- 导入头文件#import <CGXHotBrandViewOC/CGXHotBrandViewOC.h> 就可以使用了；
## 结构图
## 使用
### CGXHotBrandView使用示例
- 1.初始化CGXHotBrandView
```Objective-C
CGXHotBrandView *hotBrandView = [[CGXHotBrandView alloc] init];
hotBrandView.delegate = self;
hotBrandView.minimumLineSpacing = 5;
hotBrandView.minimumInteritemSpacing = 5;
hotBrandView.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
hotBrandView.itemSectionCount = 2;
hotBrandView.itemRowCount = 5;
hotBrandView.pagingEnabled = YES;
hotBrandView.itemSectionCount = 2;
hotBrandView.itemRowCount = 5;
hotBrandView.pageHeight = 10;
hotBrandView.bounces = YES;
CGFloat height = (ScreenHeight-kTabBarHeight-kTopHeight-40)/3.0;
hotBrandView.frame = CGRectMake(0, 10,ScreenWidth,height);
hotBrandView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
[self.view addSubview:hotBrandView];

hotBrandView.hotBrand_loadImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
    [hotImageView sd_setImageWithURL:hotImageURL];
};

```
- 2.配置CGXHotBrandView数据的属性
```Objective-C
hotBrandView.tag = 10000+i;
NSMutableArray *dataArray = [NSMutableArray array];
for (int i = 0; i< 4; i++) {
    NSMutableArray *rowArray = [NSMutableArray array];
    for (int j = 0; j< hotBrandView.itemSectionCount*hotBrandView.itemRowCount; j++) {
        CGXHotBrandModel *model = [[CGXHotBrandModel alloc] init];
        model.titleModel.text = [NSString stringWithFormat:@"猫咪%d-%d",i,j];
        model.itemColor = [UIColor whiteColor];
        model.hotPicStr = @"HotIcon0";
        [rowArray addObject:model];
    }
    [dataArray addObject:rowArray];
}
[hotBrandView updateWithDataArray:dataArray];
```

- 3.可选实现`CGXHotBrandCustomViewDelegate`代理

```Objective-C
/*点击cell*/
- (void)gx_hotBrandBaseView:(CGXHotBrandBaseView *)hotView DidSelectItemAtModel:(CGXHotBrandModel *)hotModel;
// ========== 轮播自定义cell ==========
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)gx_hotBrandCellClassForBaseView:(CGXHotBrandBaseView *)hotView;
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (UINib *)gx_hotBrandCellNibForBaseView:(CGXHotBrandBaseView *)hotView;
```

- 4.自定义cell实现`CGXHotBrandUpdateCellDelegate`代理方法

不管列表是UIView还是UIViewController都可以，提高使用灵活性，更便于现有的业务接入。
```Objective-C
- (void)updateWithHotBrandCellModel:(CGXHotBrandModel *)cellModel Section:(NSInteger)section Row:(NSInteger)row
```

## 补充

如果刚开始使用`CGXHotBrandViewOC`，当开发过程中需要支持某种特性时，请务必先搜索使用文档或者源代码。确认是否已经实现支持了想要的特性。

该仓库保持随时更新，对于主流新的分类选择效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮箱：974794055@qq.com </br>
QQ群： 

<img src="" width="300" height="411">

喜欢就star❤️一下吧

## License

CGXHotBrandViewOC is released under the MIT license.



