//
//  JDCalssSubItem.h
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDCalssSubItem : NSObject
/** 商品类题  */
@property (nonatomic, copy ,readonly) NSString *goods_title;

/** 商品图片  */
@property (nonatomic, copy ,readonly) NSString *image_url;
@end
