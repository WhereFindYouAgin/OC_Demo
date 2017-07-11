//
//  GiftCollectionHeaderView.m
//  OC_Demo
//
//  Created by LUOSU on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "GiftCollectionHeaderView.h"
#import "Linkage.h"


@interface GiftCollectionHeaderView ()

@property (nonatomic, strong) UILabel *headerNameL;


@end

@implementation GiftCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = rgba(240, 240, 240, 0.8);
        self.headerNameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH - 80, 20)];
        self.headerNameL.font = [UIFont systemFontOfSize:14];
        self.headerNameL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.headerNameL];
  
    }
    return self;
}


- (void)setGiftHeaderName:(NSString *)giftHeaderName{
    _giftHeaderName = giftHeaderName;
    self.headerNameL.text = giftHeaderName;
}

@end
