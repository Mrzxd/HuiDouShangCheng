
//
//  ShoppingCartController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "ShoppingCartCell.h"
#import "ShoppingCartController.h"

@interface ShoppingCartController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *buttomView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = RGBHex(0xF7F6FA);
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buttomView];
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, (164*ScalePpth +statusHeight)/ScalePpth)];
        _topView.backgroundColor = RGBHex(0xFF5044);
        [self addSubViews];
    }
    return _topView;
}
- (UIView *)buttomView {
    if (!_buttomView) {
        CGFloat height = ScreenHeight - KTabBarHeight - 54*ScalePpth;
        _buttomView = [[UIView alloc] initWithFrame:AutoFrame(0, height/ScalePpth, 375, 54)];
        _buttomView.backgroundColor = RGBHex(0xffffff);
        [self addbuttomViewSubViews];
    }
    return _buttomView;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 351, 36)];
        [self addheaderViewSubViews];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(12*ScalePpth, 86.5*ScalePpth +statusHeight, 351*ScalePpth, 332*ScalePpth) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ShoppingCartCell class] forCellReuseIdentifier:@"ShoppingCartCell"];
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 10*ScalePpth;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xffffff);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)addheaderViewSubViews {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(47.5, 17, 100, 14)];
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text = @"惠豆商城";
    nameLabel.font = [UIFont systemFontOfSize:14 *ScalePpth];
    [_headerView addSubview:nameLabel];
    
    UIButton *selectButton = [[UIButton alloc] initWithFrame:AutoFrame(0, 0, 48, 48)];
    selectButton.tag = 200;
    [selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:selectButton];
    
    UIButton *editButton = [[UIButton alloc] initWithFrame:AutoFrame(276, 18.5, 60, 12)];
    editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    editButton.titleLabel.font = FontSize(14);
    [editButton setTitleColor:RGBHex(0xE70422) forState:UIControlStateNormal];
    [_headerView addSubview:editButton];
}

- (void)addbuttomViewSubViews {
    UIButton *selectButton = [[UIButton alloc] initWithFrame:AutoFrame(9.5, 2.5, 48, 48)];
    [selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateSelected];
    selectButton.tag = 201;
    [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttomView addSubview:selectButton];
    
    UILabel *selectLabel = [[UILabel alloc] initWithFrame:AutoFrame(57, 20.5, 100, 14)];
    selectLabel.textColor = RGBHex(0x999999);
    selectLabel.text = @"全选";
    selectLabel.font = [UIFont systemFontOfSize:14*ScalePpth];
    [_buttomView addSubview:selectLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(50, 20.5, 200, 14)];
    priceLabel.textColor = RGBHex(0xE64615);
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont systemFontOfSize:14*ScalePpth];
    [_buttomView addSubview:priceLabel];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"合计：¥ 0.00"];
    [attri addAttribute:NSForegroundColorAttributeName value:RGBHex(0x999999) range:NSMakeRange(0, 3)];
    priceLabel.attributedText = attri;
    
    UIButton *settlementButton = [[UIButton alloc] initWithFrame:AutoFrame(267, 6.5, 96, 40)];
    settlementButton.backgroundColor = RGBHex(0xFF5044);
    settlementButton.layer.cornerRadius = 20*ScalePpth;
    settlementButton.layer.masksToBounds = YES;
    [settlementButton setTitle:@"结算" forState:UIControlStateNormal];
    [settlementButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    settlementButton.titleLabel.font = FontSize(16);
    [_buttomView addSubview:settlementButton];
}
- (void)selectButtonAction:(UIButton *)button {
    button.selected = !button.selected;
}
- (void)addSubViews {
    UILabel *shoppingLabel = [[UILabel alloc] initWithFrame:AutoFrame(12.5, (16.5*ScalePpth +statusHeight)/ScalePpth, 100, 20)];
    shoppingLabel.textColor = UIColor.whiteColor;
    shoppingLabel.text = @"购物车";
    shoppingLabel.font = [UIFont boldSystemFontOfSize:20 *ScalePpth];
    [_topView addSubview:shoppingLabel];
    
    UIButton *administrationButton = [[UIButton alloc] initWithFrame:AutoFrame(325, (22*ScalePpth +statusHeight)/ScalePpth, 38, 15)];
    administrationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [administrationButton setTitle:@"管理" forState:UIControlStateNormal];
    administrationButton.titleLabel.font = FontSize(14);
    [administrationButton setTitleColor:RGBHex(0xfffffff) forState:UIControlStateNormal];
    [_topView addSubview:administrationButton];

    UILabel *totalLabel = [[UILabel alloc] initWithFrame:AutoFrame(12.5, (59*ScalePpth +statusHeight)/ScalePpth, 200, 15)];
    totalLabel.textColor = UIColor.whiteColor;
    totalLabel.text = @"总共4件宝贝";
    totalLabel.font = [UIFont systemFontOfSize:15 *ScalePpth];
    [_topView addSubview:totalLabel];
}




#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110*ScalePpth;
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
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell" forIndexPath:indexPath];
    return cell;
}

@end
