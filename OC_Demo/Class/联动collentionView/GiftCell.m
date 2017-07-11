//
//  GiftCell.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "GiftCell.h"
@interface GiftCell()
@property (nonatomic, strong) UILabel *titleL;


@end

@implementation GiftCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [self setUp];
    }
    return self;
}
- (void)setUp{

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2)];
    [self.contentView addSubview:label];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    _titleL = label;
    

}

- (void)setCName:(NSString *)cName{

    _cName = cName;
    self.titleL.text = cName;
    
}

@end
