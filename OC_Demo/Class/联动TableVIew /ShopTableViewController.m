//
//  ShopTableViewController.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//



#import "ShopTableViewController.h"

#import "Linkage.h"
#import "LeftCell.h"
#import "RightCell.h"
#import "RightHeaderView.h"
#import "CategoryModel.h"




@interface ShopTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _selectIndex;
    BOOL _isScrollDown;

}
@property (nonatomic, strong) NSMutableArray *categoryData;

@property (nonatomic, strong) NSMutableArray *foodData;



/**
 左边的分类
 */
@property (nonatomic, strong) UITableView *leftTableView;

/**
 右边的商品
 */
@property (nonatomic, strong) UITableView *rightTableView;



@end

static CGFloat const kLeftTableViewWidth = 80.0;

@implementation ShopTableViewController

#pragma mark -- 懒加载
#pragma mark - Getters

- (NSMutableArray *)categoryData
{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData
{
    if (!_foodData)
    {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}

- (UITableView *)leftTableView
{
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.bounces = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        
        
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if (_rightTableView == nil) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
       
        
    }
    return _rightTableView;
}




#pragma mark -- Life Style
- (void)viewDidLoad {
    [super viewDidLoad];
    _isScrollDown = YES;
    _selectIndex = 0;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"meituan.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //讲dataJson转成Dic
    
    NSDictionary *meiTuanDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *foods = meiTuanDic[@"data"][@"food_spu_tags"];
    for (NSDictionary *dict in foods)
    {
      CategoryModel *model = [CategoryModel objectWithDictionary4:dict];
        [self.categoryData addObject:model];
        NSMutableArray *datas = [NSMutableArray array];
        for (FoodModel *f_model in model.spus)
        {
            [datas addObject:f_model];

        }
        //讲菜单 分批装进一个大的array
        [self.foodData addObject:datas];
    }

    
    
    
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark -- UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_rightTableView == tableView) {
        return self.categoryData.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_leftTableView == tableView) {
        return self.categoryData.count;
    }
    return [self.foodData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const LeftIdentifier = @"LeftID";
    NSString *const rightIdentifier = @"rightID";
    
    if (_leftTableView == tableView) {
        LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftIdentifier];
        if (!cell) {
            cell = [[LeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LeftIdentifier];
        }
        CategoryModel *model = self.categoryData[indexPath.row];
        cell.name = model.name;
        return cell;

    }else{
        RightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIdentifier];
        if (!cell) {
            cell = [[RightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightIdentifier];
        }
        FoodModel *model = self.foodData[indexPath.section][indexPath.row];
        cell.footModel = model;
        return cell;
        
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (_rightTableView == tableView) {
        return 20;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (_rightTableView == tableView) {
        RightHeaderView *headerView = [[RightHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        FoodModel *model = self.categoryData[section];
        headerView.name = model.name;
        return headerView;
    }
    return nil;
}

//HeaderView即将展示
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (_rightTableView == tableView && !_isScrollDown && (_rightTableView.dragging || _rightTableView.decelerating)) {
        [self selectIndecPathrow:section];
    }

}
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    if (_rightTableView == tableView && _isScrollDown && (_rightTableView.dragging || _rightTableView.decelerating)) {
        [self selectIndecPathrow:section + 1];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView) {
        _selectIndex = indexPath.row;
        [self scrollToTopOfSection:_selectIndex animated:YES];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }

}

//右边的tableVIew滚动到相应的section
- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    CGRect headerRect = [self.rightTableView rectForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _rightTableView.contentInset.top);
    [_rightTableView setContentOffset:topOfHeader animated:YES] ;
}

//左边的tableView滚动到相应的row

- (void)selectIndecPathrow:(NSInteger )row
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}
#pragma mark -- UISrcollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
       lastOffsetY = scrollView.contentOffset.y;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
