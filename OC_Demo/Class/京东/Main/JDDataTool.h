//
//  JDDataTool.h
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDClassGoodsItem;

@interface JDDataTool : NSObject

/**
 分类左边的Item
 */
+ (NSArray*)CategoryTitleItem;
/**
 分类右边边的Item
 */
+ (NSArray *)MainItems;

/**
 分类右边边的Item
 */
+ (NSArray *)recommendItems;
@end
