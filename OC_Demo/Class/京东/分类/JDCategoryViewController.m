//
//  JDCategoryViewController.m
//  OC_Demo
//
//  Created by sll on 2017/7/17.
//  Copyright © 2017年 LUOSU. All rights reserved.
//
#define tableViewH  100

#import "JDCategoryViewController.h"

#import "JDClassGoodsItem.h"
#import "JDClassMianItem.h"
#import "JDCalssSubItem.h"
#import "JDDataTool.h"
#import "JDClassCategoryCell.h"
#import "GiftCollectionHeaderView.h"
#import "JDClassSubItemCell.h"
#import "GiftFlowLayout.h"
#import "JDConst.h"
#import "JDMoblie.h"
#import "JDGoodsSetViewController.h"

@interface JDCategoryViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>{
    
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

/* 左边数据 */
@property (strong , nonatomic)NSMutableArray *titleItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray *mainItem;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* collectionView flowLayout*/
@property (nonatomic, strong) GiftFlowLayout *flowLayout;
@end
static CGFloat const kCollectionViewMargin = 3.0;

static  NSString *const collentionSubItemCellIdentifier = @"collentionViewIdentifier";
static  NSString *const rightHeaderIdentifier = @"rightHeaderIdentifier";
static  NSString *const rightCFootIdentifier = @"rightCFootIdentifier";
static  NSString *const rightCHeaderIdentifier = @"rightCHeaderIdentifier";
@implementation JDCategoryViewController

#pragma mark -- lazy load
- (NSMutableArray*)titleItem{
    if (!_titleItem) {
        _titleItem = [NSMutableArray arrayWithArray:[JDDataTool CategoryTitleItem]];
    }
    return _titleItem;
}

- (NSMutableArray *)mainItem{
    if (!_mainItem) {
        _mainItem = [NSMutableArray arrayWithArray:[JDDataTool MainItems]];
    }
    return _mainItem;
    
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, DCTopNavH, tableViewH, ScreenH - DCTopNavH);
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;

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
        _collectionView = [[UICollectionView  alloc] initWithFrame:CGRectMake(tableViewH, DCTopNavH, ScreenW - tableViewH, ScreenH - DCTopNavH) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        //注册Item
        [_collectionView registerClass:[JDClassSubItemCell class] forCellWithReuseIdentifier:collentionSubItemCellIdentifier];
        //注册headerView
        [_collectionView registerClass:[GiftCollectionHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:rightCHeaderIdentifier];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _selectIndex = 0;
    _isScrollDown = YES;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];

    [self selectRowAtIndexPath:0];

}

#pragma mark - - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *titleItemID = @"titleItemID";
    JDClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:titleItemID];
    if (!cell) {
        cell.backgroundColor = [UIColor grayColor];
        cell = [[JDClassCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleItemID];
    }
    JDClassGoodsItem *item = [self.titleItem objectAtIndex:indexPath.row];
    cell.titleItem = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    [self scrollToTopOfSection:indexPath.row animated:YES];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//
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

#pragma mark -- UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.mainItem.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    JDClassMianItem *mainItem = self.mainItem[section];
    
    return mainItem.goods.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JDClassSubItemCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:collentionSubItemCellIdentifier forIndexPath:indexPath];
    JDClassMianItem *mainItem = self.mainItem[indexPath.section];
    cell.subItem = mainItem.goods[indexPath.row];
    return cell;
}
//设置每个Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((ScreenW - 100 - 4 * kCollectionViewMargin) / 3,
                      (ScreenW - 100 - 4 * kCollectionViewMargin) / 3 + 30);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenW, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JDGoodsSetViewController *jdSetViewController = [[JDGoodsSetViewController alloc] init];
    [self.navigationController pushViewController:jdSetViewController animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:rightCFootIdentifier forIndexPath:indexPath];
        return footer;
    }else{
        GiftCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:rightCHeaderIdentifier
                                                                                   forIndexPath:indexPath];
        
        JDClassMianItem *model = self.mainItem[indexPath.section];
        view.giftHeaderName = model.title;
        return view;
    }
    
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
#pragma mark - - ScrollVIew Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffsetY = 0;
    if (self.collectionView == scrollView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

-(void)selectRowAtIndexPath:(NSInteger)indexPath{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}


@end
