
//
//  ShoppingCartController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "GetMyCartModel.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartController.h"

@interface ShoppingCartController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *buttomView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) NSMutableArray *headerArray;
@property (nonatomic, strong) NSMutableDictionary *cellDiction;
@property (nonatomic, strong) NSMutableDictionary *dataDiction;
@property (nonatomic, strong) NSMutableArray *typeArray;

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *deletButton;
@property (nonatomic, strong) NSMutableArray *deleteArray;

@end

@implementation ShoppingCartController {
    UIButton *lastSelectButton;
    UIButton *settlementButton;
    NSMutableArray *selectButtonArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self connectToTheIneternet];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = RGBHex(0xF7F6FA);
    _headerArray = [NSMutableArray array];
    _typeArray = [NSMutableArray array];
    _cellDiction = [NSMutableDictionary dictionary];
    _modelArray = [NSMutableArray array];
    selectButtonArray = [NSMutableArray array];
    _deleteArray = [NSMutableArray array];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buttomView];
}
- (UIButton *)deletButton {
    if (!_deletButton) {
        _deletButton = [[UIButton alloc] initWithFrame:AutoFrame(280, 12, 80, 30)];
        [_deletButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deletButton setTitleColor:RGBHex(0xCF392A) forState:UIControlStateNormal];
        _deletButton.titleLabel.font = FontSize(15);
        _deletButton.layer.cornerRadius = 15*ScalePpth;
        _deletButton.layer.masksToBounds = YES;
        _deletButton.layer.borderWidth = 0.6;
        _deletButton.layer.borderColor = RGBHex(0xCF392A).CGColor;
        [_deletButton addTarget:self action:@selector(deletButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deletButton;
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
    }
    return _buttomView;
}
- (UIView *)headerView {
    if (_headerArray.count == _dataDiction.count) {
        return _headerArray[_section];
    }
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 351, 36)];
        [self addheaderViewSubViews];
    [_headerArray addObject:_headerView];
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(12*ScalePpth, 86.5*ScalePpth +statusHeight, 351*ScalePpth,ScreenHeight - KTabBarHeight - statusHeight - (54+86.5)*ScalePpth) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 10*ScalePpth;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.backgroundColor = RGBHex(0xffffff);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)addheaderViewSubViews {
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(47.5, 17, 100, 14)];
    _nameLabel.textColor = RGBHex(0x333333);
     if ([self.dataDiction.allKeys containsObject:@"3"]) {
         [_typeArray addObject:@"惠豆商城"];
     }
    if ([self.dataDiction.allKeys containsObject:@"2"]) {
         [_typeArray addObject:@"银豆商城"];
    }
    if ([self.dataDiction.allKeys containsObject:@"1"]) {
         [_typeArray addObject:@"金豆商城"];
    }
    _nameLabel.text = _typeArray[_section];
    _nameLabel.font = [UIFont systemFontOfSize:14 *ScalePpth];
    [_headerView addSubview:_nameLabel];
    
    UIButton *selectButton = [[UIButton alloc] initWithFrame:AutoFrame(0, 0, 48, 48)];
    selectButton.tag = 200+_section;
    [selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:selectButton];
    [selectButtonArray addObject:selectButton];
//    UIButton *editButton = [[UIButton alloc] initWithFrame:AutoFrame(276, 18.5, 60, 12)];
//    editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
//    editButton.titleLabel.font = FontSize(14);
//    [editButton setTitleColor:RGBHex(0xE70422) forState:UIControlStateNormal];
//    [_headerView addSubview:editButton];
}

- (void)addbuttomViewSubViews {
    UIButton *selectButton = [[UIButton alloc] initWithFrame:AutoFrame(9.5, 2.5, 48, 48)];
    [selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateSelected];
    selectButton.tag = 500+_section;
    [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttomView addSubview:selectButton];
    
    UILabel *selectLabel = [[UILabel alloc] initWithFrame:AutoFrame(57, 20.5, 100, 14)];
    selectLabel.textColor = RGBHex(0x999999);
    selectLabel.text = @"全选";
    selectLabel.font = [UIFont systemFontOfSize:14*ScalePpth];
    [_buttomView addSubview:selectLabel];
    if (_typeArray.count > 1) {
        selectButton.hidden = YES;
        selectLabel.hidden = YES;
    }
    _priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(50, 20.5, 200, 14)];
    _priceLabel.textColor = RGBHex(0xE64615);
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.font = [UIFont systemFontOfSize:14*ScalePpth];
    [_buttomView addSubview:_priceLabel];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：¥0.00"]];
    [attri addAttribute:NSForegroundColorAttributeName value:RGBHex(0x999999) range:NSMakeRange(0, 3)];
    _priceLabel.attributedText = attri;
    
    settlementButton = [[UIButton alloc] initWithFrame:AutoFrame(267, 6.5, 96, 40)];
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
     WeakSelf;
    if (button.tag >= 200 && button.tag < 500) {
        if (lastSelectButton && lastSelectButton != button) {
            lastSelectButton.selected = NO;
        }
        lastSelectButton = button;
        NSInteger index = button.tag - 200;
        NSArray *keyArray = _cellDiction.allKeys;
        [keyArray enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *key = str.mutableCopy;
            key = [key stringByReplacingOccurrencesOfString:@"ShoppingCartCell" withString:@""];
            key = [key substringToIndex:1];
                if (key.integerValue == index) {
                    ShoppingCartCell *cell = weakSelf.cellDiction[str];
                    cell.selectButton.selected = button.selected;
                }
        }];
        [self changPrice:_cellDiction[[NSString stringWithFormat:@"ShoppingCartCell%ld%d",index,0]]];
    } else {
        __block CGFloat sum = 0.0;
        _deleteArray = nil;
        _deleteArray = [NSMutableArray array];
        [_cellDiction enumerateKeysAndObjectsUsingBlock:^(NSString * key, ShoppingCartCell *cell, BOOL * _Nonnull stop) {
            cell.selectButton.selected = button.selected;
            CGFloat price = [cell.model.price floatValue];
            NSInteger number = [cell.numberLabel.text integerValue];
            CGFloat totalPrice = price *number;
            sum += totalPrice;
            [weakSelf.deleteArray addObject:cell.model.idName];
        }];
        if (!button.selected) {
            sum = 0;
            _deleteArray = @[].mutableCopy;
        }
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：¥%0.2lf",sum]];
        [attri addAttribute:NSForegroundColorAttributeName value:RGBHex(0x999999) range:NSMakeRange(0, 3)];
        weakSelf.priceLabel.attributedText = attri;
    }
    _modelArray.count?[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([_modelArray[_section] count]-1) inSection:_section] atScrollPosition:UITableViewScrollPositionTop animated:NO]:0;
    
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
    [administrationButton addTarget:self action:@selector(administrationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:administrationButton];

    _totalLabel = [[UILabel alloc] initWithFrame:AutoFrame(12.5, (59*ScalePpth +statusHeight)/ScalePpth, 200, 15)];
    _totalLabel.textColor = UIColor.whiteColor;
    _totalLabel.text = @"总共1件宝贝";
    _totalLabel.font = [UIFont systemFontOfSize:15 *ScalePpth];
    [_topView addSubview:_totalLabel];
}
- (void)administrationButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        settlementButton.hidden = YES;
        [self.buttomView addSubview:self.deletButton];
    } else {
        settlementButton.hidden = NO;
        [_deletButton removeFromSuperview];
    }
}
- (void)deletButtonAction:(UIButton *)button {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/cart/delMyCart"] params:@{@"cart_id":_deleteArray} success:^(id  _Nonnull response) {
        if ([response[@"status"] intValue] == 1) {
            [weakSelf connectToTheIneternet];
        }
    } fail:^(NSError * _Nonnull error) {
    } showHUD:YES hasToken:YES];
}
- (void)connectToTheIneternet {
    [_buttomView removeFromSuperview];
    _buttomView = nil;
    [self.view addSubview:self.buttomView];
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/cart/getMyCart"] params:@{} success:^(id  _Nonnull response) {
        weakSelf.dataDiction = response[@"data"][@"list"];
            if ([weakSelf.dataDiction.allKeys containsObject:@"3"]) {
                [weakSelf.modelArray addObject:[GetMyCartModel mj_objectArrayWithKeyValuesArray:weakSelf.dataDiction[@"3"]]];
            }
            if ([weakSelf.dataDiction.allKeys containsObject:@"2"]) {
                [weakSelf.modelArray addObject:[GetMyCartModel mj_objectArrayWithKeyValuesArray:weakSelf.dataDiction[@"2"]]];
            }
            if ([weakSelf.dataDiction.allKeys containsObject:@"1"]) {
                [weakSelf.modelArray addObject:[GetMyCartModel mj_objectArrayWithKeyValuesArray:weakSelf.dataDiction[@"1"]]];
            }
        weakSelf.totalLabel.text = [NSString stringWithFormat:@"总共%@件宝贝",NoneNull(response[@"data"][@"good_count"])];
            [weakSelf.tableView reloadData];
            [self addbuttomViewSubViews];
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES hasToken:YES];
}


#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataDiction.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_modelArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36 *ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _section = section;
    return self.headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartCell *cell = _cellDiction[[NSString stringWithFormat:@"ShoppingCartCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
    if (cell) {
        return cell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ShoppingCartCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
        if (!cell) {
            cell = [[ShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ShoppingCartCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
            cell.indexPath = indexPath;
        }
         cell.model = _modelArray[indexPath.section][indexPath.row];
        WeakSelf;
        __weak typeof(cell) weakCell = cell;
         cell.buttonBlock = ^(CGFloat OneCellTotoalPrice) {
             [weakSelf changPrice:weakCell];
        };
        cell.numberBlock = ^(NSString * _Nonnull number) {
            [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/cart/editCartGoodsNum"] params:@{
                                                                                                                 @"cart_id":weakCell.model.idName,
                                                                                                                 @"num":number
                                                                                                                 } success:^(id  _Nonnull response) {
                
            } fail:^(NSError * _Nonnull error) {
                
            } showHUD:YES hasToken:YES];
        };
        [_cellDiction setObject:cell forKey:[NSString stringWithFormat:@"ShoppingCartCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
        return cell;
    }
}

- (void)changPrice:(ShoppingCartCell *)cell {
    _deleteArray = nil;
    _deleteArray = @[].mutableCopy;
    NSInteger index = cell.indexPath.section;
    UIButton *currentButton = selectButtonArray[index];
    if (lastSelectButton != currentButton) {
        lastSelectButton.selected = NO;
    }
    NSArray *keyArray = _cellDiction.allKeys;
    WeakSelf;
    __block CGFloat sum = 0.0;
    __block NSInteger flag = 0;
    [keyArray enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = str.mutableCopy;
        key = [key stringByReplacingOccurrencesOfString:@"ShoppingCartCell" withString:@""];
        key = [key substringToIndex:1];
         ShoppingCartCell *cells = weakSelf.cellDiction[str];
        if (key.integerValue == index) {
            if (cells.selectButton.selected) {
                flag = 1;
                currentButton.selected = YES;
                CGFloat totalPrice = cells.model.price.floatValue *cells.numberLabel.text.integerValue;
                sum += totalPrice;
                [weakSelf.deleteArray addObject:cells.model.idName];
            }
        } else {
            cells.selectButton.selected = NO;
        }
    }];
    if (flag == 0) {
        currentButton.selected = NO;
    }
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：¥%0.2lf",sum]];
    [attri addAttribute:NSForegroundColorAttributeName value:RGBHex(0x999999) range:NSMakeRange(0, 3)];
    _priceLabel.attributedText = attri;
}



@end
