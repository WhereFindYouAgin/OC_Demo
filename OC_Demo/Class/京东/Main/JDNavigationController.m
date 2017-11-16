//
//  JDNavigationController.m
//  OC_Demo
//
//  Created by sll on 2017/7/17.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "JDNavigationController.h"]

#import "GQGesVCTransition.h"

@interface JDNavigationController ()

@end

@implementation JDNavigationController

+ (void)load{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [GQGesVCTransition validateGesBackWithType:GQGesVCTransitionTypePanWithPercentRight withRequestFailToLoopScrollView:YES]; //手势返回;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
        //影藏BottomBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}
- (void)backClick{
    [self popViewControllerAnimated:YES];
}

@end
