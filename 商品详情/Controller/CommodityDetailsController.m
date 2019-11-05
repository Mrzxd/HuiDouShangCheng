//
//  CommodityDetailsController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/5.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "CenterTableCell.h"
#import "CommodityImageCell.h"
#import "ZLImageViewDisplayView.h"
#import "CommodityDetailsController.h"

@interface CommodityDetailsController () <UITableViewDelegate,UITableViewDataSource,YTSegmentBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *middleHeaderView;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) YTSegmentBar *segmentBar;
@property (nonatomic, strong) ZLImageViewDisplayView *headerImageView;

@end

@implementation CommodityDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.backButton];
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:AutoFrame(15, 29, 29, 29)];
        _backButton.backgroundColor = RGBHexAlpha(0x000000, 0.5);
        _backButton.layer.masksToBounds = YES;
        _backButton.layer.cornerRadius = 14.5 *ScalePpth;
        [_backButton setImage:[UIImage imageNamed:@"top_left_arrow-1"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
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
    NSArray *imageArray = @[@"star.png",@"car.png",@"person.png"];
    NSArray *titleArray = @[@"收藏",@"购物车",@"客服"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(i *45, 0, 45, 32.5)];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
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
    [joinButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_footerView addSubview:joinButton];
    
    UIButton *buyButton = [[UIButton alloc] initWithFrame:AutoFrame(255, 0 , 120, 50)];
    buyButton.backgroundColor = RGBHex(0xE70422);
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    buyButton.titleLabel.font = FontSize(17);
    [buyButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_footerView addSubview:buyButton];
}
- (void)addSubViews {
    [self.headerView addSubview:self.headerImageView];
    UIView *bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, 375, 375, 70)];
    bottomView.backgroundColor = UIColor.whiteColor;
    [_headerView addSubview:bottomView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 8, 0, 18.5)];
    priceLabel.font = [UIFont boldSystemFontOfSize:21 *ScalePpth];
    priceLabel.textColor = RGBHex(0xFE2448);
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"￥39.9"];
    [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.3 *ScalePpth] range:NSMakeRange(0, 1)];
    priceLabel.attributedText = attri;
    [priceLabel sizeToFit];
    [bottomView addSubview:priceLabel];
    
    UILabel *oldpriceLabel = [[UILabel alloc] initWithFrame:AutoFrame((CGRectGetMaxX(priceLabel.frame)+4*ScalePpth)/ScalePpth, 17, 0, 10)];
    oldpriceLabel.font = [UIFont boldSystemFontOfSize:10 *ScalePpth];
    oldpriceLabel.textColor = RGBHex(0xA6A6A6);
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:@"￥59.9" attributes:attribtDic];
    [attri2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:8 *ScalePpth] range:NSMakeRange(0, 1)];
    oldpriceLabel.attributedText = attri2;
    [oldpriceLabel sizeToFit];
    [bottomView addSubview:oldpriceLabel];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 38, 230, 16)];
    nameLabel.font = [UIFont systemFontOfSize:16 *ScalePpth];
    nameLabel.textColor = RGBHex(0x444444);
    nameLabel.text = @"北美进口车厘子JJ级450g/盒";
    [bottomView addSubview:nameLabel];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:AutoFrame(265, 42, 100, 13)];
    numLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    numLabel.textColor = RGBHex(0xA7A7A7);
    numLabel.text = @"已售10908";
    numLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:numLabel];
}

- (void)segmentBar:(YTSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 375 *ScalePpth;
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
        return cell;
    }  else {
        CenterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CenterTableCell" forIndexPath:indexPath];
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryNone;
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




@end
