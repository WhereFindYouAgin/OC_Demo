//
//  GiftCell.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "GiftCell.h"
#import "Linkage.h"
#import "CCategoryModel.h"

@interface GiftCell()
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleL;


@end

@implementation GiftCell

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

- (void)setModel:(SubcategoryModel *)model{
    _model = model;
    self.titleL.text = model.name;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];

}

- (void)setCName:(NSString *)cName{

    _cName = cName;
    self.titleL.text = cName;
    
}

@end
