//
//  CommodityDetailsController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/5.
//  Copyright © 2019 张兴栋. All rights reserved.

#import "GoodInfoModel.h"
#import "CenterTableCell.h"
#import "CommodityImageCell.h"
#import "ZLImageViewDisplayView.h"
#import "ShoppingCartController.h"
#import "ConfirmationOrderController.h"
#import "CommodityDetailsController.h"
#import "SelectionSpecificationController.h"

@interface CommodityDetailsController () <UITableViewDelegate,UITableViewDataSource,YTSegmentBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *middleHeaderView;

@property (nonatomic, strong) UIButton *backButtons;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) YTSegmentBar *segmentBar;
@property (nonatomic, strong) ZLImageViewDisplayView *headerImageView;

@property (nonatomic, strong) GoodInfoModel *goodInfoModel;
@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) CenterTableCell *cell;

@property (nonatomic, strong) NSString *selectKey;
@property (nonatomic, assign) NSInteger goodsCount;

@end

@implementation CommodityDetailsController {
    UILabel *numLabel;
    UILabel *nameLabel;
    UILabel *priceLabel;
    UILabel *oldpriceLabel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.backButtons];
    [self.view addSubview:self.rightButton];
    _goodsCount = 1;
    [self connectToTheInternet];
}
- (void)connectToTheInternet {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/product/getGoodInfo"] params:@{@"good_id":_idName NonNull} success:^(id  _Nonnull response) {
        if (response && response[@"data"] && response[@"data"][@"good_info"]) {
            if ([response[@"data"][@"is_collect"] intValue] == 1) {
                UIButton *button = (UIButton *)[weakSelf.footerView viewWithTag:100];
                button.selected = YES;
            }
            weakSelf.goodInfoModel = [GoodInfoModel mj_objectWithKeyValues:response[@"data"][@"good_info"]];
            weakSelf.dataDic = response[@"data"];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[weakSelf.goodInfoModel imgs]];
            [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                array[idx] = [rootUrl stringByAppendingString:obj];
            }];
            weakSelf.headerImageView.imageViewArray = array;
            [weakSelf.headerImageView layoutSubviews];
            [weakSelf changHeader];
            [weakSelf.tableView reloadData];
        }
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES hasToken:YES];
}
- (void)changHeader {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    NSString *key = _goodInfoModel.spec.spec.count > 1 ? @"00":@"0";
    _selectKey = key;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",NoneNull(_goodInfoModel.spec.price[key][@"price"])]];
    [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.3 *ScalePpth] range:NSMakeRange(0, 1)];
    priceLabel.attributedText = attri;
    [priceLabel sizeToFit];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",NoneNull(_goodInfoModel.spec.line_price[key][@"line_price"])] attributes:attribtDic];
    [attri2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:8 *ScalePpth] range:NSMakeRange(0, 1)];
    oldpriceLabel.attributedText = attri2;
    [oldpriceLabel sizeToFit];
    nameLabel.text =  NoneNull(_goodInfoModel.sub_title);
    numLabel.text = [@"已售" stringByAppendingString:NoneNull(_goodInfoModel.sale_num)];
}

- (UIButton *)backButtons {

    if (!_backButtons) {
        _backButtons = [[UIButton alloc] initWithFrame:AutoFrame(15, 29, 29, 29)];
        _backButtons.backgroundColor = RGBHexAlpha(0x000000, 0.5);
        _backButtons.layer.masksToBounds = YES;
        _backButtons.layer.cornerRadius = 14.5 *ScalePpth;
        [_backButtons setImage:[UIImage imageNamed:@"de_lefttop"] forState:UIControlStateNormal];
        [_backButtons addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButtons;
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:AutoFrame(331, 29, 29, 29)];
        _rightButton.backgroundColor = RGBHexAlpha(0x000000, 0.5);
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.cornerRadius = 14.5 *ScalePpth;
        [_rightButton setImage:[UIImage imageNamed:@"de_righttop"] forState:UIControlStateNormal];
//        [_rightButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (void)backButtonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (YTSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [YTSegmentBar segmentBarWithFrame:AutoFrame(0, 10, 375, 45)];
        _segmentBar.clipsToBounds = YES;
        _segmentBar.delegate = self;
        _segmentBar.items = @[@"商品详情",@"商品评价"];
        _segmentBar.showIndicator = YES;
        _segmentBar.selectIndex = 0;
        _segmentBar.backgroundColor = [UIColor whiteColor];
    }
    return _segmentBar;
}
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, (ScreenHeight - 50*ScalePpth)/ScalePpth, 375, 50)];
        [self addfooterViewSubViews];
    }
    return _footerView;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, (375+70))];
        _headerView.backgroundColor = RGBHex(0xffffff);
        [self addSubViews];
    }
    return _headerView;
}
- (UIView *)middleHeaderView {
    if (!_middleHeaderView) {
        _middleHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 55)];
        [_middleHeaderView addSubview:self.segmentBar];
    }
    return _middleHeaderView;
}
- (ZLImageViewDisplayView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [ZLImageViewDisplayView zlImageViewDisplayViewWithFrame:AutoFrame(0, 0, 375, 375)];
        _headerImageView.imageViewArray = @[@"home_banner",@"home_banner2"];
        _headerImageView.scrollInterval = 3;
        _headerImageView.animationInterVale = 0.6;
        [_headerImageView addTapEventForImageWithBlock:^(NSInteger imageIndex) {
            
        }];
    }
    return _headerImageView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = ScreenHeight - 50*ScalePpth;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CommodityImageCell class] forCellReuseIdentifier:@"CommodityImageCell"];
        [_tableView registerClass:[CenterTableCell class] forCellReuseIdentifier:@"CenterTableCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xF7F6FA);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
- (void)addfooterViewSubViews {
    NSArray *imageArray = @[@"shoucang",@"gouwuche",@"kefu"];
    NSArray *titleArray = @[@"收藏",@"购物车",@"客服"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(i *45, 0, 45, 32.5)];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        if (i == 0) {
             [button setImage:[UIImage imageNamed:@"shoucang_fill"] forState:UIControlStateSelected];
        }
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(i *45, 32.5, 45, 11)];
        label.textAlignment=NSTextAlignmentCenter;
        label.font = FontSize(11);
        label.text = titleArray[i];
        label.textColor = RGBHex(0xB7B7B7);
        [_footerView addSubview:label];
    }
    
    UIButton *joinButton = [[UIButton alloc] initWithFrame:AutoFrame(135, 0 , 120, 50)];
    joinButton.backgroundColor = RGBHex(0xFFA426);
    [joinButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    joinButton.titleLabel.font = FontSize(17);
    [joinButton addTarget:self action:@selector(joinButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [joinButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_footerView addSubview:joinButton];
    
    UIButton *buyButton = [[UIButton alloc] initWithFrame:AutoFrame(255, 0 , 120, 50)];
    buyButton.backgroundColor = RGBHex(0xE70422);
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    buyButton.titleLabel.font = FontSize(17);
    [buyButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:buyButton];
}
- (void)buttonAction:(UIButton *)button {
    button.selected = !button.selected;
    if (button.tag == 101) {
        self.tabBarController.selectedIndex = 2;
        [self.navigationController popToRootViewControllerAnimated:YES];        
    } else if (button.tag == 100) {
        NSString *type;
        if (button.isSelected) {
            type = @"1";
        } else {
            type = @"2";
        }
        [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/product/good_collect"] params:@{
                                                                                                            @"type":type,
                                                                                                            @"good_id":_idName
                                                                                                            } success:^(id  _Nonnull response) {
            if ([response[@"status"] intValue] == 1) {
                if ([type isEqualToString:@"1"]) {
                    [WHToast showSuccessWithMessage:@"已收藏"];
                } else {
                    [WHToast showSuccessWithMessage:@"已取消收藏"];
                }
            } else {
                [WHToast showSuccessWithMessage:@"已取消收藏"];
            }
        } fail:^(NSError * _Nonnull error) {} showHUD:YES hasToken:YES];
    }
}
// 加入购物车
- (void)joinButtonAction:(  UIButton *)button {
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/cart/addMyChat"] params:@{
                                                                                                  @"goods_id":_idName NonNull,
                                                                                                  @"num":[@(_goodsCount) stringValue],
                                                                                                  @"spec":_selectKey,
                                                                                                  } success:^(id  _Nonnull response) {
                                                                                                      if (response && [response[@"status"] intValue] == 1) {
                                                                                                          [WHToast showSuccessWithMessage:@"加入购物车成功"];
                                                                                                      } else {
                                                                                                          [WHToast showErrorWithMessage:@"加入购物车失败"];
                                                                                                      }
                                                                                                  } fail:^(NSError * _Nonnull error) {
                                                                                                      [WHToast showErrorWithMessage:@"网络错误"];
                                                                                                  } showHUD:YES hasToken:YES];
}
- (void)buyButtonAction:(UIButton *)button {
    [self.navigationController pushViewController:[ConfirmationOrderController new] animated:YES];
}
- (void)addSubViews {
    [self.headerView addSubview:self.headerImageView];
    UIView *bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 375, 375, 70)];
    bottomView.backgroundColor = UIColor.whiteColor;
    [_headerView addSubview:bottomView];
    
    priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 8, 0, 18.5)];
    priceLabel.font = [UIFont boldSystemFontOfSize:21 *ScalePpth];
    priceLabel.textColor = RGBHex(0xFE2448);
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"￥39.9"];
    [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.3 *ScalePpth] range:NSMakeRange(0, 1)];
    priceLabel.attributedText = attri;
    [priceLabel sizeToFit];
    [bottomView addSubview:priceLabel];
    
    oldpriceLabel = [[UILabel alloc] initWithFrame:AutoFrame((CGRectGetMaxX(priceLabel.frame)+4*ScalePpth)/ScalePpth, 17, 0, 10)];
    oldpriceLabel.font = [UIFont boldSystemFontOfSize:10 *ScalePpth];
    oldpriceLabel.textColor = RGBHex(0xA6A6A6);
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:@"￥59.9" attributes:attribtDic];
    [attri2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:8 *ScalePpth] range:NSMakeRange(0, 1)];
    oldpriceLabel.attributedText = attri2;
    [oldpriceLabel sizeToFit];
    [bottomView addSubview:oldpriceLabel];
    
    nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 38, 230, 16)];
    nameLabel.font = [UIFont systemFontOfSize:16 *ScalePpth];
    nameLabel.textColor = RGBHex(0x444444);
    nameLabel.text = @"北美进口车厘子JJ级450g/盒";
    [bottomView addSubview:nameLabel];
    
    numLabel = [[UILabel alloc] initWithFrame:AutoFrame(265, 42, 100, 13)];
    numLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    numLabel.textColor = RGBHex(0xA7A7A7);
    numLabel.text = @"已售10908";
    numLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:numLabel];
}

- (void)segmentBar:(YTSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    [ZXD_NetWorking postWithUrl:rootUrl params:@{} success:^(id  _Nonnull response) {
        
    } fail:^(NSError * _Nonnull error) {
        
    } showHUD:YES hasToken:YES];
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return UITableViewAutomaticDimension;
    }
    return 40*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 55 *ScalePpth;
    }
    return 5*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.middleHeaderView;
    }
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        CommodityImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommodityImageCell" forIndexPath:indexPath];
        WeakSelf;
        if (cell.htmlLabel.attributedText.length == 0) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                StrongSelf;
                NSString *html = strongSelf ->_goodInfoModel.content NonNull;
                NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",ScreenWidth - 20*ScalePpth,html];
                NSAttributedString *attStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentOption:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                dispatch_sync(dispatch_get_main_queue(), ^{
                  cell.htmlLabel.attributedText = attStr;
                  [tableView reloadData];
                });
            });
            
        }
        return cell;
    }  else {
        CenterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CenterTableCell" forIndexPath:indexPath];
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.section == 0 && indexPath.row == 0) {
            _cell = cell;
        }
        if (indexPath.section == 0) {
            cell.nameLabel.text = @[@"规格",@"配送",@"优惠"][indexPath.row];
            cell.nameContentLabel.text = @[@"默认",@"免配送费",@"满200减30"][indexPath.row];
            if (indexPath.row == 2) {
                cell.nameContentLabel.layer.borderColor = RGBHex(0xE70422).CGColor;
                cell.nameContentLabel.layer.masksToBounds = YES;
                cell.nameContentLabel.layer.borderWidth = 0.5;
                cell.nameContentLabel.textColor = RGBHex(0xE70422);
                cell.nameContentLabel.layer.cornerRadius = 2*ScalePpth;
                cell.nameContentLabel.font = FontSize(12);
                cell.nameContentLabel.textAlignment = NSTextAlignmentCenter;
            }
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
       SelectionSpecificationController *ssc = [SelectionSpecificationController new];
        ssc.infoModel = _goodInfoModel;
        WeakSelf;
        ssc.dataBlock = ^(NSString * _Nonnull price, NSString * _Nonnull linePrice, NSInteger goodsCount, NSString * _Nonnull selectKey, NSString * _Nonnull selectSpec) {
            StrongSelf;
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:price];
            [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.3 *ScalePpth] range:NSMakeRange(0, 1)];
            strongSelf -> priceLabel.attributedText = attri;
            [strongSelf-> priceLabel sizeToFit];
            
            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:linePrice attributes:attribtDic];
            [attri2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:8 *ScalePpth] range:NSMakeRange(0, 1)];
            strongSelf -> oldpriceLabel.attributedText = attri2;
            [strongSelf -> oldpriceLabel sizeToFit];
            weakSelf.cell.nameContentLabel.text = selectSpec;
            weakSelf.selectKey = selectKey;
            weakSelf.goodsCount = goodsCount;
        };
        [self.navigationController pushViewController:ssc animated:YES];
    }
}

- (CGFloat)calculateTextHeight {
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[_goodInfoModel.content NonNull dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*ScalePpth]} range:NSMakeRange(0, htmlString.length)];
    CGSize textSize = [htmlString boundingRectWithSize:(CGSize){ScreenWidth - 20*ScalePpth, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return textSize.height + 20*ScalePpth;
}


@end
