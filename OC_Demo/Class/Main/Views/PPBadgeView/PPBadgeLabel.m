//
//  PPBadgeLabel.m
//  OC_Demo
//
//  Created by sll on 2017/7/3.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "PPBadgeLabel.h"
#import "UIView+PPBadgeView.h"

@implementation PPBadgeLabel


+ (instancetype)defaultBadgeLabel{

    return [[PPBadgeLabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:13];
    self.textAlignment = NSTextAlignmentCenter;
    self.layer.cornerRadius = self.p_height * 0.5;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = [UIColor colorWithRed:1.00 green:0.17 blue:0.15 alpha:1.00];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    // 根据内容调整label的宽度
    CGFloat stringWidth = [self widthForString:text font:self.font height:self.p_height];
    if (self.p_height > stringWidth + self.p_height*10/18) {
        self.p_width = self.p_height;
        return;
    }
    self.p_width = self.p_height*5/18/*left*/ + stringWidth + self.p_height*5/18/*right*/;
}


/**
 根据字符串 字体高度 得到宽度

 @param string 字符穿
 @param font 字体
 @param height 高度
 @return 计算的宽度
 */
- (CGFloat)widthForString:(NSString *)string font:(UIFont *)font height:(CGFloat)height{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}


@end
