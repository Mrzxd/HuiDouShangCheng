
//
//  HomeController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "ReceiveView.h"
#import "HomeTableTwoCell.h"
#import "HomeTableThreeCell.h"
#import "HomeTableFourCell.h"
#import "HomeController.h"

@interface HomeController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) ReceiveView *receiView;

@property BOOL flag;

@end

@implementation HomeController

-  (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = RGBHex(0xED4E45);
    self.navigationController.navigationBar.barTintColor = RGBHex(0xED4E45);
    [self.navigationController.navigationBar setBackgroundImage:[self GetImageWithColor:RGBHex(0xED4E45) andHeight:0] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
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
        [_footerView addSubview:button];
    }
    return _footerView;
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
    
    UIView *bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 106, 375, 194)];
    bottomView.backgroundColor = RGBHex(0xffffff);
    [_headerView addSubview:bottomView];
    
    NSArray *imageArray2 = @[@"hui",@"jin",@"yin",@"home_nearby",@"home_popular",@"home_apply",@"home_settled",@"home_invitation"];
     NSArray *titleArray2 = @[@"惠豆商城",@"金豆商城",@"银豆商城",@"附近门店",@"热门商品",@"代理申请",@"商家入驻",@"邀请好友"];
    for (NSInteger i = 0; i < 8; i ++) {
        UIButton *button  = [[UIButton alloc] initWithFrame:AutoFrame((i%4*375.0/4),(22.5+i/4*(46.5+25)), 375.0/4, 25)];
        [button setImage:[UIImage imageNamed:imageArray2[i]] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [bottomView addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame((i%4*375.0/4),(57+i/4*(57.5+13)), 375.0/4, 13)];
        label.text = titleArray2[i];
        label. textColor = RGBHex(0x000000);
        label.font = FontSize(13);
        label.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:label];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(15.5, 161.5, 17, 20)];
    imageView.image = [UIImage imageNamed:@"home_tips"];
    [bottomView addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(43.5, 165.5, 48, 16)];
    button.layer.cornerRadius = 2*ScalePpth;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = RGBHex(0xFF5F56).CGColor;
    [button setTitle:@"温馨提示" forState:UIControlStateNormal];
    button.titleLabel.font = FontSize(10);
    [button setTitleColor:RGBHex(0xFF5F56) forState:UIControlStateNormal];
    [bottomView addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(98.5,168, 270, 12)];
    label.text = @"请送到固定站点，如有发现违规现象，将严惩！";
    label. textColor = RGBHex(0x000000);
    label.font = FontSize(12);
    [bottomView addSubview:label];
    
    UIView *bottomView2 = [[UIView alloc] initWithFrame:AutoFrame(0, (194+170-64), 375, 110)];
    bottomView2.backgroundColor = RGBHex(0xF7F6FA);
    [_headerView addSubview:bottomView2];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:AutoFrame(0, 5, 375, 105)];
    imageView2.backgroundColor = UIColor.whiteColor;
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.image = [UIImage imageNamed:@"home_capsule"];
    imageView2.userInteractionEnabled = YES;
    [bottomView2 addSubview:imageView2];
    
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageViewTapgesture:)];
    [bottomView2 addGestureRecognizer:tapges];
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
    return 7;
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
            [tableView reloadData];
        };
        return cell;
    }
    if (_flag == 0) {
        HomeTableTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableTwoCell" forIndexPath:indexPath];
        return cell;
    } else {
        HomeTableFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableFourCell" forIndexPath:indexPath];
        return cell;
    }
}

@end
