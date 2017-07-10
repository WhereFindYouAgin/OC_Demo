//
//  LeftCell.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//
#define defaultColor rgba(253, 212, 49, 1)

#import "LeftCell.h"

#import "Linkage.h"

@interface LeftCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *yellowView;


@end

@implementation LeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
    }

    return self;
}

#pragma mark -- 初始化
- (void)setUp{
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = rgba(130, 130, 130, 1);
    self.nameLabel.highlightedTextColor = defaultColor;
    [self.contentView addSubview:self.nameLabel];
    
    self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 45)];
    self.yellowView.backgroundColor = defaultColor;
    [self.contentView addSubview:self.yellowView];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.nameLabel.highlighted = selected;
    self.yellowView.hidden = !selected;
}

#pragma mark -- Seter
- (void)setName:(NSString *)name{
    _name = name;
    self.nameLabel.text = name;
}

@end
