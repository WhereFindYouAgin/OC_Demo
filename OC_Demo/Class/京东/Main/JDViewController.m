//
//  JDViewController.m
//  OC_Demo
//
//  Created by sll on 2017/7/17.
//  Copyright © 2017年 LUOSU. All rights reserved.
//
//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#import "JDViewController.h"

#import "JDNavigationController.h"
#import "JDHomeViewController.h"
#import "JDCategoryViewController.h"
#import "JDFindViewController.h"
#import "JDCartViewController.h"
#import "JDMyViewController.h"

@interface JDViewController ()

@property (nonatomic , assign)JDHomeViewController *homeViewController;
@property (nonatomic , assign)JDCategoryViewController *categoryViewController;
@property (nonatomic , assign)JDFindViewController *findViewController;
@property (nonatomic , assign)JDCartViewController *cartViewController;
@property (nonatomic , assign)JDMyViewController *myViewController;

@end

@implementation JDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVC];
}

- (void)addChildVC{
    JDHomeViewController *homeVC = [[JDHomeViewController alloc] init];
    [self addOneChildVc:homeVC title:@"首页" imageName:@"tabBar_home_normal" selectedImageName:@"tabBar_home_press"];
    _homeViewController = homeVC;
    
    JDCategoryViewController *categoryVC = [[JDCategoryViewController alloc] init];
    [self addOneChildVc:categoryVC title:@"分类" imageName:@"tabBar_category_normal" selectedImageName:@"tabBar_category_press"];
    _categoryViewController= categoryVC;
    
    JDFindViewController *findVC = [[JDFindViewController alloc] init];
    [self addOneChildVc:findVC title:@"发现" imageName:@"tabBar_find_normal" selectedImageName:@"tabBar_find_press"];
    _findViewController= findVC;
    
    JDCartViewController *cartVC = [[JDCartViewController alloc] init];
    [self addOneChildVc:cartVC title:@"购物车" imageName:@"tabBar_cart_normal" selectedImageName:@"tabBar_cart_press"];
    _cartViewController= cartVC;
    
    JDMyViewController *myVC = [[JDMyViewController alloc] init];
    [self addOneChildVc:myVC title:@"我的" imageName:@"tabBar_myJD_normal" selectedImageName:@"tabBar_myJD_press"];
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
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    //添加导航控制器
    JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];

}

@end
