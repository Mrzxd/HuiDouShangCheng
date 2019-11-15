//
//  CommodityClassificationController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "GoodsListModel.h"
#import "GdCollectionReusableView.h"
#import "CommodityClassificationTableCell.h"
#import "ClassificationCommodityController.h"
#import "CommodityClassificationCollectionCell.h"
#import "CommodityClassificationController.h"

@interface CommodityClassificationController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray <GoodsListModel *>*listModelArray;
    
@end

@implementation CommodityClassificationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    [self.view addSubview:self.searchBar];
    self.navigationItem.leftBarButtonItem = nil;
    UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, 44, 375, 0.5)];
    line.backgroundColor = RGBHex(0xE0E0E0);
    [self.view addSubview:line];
    [self.view addSubview:self.tableView];
    [self CreatCollectionCellUI];
    [self setUpUI];
}
- (void)setUpUI {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/product/getShopCate"] params:@{@"shop_type":@"3"} success:^(id  _Nonnull response) {
        weakSelf.dataArray = response[@"data"];
        [weakSelf.tableView reloadData];
        [weakSelf.collectionView reloadData];
    } fail:^(NSError * _Nonnull error) {
    } showHUD:YES hasToken:YES];
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:AutoFrame(15, 7, 345, 30)];
        _searchBar.placeholder = @"搜索商品";
        _searchBar.barStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        UIImage * searchBarBg = [self GetImageWithColor:RGBHex(0xF5F5F5) andHeight:30 *ScalePpth];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:RGBHex(0xF5F5F5)];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        //更改输入框圆角
        _searchBar.layer.cornerRadius = 15*ScalePpth;
        _searchBar.layer.masksToBounds = YES;
        //更改输入框字号
        UITextField  *seachTextFild = (UITextField*)[self subViewOfClassName:@"UISearchBarTextField" view:_searchBar];
        seachTextFild.font = [UIFont systemFontOfSize:12 *ScalePpth];
    }
    return _searchBar;
}
- (UIView *)subViewOfClassName:(NSString*)className view:(UIView *)view {
    for (UIView* subView in view.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        UIView* resultFound = [self subViewOfClassName:className view:subView];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}
- (void)CreatCollectionCellUI {
    UICollectionViewFlowLayout *flowLt = [[UICollectionViewFlowLayout alloc]init];
    //布局
    flowLt.minimumInteritemSpacing = 0;
    flowLt.minimumLineSpacing = 0;
    CGFloat height = self.view.frame.size.height - KTabBarHeight - KNavigationHeight -44.5*ScalePpth;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(99, 44.5 *ScalePpth, 276*ScalePpth,height) collectionViewLayout:flowLt];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CommodityClassificationCollectionCell class] forCellWithReuseIdentifier:@"CommodityClassificationCollectionCell"];
    [_collectionView registerClass:[GdCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GdCollectionReusableView"];
    [self.view addSubview:_collectionView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KTabBarHeight - KNavigationHeight -44.5*ScalePpth;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44.5*ScalePpth, 99*ScalePpth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CommodityClassificationTableCell class] forCellReuseIdentifier:@"CommodityClassificationTableCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.backgroundColor = RGBHex(0xF7F6FA);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/product/searchGoods"] params:@{@"good_name":NoneNull(searchBar.text)} success:^(id  _Nonnull response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]] && [response[@"data"] count]) {
            weakSelf.listModelArray = [GoodsListModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            ClassificationCommodityController *classicc = [ClassificationCommodityController new];
            classicc.listModelArray = weakSelf.listModelArray;
            [weakSelf.navigationController pushViewController:classicc animated:YES];
        } else {
            [WHToast showErrorWithMessage:response[@"msg"]];
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES hasToken:YES];
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommodityClassificationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommodityClassificationTableCell" forIndexPath:indexPath];
    cell.titleLabel.text = _dataArray[indexPath.row][@"title"];
    if (indexPath.row == 0) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.textColor = RGBHex(0xD90004);
    } else {
         cell.contentView.backgroundColor = RGBHex(0xF5F5F5);
         cell.titleLabel.textColor = RGBHex(0x7A7A7A);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _index = indexPath.row;
    [_collectionView reloadData];
}

#pragma mark -------------------------------- CollectionView dataSource,delegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArray[_index][@"junior"] count];
}
//header高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(276*ScalePpth, 50*ScalePpth);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayou referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    GdCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GdCollectionReusableView" forIndexPath:indexPath];
    return headerView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommodityClassificationCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommodityClassificationCollectionCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:_dataArray[_index][@"junior"][indexPath.row][@"img"]]]];
    cell.label.text = _dataArray[_index][@"junior"][indexPath.row][@"title"];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ZxdSizeMake(275.0/3, 276.0/3);
}
//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassificationCommodityController *classicc = [ClassificationCommodityController new];
    classicc.goodsId = _dataArray[_index][@"junior"][indexPath.row][@"id"];
    [self.navigationController pushViewController:classicc animated:YES];
}

@end
