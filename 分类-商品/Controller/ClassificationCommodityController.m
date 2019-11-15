//
//  ClassificationCommodityController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.


#import "ShopCollectionCell.h"
#import "CommodityDetailsController.h"
#import "ClassificationCommodityController.h"

@interface ClassificationCommodityController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation ClassificationCommodityController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蛋制品";
    [self.view addSubview:self.headerView];
    [self addCollectionView];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 35);
    [rightButton setImage:[[UIImage imageNamed:@"details_serch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    if (_listModelArray) {
        [self.collectionView reloadData];
    } else {
        [self connetToIneternet];
    }
}
    
- (void)connetToIneternet {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/product/getGoodsList"] params:@{@"cate_id":_goodsId NonNull} success:^(id  _Nonnull response) {
        if ([response[@"status"] intValue] == 1) {
                weakSelf.listModelArray = [GoodsListModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"goods_list"]];
                [weakSelf.collectionView reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES hasToken:YES];
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 42)];
        [self addSubViews];
    }
    return _headerView;
}

- (void)addSubViews {
    
    UIButton *numberButtton = [[UIButton alloc] initWithFrame:AutoFrame(95, 13, 45, 17)];
    [numberButtton setTitle:@"销量" forState:UIControlStateNormal];
    [numberButtton setImage:[UIImage imageNamed:@"details_sort"] forState:UIControlStateNormal];
    [numberButtton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6*ScalePpth)];
    [numberButtton setImageEdgeInsets:UIEdgeInsetsMake(0, 39*ScalePpth, 0, 0)];
    [numberButtton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    numberButtton.titleLabel.font = FontSize(13);
    [_headerView addSubview:numberButtton];
    
    UIButton *priceButtton = [[UIButton alloc] initWithFrame:AutoFrame(220, 13, 45, 17)];
    [priceButtton setTitle:@"价格" forState:UIControlStateNormal];
    [priceButtton setImage:[UIImage imageNamed:@"details_sort"] forState:UIControlStateNormal];
    [priceButtton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6*ScalePpth)];
    [priceButtton setImageEdgeInsets:UIEdgeInsetsMake(0, 39*ScalePpth, 0, 0)];
    [priceButtton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    priceButtton.titleLabel.font = FontSize(13);
    [_headerView addSubview:priceButtton];
}

- (void)addCollectionView {
    UICollectionViewFlowLayout *flowLt = [[UICollectionViewFlowLayout alloc]init];
    //布局
    flowLt.minimumInteritemSpacing = 15 *ScalePpth;
    flowLt.minimumLineSpacing = 10 *ScalePpth;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 42 *ScalePpth, ScreenWidth, ScreenHeight - KNavigationHeight-42*ScalePpth) collectionViewLayout:flowLt];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ShopCollectionCell class] forCellWithReuseIdentifier:@"ShopCollectionCell"];
    [self.view addSubview:_collectionView];
}


#pragma mark -------------------------------- CollectionView dataSource,delegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listModelArray.count;
}
//header高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayou referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCollectionCell" forIndexPath:indexPath] ;
    cell.listModel = _listModelArray[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ZxdSizeMake(164, 240);
}
//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10*ScalePpth, 15*ScalePpth, 10*ScalePpth, 15*ScalePpth);
}

#pragma mark -- item点击跳转

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CommodityDetailsController *cdvc = [CommodityDetailsController new];
    cdvc.idName = [_listModelArray[indexPath.row] idName] NonNull;
    [self.navigationController pushViewController:cdvc animated:YES];
}



@end
