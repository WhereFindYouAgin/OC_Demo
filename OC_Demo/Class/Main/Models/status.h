//
//  status.h
//  OC_Demo
//
//  Created by sll on 2017/7/4.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "user.h"
#import "NSObject+ModelDic.h"

@interface status : NSObject<ModelDelegate>

@property (nonatomic, strong) NSNumber *attitudes_count;
@property (nonatomic, strong) NSNumber *comments_count;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, strong) NSArray *pic_urls;
@property (nonatomic, strong) NSNumber *reposts_count;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) user *user;






@end
