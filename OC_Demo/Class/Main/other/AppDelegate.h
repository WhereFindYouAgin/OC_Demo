//
//  AppDelegate.h
//  OC_Demo
//
//  Created by LUOSU on 2017/7/2.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

