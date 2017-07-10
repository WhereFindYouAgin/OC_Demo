//
//  NSObject+Property2.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "NSObject+Property2.h"
#import <objc/runtime.h>

@implementation NSObject (Property2)

+ (instancetype)objectWithDictionary4:(NSDictionary *)dictionary{

    id obj = [[self alloc] init];
    
    unsigned int count = 0;
    
    Ivar *ivarList = class_copyIvarList(self, &count);
    // 取出的成员变量，去掉下划线
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [ivarName substringFromIndex:1];
        id value = dictionary[key];
        
        if (!value) {
            if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
                NSString *replaceKey = [self replacedKeyFromPropertyName][key];
                value = dictionary[replaceKey];
            }
        }
        
         // 字典嵌套字典
        if ([value isKindOfClass:[NSDictionary class]])
        {
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            NSRange range = [type rangeOfString:@"\""];
            type = [type substringFromIndex:range.location + range.length];
            range = [type rangeOfString:@"\""];
            type = [type substringToIndex:range.location];
            Class modelClass = NSClassFromString(type);
            
            if (modelClass)
            {
                value = [modelClass objectWithDictionary4:value];
            }
        }
        if ([value isKindOfClass:[NSArray class] ]) {
            if ([self respondsToSelector:@selector(objectClassInArray)]) {
                NSMutableArray *models = [NSMutableArray array];
                
                NSString *type = [self objectClassInArray][key];
                Class classModel = NSClassFromString(type);
                for (NSDictionary *dict in value)
                {
                    id model = [classModel objectWithDictionary4:dict];
                    [models addObject:model];
                }
                value = models;
            }
        }
        if (value)
        {
            [obj setValue:value forKey:key];
        }
        
    }
    

    return obj;
}

@end
