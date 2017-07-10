//
//  RightCell.h
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodModel;
@interface RightCell : UITableViewCell


/**
 每道菜的详情
 */
@property (nonatomic, strong) FoodModel *footModel;


@end
