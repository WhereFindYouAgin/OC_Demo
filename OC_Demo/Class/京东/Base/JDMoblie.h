//
//  JDMoblie.h
//  OC_Demo
//
//  Created by sll on 2017/7/18.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#ifndef JDMoblie_h
#define JDMoblie_h

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"
//导航栏标题字体大小
#define JDNavigationFont [UIFont boldSystemFontOfSize:16]
#define JD15Font [UIFont fontWithName:PFR size:15];


//公用颜色
#define JDCommonColor [UIColor colorWithRed:0.478 green:0.478 blue:0.478 alpha:1]

//日志输出
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#endif /* JDMoblie_h */
