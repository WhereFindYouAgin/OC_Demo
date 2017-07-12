//
//  ShopCarCell.m
//  OC_Demo
//
//  Created by sll on 2017/7/12.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "ShopCarCell.h"

@implementation ShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setUp];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

#pragma 初始化子控件
- (void)setUp{

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ShopCarCell:didSlectButtn:indePath:)]) {
        [self.delegate ShopCarCell:self didSlectButtn:sender indePath:self.carIndexPath];
    }
}

@end
