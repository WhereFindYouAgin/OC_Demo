//
//  JDGoodsSetViewController.m
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "JDGoodsSetViewController.h"
#import "JDDataTool.h"

@interface JDGoodsSetViewController ()
@property (strong , nonatomic)NSArray *setItem;

@end

@implementation JDGoodsSetViewController

- (NSArray*)setItem{
    if (!_setItem) {
        _setItem = [JDDataTool recommendItems];
    }
    return _setItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}



@end
