//
//  user.h
//  OC_Demo
//
//  Created by sll on 2017/7/4.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface user : NSObject

@property (nonatomic, strong) NSNumber *mbrank;
@property (nonatomic, strong) NSNumber *mbtype;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *proflie_image_url;
@property (nonatomic, assign) Boolean vip;




@end
