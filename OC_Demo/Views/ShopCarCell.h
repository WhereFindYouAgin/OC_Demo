//
//  ShopCarCell.h
//  OC_Demo
//
//  Created by sll on 2017/7/12.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopCarCell;

@protocol ShopCarCellDelegate <NSObject>

@optional

- (void)ShopCarCell:(ShopCarCell *)cell didSlectButtn:(UIButton *)btn indePath:(NSIndexPath *)indexPath;

@end

@interface ShopCarCell : UITableViewCell


@property (nonatomic, strong) NSIndexPath* carIndexPath;

@property (nonatomic, weak) id<ShopCarCellDelegate> delegate;


@end
