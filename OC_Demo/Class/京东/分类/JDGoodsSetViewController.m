//
//  JDGoodsSetViewController.m
//  OC_Demo
//
//  Created by work on 2017/11/15.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#import "JDGoodsSetViewController.h"
#import "JDDataTool.h"
#import "UIBarButtonItem+Extension.h"
#import "JDHoverFlowLayout.h"
#import "JDMoblie.h"
#import "JDSquareCell.h"
#import "JDListGridCell.h"
#import "JDCustionHeadView.h"
#import "JDRecommendItem.h"

static NSString *const JDCustionHeadViewID = @"DCCustionHeadView";
static NSString *const JDSquareGridCellID = @"DCSwitchGridCell";
static NSString *const JDListGridCellID = @"DCListGridCell";

@interface JDGoodsSetViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong , nonatomic)NSArray *setItems;
@property (nonatomic, strong)  UIBarButtonItem *switchViewButton;

/* scrollerVew */
@property (strong , nonatomic)UICollectionView *collectionView;
/**
 0：列表视图，1：格子视图
 */
@property (nonatomic, assign) BOOL isSwitchGrid;
@end

@implementation JDGoodsSetViewController
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        JDHoverFlowLayout *layout = [JDHoverFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        CGRect collectionRect = CGRectMake(0, 0, ScreenW, ScreenH);
        _collectionView.frame = collectionRect;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[JDSquareCell class] forCellWithReuseIdentifier:JDSquareGridCellID];
        [_collectionView registerClass:[JDListGridCell class] forCellWithReuseIdentifier:JDListGridCellID];
        [_collectionView registerClass:[JDCustionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:JDCustionHeadViewID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];

    }
    return _collectionView;
}

- (NSArray*)setItems{
    if (!_setItems) {
        _setItems = [JDDataTool recommendItems];
    }
    return _setItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNav];
    self.isSwitchGrid = NO;
    [self.view addSubview:self.collectionView];
}

- (void)setUpNav{
    self.switchViewButton = [UIBarButtonItem initWithTarget:self action:@selector(switchViewButtonBarItemBtnClick) image:@"nav_btn_jiugongge" hightImage:@"" selectedImage:@"nav_btn_list"];
    self.navigationItem.rightBarButtonItem = self.switchViewButton;
}
- (void)switchViewButtonBarItemBtnClick
{
    UIButton *btn = (UIButton *)self.switchViewButton.customView;
    btn.selected = !btn.selected;
    self.isSwitchGrid = !self.isSwitchGrid;
    [self.collectionView reloadData];
}
#pragma mark -- CollectionView dalegate And DateSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.setItems.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JDListGridCell *cell = nil;
    cell = self.isSwitchGrid ?   [collectionView dequeueReusableCellWithReuseIdentifier:JDListGridCellID forIndexPath:indexPath] : [collectionView dequeueReusableCellWithReuseIdentifier:JDSquareGridCellID forIndexPath:indexPath];
    cell.youSelectItem = self.setItems[indexPath.row];
    if (self.isSwitchGrid) {
        __weak typeof(cell)weakCell = cell;
        cell.colonClickBlock = ^{
            JDRecommendItem *weakItem = weakCell.youSelectItem;
            NSLog(@"%@",weakItem.main_title);
        };
    }
    return cell;
}

#pragma mark -- item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return (_isSwitchGrid) ? CGSizeMake(ScreenW, 120) : CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 60);//列表、网格Cell
}
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
    
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (_isSwitchGrid) ? 0 : 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenW, 40);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind  == UICollectionElementKindSectionHeader) {
        JDCustionHeadView *jdReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:JDCustionHeadViewID forIndexPath:indexPath];
        reusableview = jdReusableView;
    }
    return reusableview;
}
@end
