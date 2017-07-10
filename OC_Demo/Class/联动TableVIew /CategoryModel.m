//
//  CategoryModel.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "CategoryModel.h"
#import "Linkage.h"

@implementation CategoryModel

+ (NSDictionary *)objectClassInArray{

    return @{@"spus":@"FoodModel"};
}


@end
@implementation FoodModel

+(NSDictionary *)replacedKeyFromPropertyName{

    return @{@"foodId":@"id"};
}

@end
