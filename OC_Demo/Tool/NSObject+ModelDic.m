//
//  NSObject+ModelDic.m
//  OC_Demo
//
//  Created by sll on 2017/7/4.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "NSObject+ModelDic.h"
#import <objc/message.h>

@implementation NSObject (ModelDic)

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    id objc = [[self alloc] init];
    // 2.利用runtime给对象中的属性赋值
    /**
     class_copyIvarList: 获取类中的所有成员变量
     Ivar：成员变量
     第一个参数：表示获取哪个类中的成员变量
     第二个参数：表示这个类有多少成员变量，传入一个Int变量地址，会自动给这个变量赋值
     返回值Ivar *：指的是一个ivar数组，会把所有成员属性放在一个数组中，通过返回的数组就能全部获取到。
     count: 成员变量个数
     */
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i= 0; i< count; i++) {
        Ivar ivar = ivarList[i];
//        const char * name = ivar_getName(ivar);
//        const char * type = ivar_getTypeEncoding(ivar);
      //  NSLog(@"Person拥有的成员变量的类型为%s，名字为 %s ",type, name);
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 处理成员变量名->字典中的key(去掉 _ ,从第一个角标开始截取)
        NSString *key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名去字典中查找对应的value
        id value = dict[key];
        if (value) {
            [objc setValue:value forKey:key];
        }
        
    }
    
    return objc;
}


+ (instancetype)modelWithDict2:(NSDictionary *)dict
{
    // 1.创建对应的对象
    id objc = [[self alloc] init];
    
    // 2.利用runtime给对象中的属性赋值
    unsigned int count = 0;
    // 获取类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 遍历所有成员变量
    for (int i = 0; i < count; i++) {
        // 根据角标，从数组取出对应的成员变量
        Ivar ivar = ivarList[i];
        
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取成员变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 替换: @\"User\" -> User
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        // 处理成员属性名->字典中的key(去掉 _ ,从第一个角标开始截取)
        NSString *key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名去字典中查找对应的value
        id value = dict[key];
        
        //--------------------------- <#我是分割线#> ------------------------------//
        //
        // 二级转换:如果字典中还有字典，也需要把对应的字典转换成模型
        // 判断下value是否是字典,并且是自定义对象才需要转换
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            
            // 字典转换成模型 userDict => User模型, 转换成哪个模型
            // 根据字符串类名生成类对象
            Class modelClass = NSClassFromString(ivarType);
            
            if (modelClass) { // 有对应的模型才需要转
                // 把字典转模型
                value = [modelClass modelWithDict2:value];
            }
        }
        
        // 给模型中属性赋值
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

// Runtime:根据模型中属性,去字典中取出对应的value给模型属性赋值
// 思路：遍历模型中所有属性->使用运行时
+ (instancetype)modelWithDict3:(NSDictionary *)dict
{
    // 1.创建对应的对象
    id objc = [[self alloc] init];
   
    // 2.利用runtime给对象中的属性赋值
    
    unsigned int count = 0;
    // 获取类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    // 遍历所有成员变量
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 处理成员属性名->字典中的key(去掉 _ ,从第一个角标开始截取)
        NSString *key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名去字典中查找对应的value
        id value = dict[key];
        //--------------------------- <#我是分割线#> ------------------------------//
        //
        
        // 三级转换：NSArray中也是字典，把数组中的字典转换成模型.
        // 判断值是否是数组
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            // arrayContainModelClass 提供一个协议，只要遵守这个协议的类，都能把数组中的字典转模型
            if ([self respondsToSelector:@selector(arrayContainModelClass)]){
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                // 获取数组中字典对应的模型
                NSString *type =  [idSelf arrayContainModelClass][key];
                
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                 // 遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    id model = [classModel modelWithDict3:dict];
                    [arrM addObject:model];
                }
                value = arrM;
            }
        }
         // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil,而报错
        if (value) {
            // 给模型中属性赋值
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}

+(instancetype)modelWithDict4:(NSDictionary *)dict{
    // 1.创建对应的对象
    id objc = [[self alloc] init];
    
    // 2.利用runtime给对象中的属性赋值
    
    unsigned int count = 0;
    // 获取类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        // 根据角标，从数组取出对应的成员变量
        Ivar ivar = ivarList[i];
        
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取成员变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 替换: @\"User\" -> User
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        // 处理成员属性名->字典中的key(去掉 _ ,从第一个角标开始截取)
        NSString *key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名去字典中查找对应的value
        id value = dict[key];
        //--------------------------- <#我是分割线#> ------------------------------//
        //
        
        // 三级转换：NSArray中也是字典，把数组中的字典转换成模型.
        // 判断值是否是数组
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            // arrayContainModelClass 提供一个协议，只要遵守这个协议的类，都能把数组中的字典转模型
            if ([self respondsToSelector:@selector(arrayContainModelClass)]){
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                // 获取数组中字典对应的模型
                NSString *type =  [idSelf arrayContainModelClass][key];
                
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                // 遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    id model = [classModel modelWithDict3:dict];
                    [arrM addObject:model];
                }
                value = arrM;
            }
        }
        //--------------------------- <#我是分割线#> ------------------------------//
        //
        // 二级转换:如果字典中还有字典，也需要把对应的字典转换成模型
        // 判断下value是否是字典,并且是自定义对象才需要转换
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            
            // 字典转换成模型 userDict => User模型, 转换成哪个模型
            // 根据字符串类名生成类对象
            Class modelClass = NSClassFromString(ivarType);
            
            if (modelClass) { // 有对应的模型才需要转
                // 把字典转模型
                value = [modelClass modelWithDict2:value];
            }
        }

        // 给模型中属性赋值
        if (value) {
            [objc setValue:value forKey:key];
        }

    }
    
    return objc;
}


@end
