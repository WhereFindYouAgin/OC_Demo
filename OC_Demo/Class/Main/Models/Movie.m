//
//  Movie.m
//  OC_Demo
//
//  Created by sll on 2017/7/4.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "Movie.h"
#import <objc/runtime.h>
#define encodeRuntime(A) \
\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [self valueForKey:key];\
[encoder encodeObject:value forKey:key];\
}\
free(ivars);\
\

#define initCoderRuntime(A) \
\
if (self = [super init]) {\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [decoder decodeObjectForKey:key];\
[self setValue:value forKey:key];\
}\
free(ivars);\
}\
return self;\
\


@implementation Movie


/*
 - (void)encodeWithCoder:(NSCoder *)aCoder
 {
 [aCoder encodeObject:_movieId forKey:@"id"];
 [aCoder encodeObject:_movieName forKey:@"name"];
 [aCoder encodeObject:_pic_url forKey:@"url"];
 
 }
 
 - (id)initWithCoder:(NSCoder *)aDecoder
 {
 if (self = [super init]) {
 self.movieId = [aDecoder decodeObjectForKey:@"id"];
 self.movieName = [aDecoder decodeObjectForKey:@"name"];
 self.pic_url = [aDecoder decodeObjectForKey:@"url"];
 }
 return self;
 }
 */
/*
- (void)encodeWithCoder:(NSCoder *)encoder
{

    unsigned int count = 0;
    Ivar *ivars= class_copyIvarList([Movie class], &count);
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Movie class], &count);
        for (int i= 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
         
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}
*/

- (void)encodeWithCoder:(NSCoder *)encoder{
    encodeRuntime(Movie);
}

- (id)initWithCoder:(NSCoder *)decoder{
     initCoderRuntime(Movie);
}

@end
