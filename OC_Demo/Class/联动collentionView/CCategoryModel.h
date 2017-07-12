//
//  CCategoryModel.h
//  OC_Demo
//
//  Created by sll on 2017/7/12.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Linkage.h"

@interface CCategoryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *subcategories;


@end

@interface SubcategoryModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end
