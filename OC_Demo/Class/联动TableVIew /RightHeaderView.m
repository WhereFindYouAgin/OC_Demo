//
//  RightHeaderView.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "RightHeaderView.h"
#import "Linkage.h"

@interface RightHeaderView ()
@property (nonatomic, strong) UILabel *nameLabel;


@end

@implementation RightHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
         self.backgroundColor = rgba(240, 240, 240, 0.8);
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.nameLabel];
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.nameLabel.text = name;

}
@end
