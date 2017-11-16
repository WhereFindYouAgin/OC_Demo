//
//  JDGoodsSetViewController.m
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "JDGoodsSetViewController.h"
#import "JDDataTool.h"
#import "UIBarButtonItem+Extension.h"

@interface JDGoodsSetViewController ()
@property (strong , nonatomic)NSArray *setItems;
@property (nonatomic, strong)  UIBarButtonItem *switchViewButton;

/* scrollerVew */
@property (strong , nonatomic)UICollectionView *collectionView;
/**
 0：列表视图，1：格子视图
 */
@property (nonatomic, assign) BOOL isSwitchGrid;
@end

@implementation JDGoodsSetViewController

- (NSArray*)setItems{
    if (!_setItems) {
        _setItems = [JDDataTool recommendItems];
    }
    return _setItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNav];
}

- (void)setUpNav{
    self.switchViewButton = [UIBarButtonItem initWithTarget:self action:@selector(switchViewButtonBarItemBtnClick) image:@"nav_btn_jiugongge" hightImage:@"" selectedImage:@"nav_btn_list"];
    self.navigationItem.rightBarButtonItem = self.switchViewButton;
}
- (void)switchViewButtonBarItemBtnClick
{
   UIButton *btn = (UIButton *)self.switchViewButton.customView;
    btn.selected = !btn.selected;
}

@end
