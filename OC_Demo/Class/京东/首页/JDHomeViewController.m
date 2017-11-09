//
//  JDHomeViewController.m
//  OC_Demo
//
//  Created by sll on 2017/7/17.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "JDHomeViewController.h"
#import "UIView+Extension.h"
#import "SDCycleScrollView.h"

@interface JDHomeViewController ()< UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>{
    
    UITableView *_tableView;
    
    SDCycleScrollView *_cycleScrollView;

}

@end

@implementation JDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height+64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self addHeaderView];
    
    
}

- (UIView *)addHeaderView{

    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    NSArray *imagesURLStrings = @[
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1402/221/421883372/88115/8cc2231a/55815835N35a44559.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t976/208/1221678737/91179/5d7143d5/5588e849Na2c20c1a.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t805/241/1199341035/289354/8648fe55/5581211eN7a2ebb8a.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1606/199/444346922/48930/355f9ef/55841cd0N92d9fa7c.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1609/58/409100493/49144/7055bec5/557e76bfNc065aeaf.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t895/234/1192509025/111466/512174ab/557fed56N3e023b70.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t835/313/1196724882/359493/b53c7b70/5581392cNa08ff0a9.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t898/15/1262262696/95281/57d1f12f/558baeb4Nbfd44d3a.jpg"
                                  ];
    
    // 网络加载 --- 创建不带标题的图片轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 180) imageURLStringsGroup:nil];
    
    _cycleScrollView.infiniteLoop = YES;
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage=[UIImage imageNamed:@"homepagebannerplaceholder"];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.autoScrollTimeInterval = 2.0; // 轮播时间间隔，默认1.0秒，可自定义
    
    
    //模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });
    
    [header addSubview:_cycleScrollView];
    
    
    return header;

}


#pragma mark -- UItableVIewDalegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *const cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
    }
    return cell;
}


#pragma mark -- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}

- (void)indexOnPageControl:(NSInteger)index{
   // NSLog(@"%ld", index);
}


@end
