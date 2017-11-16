//
//  CommodityViewController.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "CommodityViewController.h"

#import "ShopTableViewController.h"
#import "GiftViewController.h"


@interface CommodityViewController ()

@end

@implementation CommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ConlltionViewBtnClick:(id)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GiftViewController  *gift = [storyBoard instantiateViewControllerWithIdentifier:@"gift"];
    [self.navigationController pushViewController:gift animated:YES];
}

- (IBAction)tableVIewBtnClink:(UIButton *)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShopTableViewController  *table = [storyBoard instantiateViewControllerWithIdentifier:@"shop"];
    [self.navigationController pushViewController:table animated:YES];
    
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
