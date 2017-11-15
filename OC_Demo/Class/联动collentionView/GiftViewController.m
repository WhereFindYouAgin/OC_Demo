//
//  GiftViewController.m
//  OC_Demo
//
//  Created by sll on 2017/7/10.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "GiftViewController.h"
#import "Linkage.h"
#import "LeftCell.h"
#import "GiftCell.h"
#import "GiftCollectionHeaderView.h"
#import "GiftFlowLayout.h"
#import "CCategoryModel.h"

@interface GiftViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;




@property (nonatomic, strong) GiftFlowLayout *flowLayout;




@end

static CGFloat const kLeftTableViewWidth = 80.0;
static CGFloat const kCollectionViewMargin = 3.0;

static NSString *const collentionViewIdentifier = @"CDIdentifier";
static NSString *const collentionHeaderIdentifier = @"GiftCollectionHeaderView";
static NSString *const collentionFootIdentifier = @"GiftCollectionFooterView";

@implementation GiftViewController

#pragma mark -- Getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}

- (GiftFlowLayout *)flowLayout
{

    if (_flowLayout == nil) {
        _flowLayout = [[GiftFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 2;

    }
    return _flowLayout;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView  alloc] initWithFrame:CGRectMake(kCollectionViewMargin + kLeftTableViewWidth, kCollectionViewMargin, SCREEN_WIDTH - kLeftTableViewWidth - 2 * kCollectionViewMargin, SCREEN_HEIGHT - 2 * kCollectionViewMargin) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        //注册Item
        [_collectionView registerClass:[GiftCell class] forCellWithReuseIdentifier:collentionViewIdentifier];
        //注册headerView
        [_collectionView registerClass:[GiftCollectionHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:collentionHeaderIdentifier];
    }
    return _collectionView;
}

- (NSMutableArray *)collectionDatas
{
    if (_collectionDatas == nil) {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark -- Life Style
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex = 0;
    _isScrollDown = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    for (NSDictionary *dic in categories) {
        CCategoryModel *model = [CCategoryModel objectWithDictionary4:dic];
        [self.dataSource addObject:model];
        NSMutableArray *subArr = [NSMutableArray array];
        for (SubcategoryModel *subModel in model.subcategories) {
            [subArr addObject:subModel];
        }
        [self.collectionDatas addObject:subArr];
    }
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
    [self selectRowAtIndexPath:0];
}

/*********************************** tableView***********************************/
#pragma mark --UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const ID = @"cID";
    
        LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[LeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        CCategoryModel *model = self.dataSource[indexPath.row];
        cell.name = model.name;
        return cell;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    [self scrollToTopOfSection:indexPath.row animated:YES];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}



#pragma mark - 解决点击 TableView 后 CollectionView 的 Header 遮挡问题
- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated{
    CGRect headerRect = [self frameForHeaderForSection:section];
    CGPoint  topOfHeader = CGPointMake(0, headerRect.origin.y - self.collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:YES];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    UICollectionViewLayoutAttributes *attributs = [self.collectionView.collectionViewLayout  layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributs.frame;
}

/*********************************** CollectionView ***********************************/
#pragma mark -- UICollectionViewDelegate and DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray * subArr = self.collectionDatas[section];
    return subArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collentionViewIdentifier forIndexPath:indexPath];
    NSArray * subArr = self.collectionDatas[indexPath.section];
    cell.model = subArr[indexPath.row];
    return cell;
}

//设置每个Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((SCREEN_WIDTH - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3,
                      (SCREEN_WIDTH - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3 + 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{

    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collentionFootIdentifier forIndexPath:indexPath];
        return footer;
    }else{
        GiftCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:collentionHeaderIdentifier
                                                                                   forIndexPath:indexPath];
        
        CCategoryModel *model = self.dataSource[indexPath.section];
        view.giftHeaderName = model.name;
        return view;
    }

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

//分区即将展现
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

//分区消失
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }

}

-(void)selectRowAtIndexPath:(NSInteger)indexPath{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark -- UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffsetY = 0;
    if (self.collectionView == scrollView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
