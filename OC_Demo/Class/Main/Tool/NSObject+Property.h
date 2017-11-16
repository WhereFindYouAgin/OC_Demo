//
//  NSObject+Property.h
//  OC_Demo
//
//  Created by sll on 2017/7/4.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)

// @property分类:只会生成get,set方法声明,不会生成实现,也不会生成下划线成员属性
@property NSString *name;
@property NSString *height;

@end
