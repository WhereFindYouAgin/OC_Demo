//
//  NSObject+Property2.h
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeyValue <NSObject>

@optional
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)objectClassInArray;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)replacedKeyFromPropertyName;

@end

@interface NSObject (Property2)<KeyValue>

+ (instancetype)objectWithDictionary4:(NSDictionary *)dictionary;

@end
