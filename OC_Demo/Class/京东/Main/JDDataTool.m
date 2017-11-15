//
//  JDDataTool.m
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "JDDataTool.h"

#import "JDClassGoodsItem.h"
#import "JDClassMianItem.h"
#import "JDRecommendItem.h"

#import "MJExtension.h"

@implementation JDDataTool

+ (NSArray *)CategoryTitleItem{
    NSArray *goodsItems = [JDClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
    return goodsItems;
}

+(NSArray *)MainItems{
    NSArray *mainItems = [JDClassMianItem mj_objectArrayWithFilename:@"ClassiftyGoods01.plist"];
    return mainItems;
}
+ (NSArray *)recommendItems{
    NSArray *mainItems = [JDRecommendItem mj_objectArrayWithFilename:@"ClasiftyGoods.plist"];
    return mainItems;
}
@end
