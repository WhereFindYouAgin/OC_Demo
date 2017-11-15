//
//  JDClassMianItem.h
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDCalssSubItem;
@interface JDClassMianItem : NSObject
/** 文标题  */
@property (nonatomic, copy ,readonly) NSString *title;


/** goods  */
@property (nonatomic, copy ,readonly) NSArray<JDCalssSubItem *> *goods;

@end
