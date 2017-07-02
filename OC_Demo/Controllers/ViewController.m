//
//  ViewController.m
//  OC_Demo
//
//  Created by LUOSU on 2017/7/2.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

#import "ViewController.h"
#import "ESPicPageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *images = @[@"image_0", @"image_1", @"image_2", @"image_3", @"image_4"];
    ESPicPageView *eSPicPageView = [[ESPicPageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH / 2)];
    eSPicPageView.images = images;
    [self.view addSubview:eSPicPageView];
    self.navigationController.tabBarItem.title = @"主页";
    self.navigationController.tabBarItem.badgeValue = @"12";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
