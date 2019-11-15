//
//  ConfirmationOrderController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/6.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "惠豆商城-Swift.h"
#import "ConfirmationOrderController.h"

@interface ConfirmationOrderController ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *adressLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) PaymentGrayView *grayView;

@end

@implementation ConfirmationOrderController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = RGBHex(0xFF5044);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.titleLabel.textColor = UIColor.whiteColor;
    self.view.backgroundColor = RGBHex(0xF7F6FA);
    [self.backButton setImage:[[UIImage imageNamed:@"de_lefttop"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self setUpUI];
}
- (PaymentGrayView *)grayView {
    if (!_grayView) {
        _grayView = [[PaymentGrayView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
    }
    return _grayView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:AutoFrame(0, (ScreenHeight-54*ScalePpth-KNavigationHeight)/ScalePpth, 375, 54)];
        _bottomView.backgroundColor = UIColor.whiteColor;
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(52, 20.5, 200, 14)];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.textColor = RGBHex(0x999999);
        priceLabel.text = @"还需支付：¥ 93.00";
        priceLabel.font = [UIFont systemFontOfSize:14*ScalePpth];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"还需支付：¥ 93.00"];
        [attri addAttribute:NSForegroundColorAttributeName value:RGBHex(0xE64615) range:NSMakeRange(5, 7)];
        priceLabel.attributedText = attri;
        [_bottomView addSubview:priceLabel];
        
        UIButton *payButton = [[UIButton alloc] initWithFrame:AutoFrame(267, 7, 96, 40)];
        payButton.backgroundColor = RGBHex(0xFF5044);
        payButton.layer.cornerRadius = 20*ScalePpth;
        payButton.layer.masksToBounds = YES;
        payButton.titleLabel.font = FontSize(16);
        [payButton  setTitle:@"去支付" forState:UIControlStateNormal];
        [payButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [payButton addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:payButton];
    }
    return _bottomView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, 52.5, 100, 17)];
        _nameLabel.textColor = RGBHex(0x333333);
        _nameLabel.text = @"流沙包";
        _nameLabel.font = [UIFont boldSystemFontOfSize:17*ScalePpth];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:AutoFrame(100, 52.5, 200, 15)];
        _phoneLabel.textColor = RGBHex(0x333333);
        _phoneLabel.text = @"1801234567";
        _phoneLabel.font = [UIFont boldSystemFontOfSize:15*ScalePpth];
    }
    return _phoneLabel;
}
- (UILabel *)adressLabel {
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc] initWithFrame:AutoFrame(37, 82, 280, 29)];
        _adressLabel.textColor = RGBHex(0x878787);
        _adressLabel.numberOfLines = 0;
        _adressLabel.text = @"安徽省合肥市瑶海区包图大道23号（包子小区）一栋23楼";
        _adressLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    }
    return _adressLabel;
}

- (void)setUpUI {
    UIView *redView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 82)];
    redView.backgroundColor = RGBHex(0xFF5044);
    [self.view addSubview:redView];
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(12, 6, 351, 132)];
    whiteView.backgroundColor = RGBHex(0xffffff);
    whiteView.layer.cornerRadius = 5*ScalePpth;
    whiteView.layer.masksToBounds = YES;
    [self.view addSubview:whiteView];
    
    UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, 40, 351, 0.5)];
    line.backgroundColor = RGBHex(0xEEEEEE);
    [whiteView addSubview:line];
    
    NSArray *titleArray = @[@"快递配送",@"到店自提"];
    NSArray *colorArray = @[RGBHex(0x3D3D3D),RGBHex(0xA9A9A9)];
    for (NSInteger i = 0; i < 2; i ++) {
        CGFloat space =  i == 0?77:198;
        UIButton*typeButton = [[UIButton alloc] initWithFrame:AutoFrame(space, 15, 80, 14)];
        [typeButton setTitle:titleArray[i] forState:UIControlStateNormal];
        typeButton.titleLabel.font = FontSize(14);
        [typeButton setTitleColor:colorArray[i] forState:UIControlStateNormal];
        [whiteView addSubview:typeButton];
    }
    [whiteView addSubview:self.nameLabel];
    [whiteView addSubview:self.phoneLabel];
    
    UIImageView *imgeView = [[UIImageView alloc] initWithFrame:AutoFrame(18, 82, 11, 14)];
    imgeView.image = [UIImage imageNamed:@"home_location"];
    [whiteView addSubview:imgeView];
    [whiteView addSubview:self.adressLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:AutoFrame(328, 86, 5, 9)];
    arrowView.image = [UIImage imageNamed:@"issue_arrow"];
    [whiteView addSubview:arrowView];
    [self setCenterView];
    [self setBottomView];
    [self.view addSubview:self.bottomView];
}

- (void)setCenterView {
    
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(12, 142.5, 351, 135)];
    whiteView.backgroundColor = RGBHex(0xffffff);
    whiteView.layer.cornerRadius = 5*ScalePpth;
    whiteView.layer.masksToBounds = YES;
    [self.view addSubview:whiteView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, 9.5, 100, 13)];
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text = @"云豆商城";
    nameLabel.font = [UIFont boldSystemFontOfSize:13*ScalePpth];
    [whiteView addSubview:nameLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, 30, 351, 0.5)];
    line.backgroundColor = RGBHex(0xEEEEEE);
    [whiteView addSubview:line];
    
    UIView *grayView = [[UIView alloc] initWithFrame:AutoFrame(18, 40, 315, 83)];
    grayView.backgroundColor = RGBHex(0xFAFAFA);
    grayView.layer.cornerRadius = 3*ScalePpth;
    grayView.layer.masksToBounds = YES;
    [whiteView addSubview:grayView];
    
    for (NSInteger i = 0; i < 2; i ++ ) {
        UIImageView *imgeView = [[UIImageView alloc] initWithFrame:AutoFrame((5+i*90), 5, 85, 73)];
        imgeView.image = [UIImage imageNamed:@"fruit.png"];
        imgeView.backgroundColor = RGBHex(0xffffff);
        [grayView addSubview:imgeView];
    }
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:AutoFrame(195, 36, 100, 12)];
    numLabel.textColor = RGBHex(0x999999);
    numLabel.text = @"共2件";
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    [grayView addSubview:numLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:AutoFrame(299, 37, 6, 10)];
    arrowView.image = [UIImage imageNamed:@"issue_arrow"];
    [grayView addSubview:arrowView];
}

- (void)setBottomView {
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(12,(346.5-64), 351, 161.5)];
    whiteView.backgroundColor = RGBHex(0xffffff);
    whiteView.layer.cornerRadius = 5*ScalePpth;
    whiteView.layer.masksToBounds = YES;
    [self.view addSubview:whiteView];
    
    NSArray *nameArray = @[@"商品金额",@"商品优惠",@"商品优惠券",@"配送"];
    NSArray *rightArray = @[@"￥93.7",@"￥0.7",@"1张优惠券",@"免配送费"];
    for (NSInteger i = 0; i < 4; i ++) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, (14+i*40.5), 100, 13)];
        nameLabel.textColor = RGBHex(0x333333);
        nameLabel.text = nameArray[i];
        nameLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
        [whiteView addSubview:nameLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, (40+i*40.5), 351, 0.5)];
        line.backgroundColor = RGBHex(0xEEEEEE);
        [whiteView addSubview:line];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(133, (14+i*40.5), 200, 13)];
        rightLabel.textColor = RGBHex(0x333333);
        if (i == 1 || i == 2) {
            rightLabel.textColor = RGBHex(0xE70422);
        }
        if (i == 2) {
            rightLabel.frame = AutoFrame(123, 95, 200, 13);
        }
        rightLabel.text = rightArray[i];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
        [whiteView addSubview:rightLabel];
    }
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:AutoFrame(328, 96.5, 6, 10)];
    arrowView.image = [UIImage imageNamed:@"issue_arrow"];
    [whiteView addSubview:arrowView];
}
- (void)payButtonAction:(UIButton *)button {
    [[UIApplication sharedApplication].keyWindow addSubview:self.grayView];
}


@end
