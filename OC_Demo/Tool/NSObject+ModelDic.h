//
//  NSObject+ModelDic.h
//  OC_Demo
//
//  Created by sll on 2017/7/4.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

@optional

+ (NSDictionary *)arrayContainModelClass;

@end

@interface NSObject (ModelDic)

+ (instancetype)modelWithDict:(NSDictionary *)dict;

+ (instancetype)modelWithDict2:(NSDictionary *)dict;

+ (instancetype)modelWithDict3:(NSDictionary *)dict;
+ (instancetype)modelWithDict4:(NSDictionary *)dict;


@end
