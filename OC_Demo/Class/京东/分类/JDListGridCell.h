//
//  JDListGridCell.h
//  OC_Demo
//
//  Created by work on 2017/11/16.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDRecommendItem;

@interface JDListGridCell : UICollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)JDRecommendItem *youSelectItem;
/** 冒号点击回调 */
@property (nonatomic, copy) dispatch_block_t colonClickBlock;

@end
