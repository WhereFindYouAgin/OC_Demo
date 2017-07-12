//
//  RightCell.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "RightCell.h"

#import "Linkage.h"
#import "CategoryModel.h"

@interface RightCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;



@end

@implementation RightCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
    [self.contentView addSubview:self.imageV];
    
    self.titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
    self.titleNameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleNameLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 200, 30)];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];

}


- (void)setFootModel:(FoodModel *)footModel
{
    _footModel = footModel;
    self.titleNameLabel.text = footModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",@(footModel.min_price)];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:footModel.picture]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
