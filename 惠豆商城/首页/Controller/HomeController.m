
//
//  HomeController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "ReceiveView.h"
#import "HomeTypeModel.h"
#import "HomeTableTwoCell.h"
#import "HomeTableThreeCell.h"
#import "HomeTableFourCell.h"
#import "HomeController.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "MerchantEntryController.h"
#import "AgentApplicationController.h"
#import "ZXDLabelInViewDisplay.h"
#import "NearbyStoreController.h"

@interface HomeController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) ReceiveView *receiView;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray <HomeTypeModel *>*homeTypeModelArray;

@property (nonatomic, strong) ZLImageViewDisplayView *headerImageView;
@property (nonatomic, strong) ZXDLabelInViewDisplay *labelInViewDisplay;

@property (nonatomic, strong) CLLocation *clannotation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property BOOL flag;

@end

@implementation HomeController

-  (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _searchBar.hidden = NO;
    if (!_searchBar) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(-40, 0, 35, 35);
        [backButton setTitle:@"" forState:UIControlStateNormal];
        [backButton setImage:[[UIImage imageNamed:@"home_news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10*ScalePpth)];
        //    [backButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        UIView *backView = [[UIView alloc] initWithFrame:AutoFrame(51, 0, 295, 44)];
        [backView addSubview:self.searchBar];
        [self.navigationController.navigationBar addSubview:backView];
    }
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = RGBHex(0xED4E45);
    self.navigationController.navigationBar.barTintColor = RGBHex(0xED4E45);
    [self.navigationController.navigationBar setBackgroundImage:[self GetImageWithColor:RGBHex(0xED4E45) andHeight:0] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated {
    _searchBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self startLocation];
    [self netWork:0];
    [self connectToTheInternet];
}

- (void)connectToTheInternet {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/index/getIndexMsg"]  params:@{} success:^(id  _Nonnull response) {
        if ([response[@"status"] intValue] == 1 && [response[@"data"] isKindOfClass:[NSArray class]] && [response[@"data"] count]) {
            NSArray *dataArray = response[@"data"];
            weakSelf.labelInViewDisplay.dataArray = dataArray;
            [weakSelf.bottomView addSubview:weakSelf.labelInViewDisplay];
        } else {
            [WHToast showErrorWithMessage:response[@"msg"]];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES hasToken:YES];
}
- (void)startLocation {
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 8.0) {
        // 由于iOS8中定位的授权机制改变, 需要进行手动授权
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations.lastObject;
    _clannotation = currentLocation;
    
}
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        CLLocationDistance distance = 2000;
        _locationManager.distanceFilter = distance;
    }
    return _locationManager;
}
- (ZXDLabelInViewDisplay *)labelInViewDisplay {
    if (!_labelInViewDisplay) {
        _labelInViewDisplay = [ZXDLabelInViewDisplay zlImageViewDisplayViewWithFrame:AutoFrame(0, 161.5, 375, 20)];
        _labelInViewDisplay.scrollInterval = 3;
        _labelInViewDisplay.animationInterVale = 0.6;
       
        [_labelInViewDisplay addTapEventForImageWithBlock:^(NSInteger imageIndex) {
            
        }];
    }
    return _labelInViewDisplay;
}
    - (ZLImageViewDisplayView *)headerImageView {
        if (!_headerImageView) {
            _headerImageView = [ZLImageViewDisplayView zlImageViewDisplayViewWithFrame:AutoFrame(0, 5, 375, 105)];
            _headerImageView.imageViewArray = @[@"home_capsule"];
            _headerImageView.scrollInterval = 3;
            _headerImageView.animationInterVale = 0.6;
            WeakSelf;
            [_headerImageView addTapEventForImageWithBlock:^(NSInteger imageIndex) {
                [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/user/getRedPacket"] params:@{} success:^(id  _Nonnull response) {
                    if ([response[@"status"] intValue] == 1) {
                        weakSelf.receiView.data = response[@"data"];
                        [[[UIApplication sharedApplication] keyWindow] addSubview:weakSelf.receiView];
                    } else {
                        [WHToast showErrorWithMessage:response[@"msg"]];
                    }
                } fail:^(NSError * _Nonnull error) {
                    
                } showHUD:YES hasToken:YES];
            }];
        }
        return _headerImageView;
    }
- (ReceiveView *)receiView {
    if (!_receiView) {
        _receiView = [[ReceiveView alloc] init];
    }
    return _receiView;
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:AutoFrame(0, 5, 295, 28)];
        _searchBar.placeholder = @" 请输入您想要搜索的内容";
        _searchBar.barStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        [_searchBar setImage:[UIImage imageNamed:@"home_serch"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        UIImage * searchBarBg = [self GetImageWithColor: UIColor.clearColor andHeight:28 *ScalePpth];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:RGBHexAlpha(0xffffff, 0.16)];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        //更改输入框圆角
        _searchBar.layer.cornerRadius = 14*ScalePpth;
        _searchBar.layer.masksToBounds = YES;
        //更改输入框字号
        UITextField  *seachTextFild = (UITextField*)[self subViewOfClassName:@"UISearchBarTextField" view:_searchBar];
        seachTextFild.textColor = UIColor.whiteColor;
        [seachTextFild setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        seachTextFild.font = [UIFont systemFontOfSize:13 *ScalePpth];
    }
    return _searchBar;
}
- (UIView*)subViewOfClassName:(NSString*)className view:(UIView *)view{
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
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, (106+194+110))];
        _headerView.backgroundColor = RGBHex(0xED4E45);
        [self addSubViews];
    }
    return _headerView;
}
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 45)];
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(161, 11, 52, 18)];
        button.layer.cornerRadius = 2*ScalePpth;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = RGBHex(0xE0E0E0).CGColor;
        [button setTitle:@"查看更多" forState:UIControlStateNormal];
        button.titleLabel.font = FontSize(10);
        [button setTitleColor:RGBHex(0xFF5F56) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(seeMore:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
    }
    return _footerView;
}

- (void)seeMore:(UIButton *)button {
    [self.navigationController pushViewController:[NearbyStoreController new] animated:YES];
}

- (void)addSubViews {
    NSArray *imageArray = @[@"home_sweep",@"home_pay",@"home_income",@"home_coin"];
    NSArray *titleArray = @[@"扫一扫",@"付钱",@"收入明细",@"我的金币"];
    for (NSInteger i = 0; i < 4; i ++) {
        UIButton *button  = [[UIButton alloc] initWithFrame:AutoFrame((i*375.0/4), (91-64), 375.0/4, 28)];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [_headerView addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame((i*375.0/4), 69, 375.0/4, 13)];
        label.text = titleArray[i];
        label. textColor = UIColor.whiteColor;
        label.font = FontSize(13);
        label.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:label];
    }
    
    _bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 106, 375, 194)];
    _bottomView.backgroundColor = RGBHex(0xffffff);
    [_headerView addSubview:_bottomView];
    
     NSArray *imageArray2 = @[@"hui",@"jin",@"yin",@"home_nearby",@"home_popular",@"home_apply",@"home_settled",@"home_invitation"];
     NSArray *titleArray2 = @[@"惠豆商城",@"金豆商城",@"银豆商城",@"附近门店",@"热门商品",@"代理申请",@"商家入驻",@"邀请好友"];
    
    for (NSInteger i = 0; i < 8; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame((i%4*375.0/4),(57+i/4*(57.5+13)), 375.0/4, 13)];
        label.text = titleArray2[i];
        label. textColor = RGBHex(0x000000);
        label.font = FontSize(13);
        label.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:label];
        
        UIButton *button  = [[UIButton alloc] initWithFrame:AutoFrame((i%4*375.0/4),(i/4*(46.5+25)), 375.0/4, 70)];
        [button setImage:[UIImage imageNamed:imageArray2[i]] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.tag = 100 +i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button];
    }
    
    UIView *bottomView2 = [[UIView alloc] initWithFrame:AutoFrame(0, (194+170-64), 375, 110)];
    bottomView2.backgroundColor = RGBHex(0xF7F6FA);
    [_headerView addSubview:bottomView2];
    [bottomView2 addSubview:self.headerImageView];
    
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageViewTapgesture:)];
    [_bottomView addGestureRecognizer:tapges];
}
- (void)buttonAction:(UIButton *)button {
    switch (button.tag) {
        case 107: {
            [self.navigationController pushViewController:[InviteFriendsController new] animated:YES];
        }
            break;
        case 106: {
            [self.navigationController pushViewController:[MerchantEntryController new] animated:YES];
        }
            break;
        case 105:
            [self.navigationController pushViewController:[AgentApplicationController new] animated:YES];
            break;
        default:
            break;
    }
}
- (void)ImageViewTapgesture:(UITapGestureRecognizer *)gesture {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.receiView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KTabBarHeight - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[HomeTableThreeCell class] forCellReuseIdentifier:@"HomeTableThreeCell"];
        [_tableView registerClass:[HomeTableTwoCell class] forCellReuseIdentifier:@"HomeTableTwoCell"];
         [_tableView registerClass:[HomeTableFourCell class] forCellReuseIdentifier:@"HomeTableFourCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xF7F6FA);
        _tableView.tableFooterView = self.footerView;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}


#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeTypeModelArray.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row) {
        if (_flag) {
            return 124*ScalePpth;
        }
        return 104*ScalePpth;
    }
    return 47*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5*ScalePpth;
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
    if (indexPath.row == 0) {
        HomeTableThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableThreeCell" forIndexPath:indexPath];
        WeakSelf;
        cell.indexBlock = ^(NSInteger index) {
            weakSelf.flag = index;
            [weakSelf netWork:index];
        };
        return cell;
    }
    if (_flag == 0) {
        HomeTableTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableTwoCell" forIndexPath:indexPath];
        cell.typeModel = self.homeTypeModelArray[indexPath.row - 1];
        WeakSelf;
        cell.navigationBlock = ^(HomeTypeModel * _Nonnull typeModel) {
            [weakSelf setMapItemDatas:typeModel];
        };
        return cell;
    } else {
        HomeTableFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableFourCell" forIndexPath:indexPath];
        cell.typeModel = self.homeTypeModelArray[indexPath.row - 1];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)netWork:(NSInteger)index {
    NSDictionary *dic;
    NSString *url;
    if (index == 0) {
        url = @"/api/index/getIndexShop";
        dic = @{@"lng":@(_clannotation.coordinate.longitude),@"lat":@(_clannotation.coordinate.latitude)};
    } else {
        dic = @{};
        
        if (index == 1) {
            url = @"/api/product/foodCollection";
        } else {
            url = @"/api/product/memberShip";
        }
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:url] params:dic success:^(id  _Nonnull response) {
        if ([response[@"status"] intValue] == 1 && [response[@"data"] isKindOfClass:[NSArray class]] && [response[@"data"] count]) {
            weakSelf.homeTypeModelArray = [HomeTypeModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            [weakSelf.homeTypeModelArray  enumerateObjectsUsingBlock:^(HomeTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.img = [rootUrl stringByAppendingString:NoneNull(obj.img)];
                [weakSelf.tableView reloadData];
            }];
        }
    } fail:^(NSError * _Nonnull error) {} showHUD:YES hasToken:YES];
}

- (void)setMapItemDatas:(HomeTypeModel *)typeModel {
    CLLocationCoordinate2D coords1 = _clannotation.coordinate;
    //目的地位置
    CLLocationCoordinate2D coordinate2;
    coordinate2.latitude = typeModel.latitude.doubleValue;
    coordinate2.longitude = typeModel.longitude.doubleValue;
    //起点
    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
    currentLocation.name = @"我的位置";
    //目的地的位置
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate2 addressDictionary:nil]];
    toLocation.name = @"目的地";
    if (NoneNull(typeModel.title)) {
        toLocation.name = typeModel.title;
    }
    NSArray *items = @[currentLocation,toLocation];
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],MKLaunchOptionsShowsTrafficKey:@YES};
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

@end
