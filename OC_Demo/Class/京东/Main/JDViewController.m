//
//  JDViewController.m
//  OC_Demo
//
//  Created by sll on 2017/7/17.
//  Copyright © 2017年 LUOSU. All rights reserved.
//
//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

#import "JDViewController.h"

#import "JDNavigationController.h"
#import "JDHomeViewController.h"
#import "JDCategoryViewController.h"
#import "JDFindViewController.h"
#import "JDCartViewController.h"
#import "JDMyViewController.h"

@interface JDViewController ()<UITabBarControllerDelegate>

@property (nonatomic , assign)JDHomeViewController *homeViewController;
@property (nonatomic , assign)JDCategoryViewController *categoryViewController;
@property (nonatomic , assign)JDFindViewController *findViewController;
@property (nonatomic , assign)JDCartViewController *cartViewController;
@property (nonatomic , assign)JDMyViewController *myViewController;

@end

@implementation JDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self addChildVC];
}

- (void)addChildVC{
    JDHomeViewController *homeVC = [[JDHomeViewController alloc] init];
    [self addOneChildVc:homeVC title:@"" imageName:@"tabr_01_up" selectedImageName:@"tabr_01_down"];
    _homeViewController = homeVC;
    
    JDCategoryViewController *categoryVC = [[JDCategoryViewController alloc] init];
    [self addOneChildVc:categoryVC title:@"" imageName:@"tabr_02_up" selectedImageName:@"tabr_02_down"];
    _categoryViewController= categoryVC;
    
//    JDFindViewController *findVC = [[JDFindViewController alloc] init];
//    [self addOneChildVc:findVC title:@"发现" imageName:@"tabBar_find_normal" selectedImageName:@"tabBar_find_press"];
//    _findViewController= findVC;
    
    JDCartViewController *cartVC = [[JDCartViewController alloc] init];
    [self addOneChildVc:cartVC title:@"" imageName:@"tabr_04_up" selectedImageName:@"tabr_04_down"];
    _cartViewController= cartVC;
    
    JDMyViewController *myVC = [[JDMyViewController alloc] init];
    [self addOneChildVc:myVC title:@"" imageName:@"tabr_05_up" selectedImageName:@"tabr_05_down"];
    _myViewController= myVC;

}

-  (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //设置标题
    childVc.title = title;
    //设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    //设置选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        //声明这张图用原图
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    //设置背景
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //添加导航控制器
    JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:childVc];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:239/255.0 green:109/255.0 blue:114/255.0 alpha:1]} forState:UIControlStateSelected];
    [self addChildViewController:nav];

}

#pragma mark - <UITabBarControllerDelegate>

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    [self tabBarButtonClick:[self getTabbarButton]];
}

- (UIControl *)getTabbarButton
{
    NSMutableArray *tabBarButtons = [NSMutableArray array];
    for (UIView *tabBarButton in  self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *selectBarButtonItem = [tabBarButtons objectAtIndex:self.selectedIndex];
    return selectBarButtonItem;
}

//点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton{
    
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView" )]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}
@end
