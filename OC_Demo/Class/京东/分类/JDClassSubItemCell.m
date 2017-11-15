//
//  JDClassSubItemCell.m
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "JDClassSubItemCell.h"

#import "JDCalssSubItem.h"

#import "UIImageView+WebCache.h"

@interface JDClassSubItemCell()

/** 图片 */
@property (nonatomic, strong) UIImageView *imageV;

/** 标题 */
@property (nonatomic, strong) UILabel *titleL;

@end

@implementation JDClassSubItemCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}
- (void)setUp{
    CGFloat widthSubView = self.frame.size.width - 4;
    UIImageView *cellImageV = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, widthSubView, self.frame.size.width - 4)];
    cellImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:cellImageV];
    self.imageV = cellImageV;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, self.bounds.size.width + 2, widthSubView, 20)];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    self.titleL = label;
}
- (void)setSubItem:(JDCalssSubItem *)subItem{
    _subItem = subItem;
    self.titleL.text = subItem.goods_title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:subItem.image_url]];
}

@end
