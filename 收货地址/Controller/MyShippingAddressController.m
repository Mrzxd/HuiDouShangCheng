//
//  MyShippingAddressController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/9.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "AddressModel.h"
#import "MyShippingAdressCell.h"
#import "MyShippingAdressCell2.h"
#import "EditAddressController.h"
#import "NewAddressController.h"
#import "MyShippingAddressController.h"

@interface MyShippingAddressController () <UITableViewDelegate,UITableViewDataSource,MyShippingAdressCellDelegate,MyShippingAdressCell2Delegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *remindLabel;
@property (nonatomic, strong) UIButton *newsAddressButton;
@property(nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray <AddressModel*> *addressModelArray;

@end

@implementation MyShippingAddressController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self connectToTheNetwork];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收货地址";
    [self.view addSubview:self.tableView];
}
- (void)connectToTheNetwork {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/user/getMyAddress"] params:@{} success:^(id  _Nonnull response) {
        if ( !response[@"data"] || [response[@"data"] isKindOfClass:[NSNull class]] || (response[@"data"] && [response[@"data"] count] == 0)) {
            [weakSelf.view addSubview:self.imageView];
            [weakSelf.view addSubview:self.remindLabel];
            [weakSelf.view addSubview:self.newsAddressButton];
            weakSelf.tableView.hidden = YES;
        } else {
            weakSelf.tableView.hidden = NO;
            [weakSelf.imageView removeFromSuperview];
            [weakSelf.remindLabel removeFromSuperview];
            [weakSelf.newsAddressButton removeFromSuperview];
            weakSelf.addressModelArray = [AddressModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            [weakSelf.tableView reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES hasToken:YES];
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:AutoFrame(305.0/2, 124, 70, 92)];
        _imageView.image = [UIImage imageNamed:@"D2451F71-2308-45EE-A77D-381E1BE7B617.png"];
        [self setUI];
    }
    return _imageView;
}

- (void)setUI {
    _remindLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 272, 375, 13)];
    _remindLabel.textColor = RGBHex(0x999999);
    _remindLabel.textAlignment = NSTextAlignmentCenter;
    _remindLabel.font = FontSize(13);
    _remindLabel.text = @"您还没有添加任何地址，赶紧去添加吧~";
    [self.view addSubview:_remindLabel];
    
    _newsAddressButton = [[UIButton alloc] initWithFrame:AutoFrame(125, 414, 125, 38)];
    _newsAddressButton.backgroundColor = RGBHex(0xE60121);
    _newsAddressButton.layer.cornerRadius = 19*ScalePpth;
    _newsAddressButton.layer.masksToBounds = YES;
    _newsAddressButton.titleLabel.font = FontSize(16);
    [_newsAddressButton setTitle:@"新增地址" forState:UIControlStateNormal];
    [_newsAddressButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_newsAddressButton addTarget:self action:@selector(newAddressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_newsAddressButton];
}

- (void)newAddressButtonAction:(UIButton *)button {
    [self.navigationController pushViewController:[NewAddressController new] animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[MyShippingAdressCell class] forCellReuseIdentifier:@"MyShippingAdressCell"];
        [_tableView registerClass:[MyShippingAdressCell2 class] forCellReuseIdentifier:@"MyShippingAdressCell2"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.0000000001, 0.0000000001)];
        _tableView.tableFooterView = self.footerView;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
    
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 70)];
        _footerView.backgroundColor = UIColor.whiteColor;
            UIButton *_loginButton = [[UIButton alloc] initWithFrame:CGRectMake(15*ScalePpth, 20*ScalePpth, 345*ScalePpth, 40*ScalePpth)];
            [_loginButton setTitle:@"添加新地址" forState:UIControlStateNormal];
            [_loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            _loginButton.titleLabel.font = FontSize(16);
            _loginButton.backgroundColor = RGBHex(0xFF5044);
            _loginButton.layer.cornerRadius = 40/2*ScalePpth;
            _loginButton.layer.masksToBounds = YES;
            _loginButton.clipsToBounds = YES;
            [_loginButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_loginButton];
    }
    return _footerView;
}
- (void)addButtonAction:(UIButton *)button {
   [self.navigationController pushViewController:[NewAddressController new] animated:YES];
}
- (void)toEditNewAdressResult:(AddressModel *)addressModel {
    EditAddressController *eac = [EditAddressController new];
    eac.addressModel = addressModel;
    [self.navigationController pushViewController:eac animated:YES];
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addressModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressModel *addressModel = _addressModelArray[indexPath.row];
    if (![NoneNull(addressModel.is_default) isEqualToString:@"1"]) {
        MyShippingAdressCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShippingAdressCell2" forIndexPath:indexPath];
         cell.addressModel  = addressModel;
         cell.MyShippingAdressCell2Delegate = self;
        [cell.selectButton addTarget:self action:@selector(cellSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row) {
            [cell.selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        }  else {
            _selectButton = cell.selectButton;
        }
        return cell;
    } else {
        MyShippingAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShippingAdressCell" forIndexPath:indexPath];
        cell.addressModel  = addressModel;
        cell.MyShippingAdressCellDelegate = self;
         [cell.selectButton addTarget:self action:@selector(cellSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row) {
            [cell.selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        } else {
            _selectButton = cell.selectButton;
        }
        return cell;
    }
}
- (void)cellSelectButtonAction:(UIButton *)buton {
    [_selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [buton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateNormal];
    _selectButton = buton;
}
@end
