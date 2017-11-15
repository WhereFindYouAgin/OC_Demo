//
//  JDClassCategoryCell.m
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "JDClassCategoryCell.h"

#import "JDClassGoodsItem.h"
#import "JDMoblie.h"
#import "UIView+Extension.h"

@interface JDClassCategoryCell ()
/* 标题 */
@property (strong , nonatomic)UILabel *titleItemLabel;
/* 指示View */
@property (strong , nonatomic)UIView *indicatorView;

@end

@implementation JDClassCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setUpUI{
    self.titleItemLabel = [[UILabel alloc] init];
        self.titleItemLabel.font = JD15Font;
    self.titleItemLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleItemLabel];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.hidden = NO;
    _indicatorView.backgroundColor = [UIColor redColor];
    [self addSubview:_indicatorView];
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellHeight = self.contentView.height;
    self.titleItemLabel.frame = CGRectMake(5, 0, self.contentView.width -5, cellHeight);
    self.indicatorView.frame = CGRectMake(0, 0, 5,cellHeight );
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.indicatorView.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.titleItemLabel.textColor = [UIColor redColor];
    }else{
        self.indicatorView.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        self.titleItemLabel.textColor = [UIColor blackColor];
    }
}

- (void)setTitleItem:(JDClassGoodsItem *)titleItem{
    _titleItem = titleItem;
    self.titleItemLabel.text = titleItem.title;
}

@end
