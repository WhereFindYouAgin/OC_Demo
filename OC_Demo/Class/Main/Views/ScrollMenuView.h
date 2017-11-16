//
//  ScrollMenuView.h
//  OC_Demo
//
//  Created by LUOSU on 2017/7/12.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollMenuView;
@protocol ScrollMenuViewDelegate <NSObject>

@optional

- (void)scrollMenuView:(ScrollMenuView *) scrollMenuView btnClickedIndex:(NSInteger)index;

@end



@interface ScrollMenuView : UIScrollView
@property (nonatomic, weak) id<ScrollMenuViewDelegate> menuViewdelegate;
/** 菜单标题数组 */
@property (nonatomic,strong) NSArray *titleArray;
/** 当前选择的按钮的index */
@property (nonatomic,assign) NSInteger currentButtonIndex;
@end
