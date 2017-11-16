//
//  Movie.h
//  OC_Demo
//
//  Created by sll on 2017/7/4.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>
// Movie.h文件
//1. 如果想要当前类可以实现归档与反归档，需要遵守一个协议NSCoding
@interface Movie : NSObject<NSCoding>

@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, copy) NSString *pic_url;

@end
