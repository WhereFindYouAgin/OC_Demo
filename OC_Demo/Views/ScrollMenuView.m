//
//  ScrollMenuView.m
//  OC_Demo
//
//  Created by LUOSU on 2017/7/12.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "ScrollMenuView.h"
#import "UIView+Extension.h"

@interface ScrollMenuView (){
    /** 用于记录最后创建的控件 */
    UIView *_lastView;
    /** 按钮下面的横线 */
    UIView *_lineView;
}

@end

@implementation ScrollMenuView


-(instancetype )initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        _currentButtonIndex = 0;
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;

    // 先将所有子控件移除

    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    //将lastView置空
    _lastView = nil;
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *menuBtn = [[UIButton alloc] init];
        [self addSubview:menuBtn];
        if (_lastView) {
            menuBtn.frame = CGRectMake(_lastView.maxX + 10, 0, 100, self.height);
        }else{
            menuBtn.frame = CGRectMake(0, 0, 100, self.height);
        }
        menuBtn.tag = 100 + idx;
        [menuBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [menuBtn setTitle:obj forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        // 宽度自适应
        [menuBtn sizeToFit];
        menuBtn.height = self.height;
        
        // 这句不能少，不然初始化时button的label的宽度为0
        [menuBtn layoutIfNeeded];
        
        // 默认第一个按钮时选中状态
        if (idx == 0) {
            menuBtn.selected = YES;
            _lineView = [[UIView alloc] init];
            [self addSubview:_lineView];
            _lineView.bounds = CGRectMake(0, 0, menuBtn.titleLabel.width, 2);
            _lineView.center = CGPointMake(menuBtn.centerX, self.height - 1);
            _lineView.backgroundColor = [UIColor redColor];
        }
        _lastView = menuBtn;
    }];
    
    self.contentSize = CGSizeMake(CGRectGetMaxX(_lastView.frame), CGRectGetHeight(self.frame));
    // 如果内容总宽度不超过本身，平分各个模块
    if (_lastView.maxX < self.width ) {
        int i = 0;
        for (UIButton *button in self.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                button.width = self.width / self.titleArray.count;
                button.x = i * button.width;
                button.titleLabel.adjustsFontSizeToFitWidth= YES;// 开启，防极端情况
                [self addSubview:_lineView];
                if (i == 0) {
                    _lineView.bounds = CGRectMake(0, 0, button.titleLabel.width, 2);
                    _lineView.center = CGPointMake(button.centerX, self.height - 1);
                    _lineView.backgroundColor = [UIColor redColor];
                }
                i ++;
            }
        }
    }
}





- (void)menuButtonClicked:(UIButton *)sender
{
    // 改变按钮的选中状态
    for (UIButton *button in self.subviews) {
        if ([button isMemberOfClass:[UIButton class]]) {
            button.selected = NO;
        }
    }
    sender.selected = YES;
    
    // 将所点击的button移到中间
    [self removeBtnAndLineView:sender];
    
    // 代理方执行方法
    if ([self.menuViewdelegate respondsToSelector:@selector(scrollMenuView:btnClickedIndex:)]) {
        [self.menuViewdelegate scrollMenuView:self btnClickedIndex:sender.tag - 100];
    }
}


/** 赋值当前选择的按钮 */
- (void)setCurrentButtonIndex:(NSInteger)currentButtonIndex{
    _currentButtonIndex = currentButtonIndex;
    
    // 改变按钮的选中状态
    UIButton *currentButton = [self viewWithTag:(100 + currentButtonIndex)];
    for (UIButton *button in self.subviews) {
        if ([button isMemberOfClass:[UIButton class]]) {
            button.selected = NO;
        }
    }
    currentButton.selected = YES;
    
    // 将所点击的button移到中间
    [self removeBtnAndLineView:currentButton];

}

#pragma mark - 移动Button和uiView
- (void)removeBtnAndLineView:(UIButton *)sender{
    if (_lastView.maxX > self.width) {
        if (sender.x >= self.width / 2 && sender.centerX <= self.contentSize.width - self.width/2) {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(sender.centerX - self.width / 2, 0);
            }];
        }else if (sender.frame.origin.x < self.width / 2){
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(0, 0);
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(self.contentSize.width - self.width, 0);
            }];
        }
    }
    
    // 改变下横线的位置和宽度
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.width = sender.titleLabel.width;
        _lineView.centerX = sender.centerX;
    }];
}
@end
