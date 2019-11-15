//
//  My ConfirmMyOrderController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ConfirmMyOrderController.h"

@interface ConfirmMyOrderController ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *adressLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) PaymentGrayView *grayView;

@end

@implementation ConfirmMyOrderController {
    UIButton *footerBtn;
    UIButton *letBtn;
}

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
        footerBtn = [[UIButton alloc] initWithFrame:AutoFrame(194,14,73, 26)];
        [footerBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        
        [footerBtn setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
        [footerBtn addTarget:self action:@selector(footerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        footerBtn.layer.masksToBounds = YES;
        footerBtn.layer.cornerRadius = 13 *ScalePpth;
        footerBtn.clipsToBounds = YES;
        footerBtn.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
        footerBtn.layer.borderWidth = 0.5 *ScalePpth;
        footerBtn.titleLabel.font = FontSize(14);
        [_bottomView addSubview:footerBtn];
        
        letBtn =  [[UIButton alloc] initWithFrame:AutoFrame(277, 14, 73, 26)];
        [letBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        letBtn.titleLabel.font = FontSize(14);
        letBtn.backgroundColor = RGBHex(0xE60121);
        [letBtn setTitleColor:RGBHex(0xffffff)forState:UIControlStateNormal];
        [letBtn addTarget:self action:@selector(letBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        letBtn.clipsToBounds = YES;
        letBtn.layer.masksToBounds = YES;
        letBtn.layer.cornerRadius = 26.0 *ScalePpth/2.0;
        [_bottomView addSubview:letBtn];
    }
    return _bottomView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, 20, 100, 17)];
        _nameLabel.textColor = RGBHex(0x333333);
        _nameLabel.text = @"流沙包";
        _nameLabel.font = [UIFont boldSystemFontOfSize:17*ScalePpth];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:AutoFrame(100, 20, 200, 15)];
        _phoneLabel.textColor = RGBHex(0x333333);
        _phoneLabel.text = @"1801234567";
        _phoneLabel.font = [UIFont boldSystemFontOfSize:15*ScalePpth];
    }
    return _phoneLabel;
}
- (UILabel *)adressLabel {
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc] initWithFrame:AutoFrame(37, 48, 280, 29)];
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
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(12, 6, 351, 100)];
    whiteView.backgroundColor = RGBHex(0xffffff);
    whiteView.layer.cornerRadius = 5*ScalePpth;
    whiteView.layer.masksToBounds = YES;
    [self.view addSubview:whiteView];
    
    UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, 40, 351, 0.5)];
    line.backgroundColor = RGBHex(0xEEEEEE);
    [whiteView addSubview:line];
    
    [whiteView addSubview:self.nameLabel];
    [whiteView addSubview:self.phoneLabel];
    
    UIImageView *imgeView = [[UIImageView alloc] initWithFrame:AutoFrame(18, 49, 11, 14)];
    imgeView.image = [UIImage imageNamed:@"home_location"];
    [whiteView addSubview:imgeView];
    [whiteView addSubview:self.adressLabel];
    
    [self setCenterView];
    [self setBottomView];
    [self.view addSubview:self.bottomView];
}

- (void)setCenterView {
    
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(12, 111.5, 351, 165)];
    whiteView.backgroundColor = RGBHex(0xffffff);
    whiteView.layer.cornerRadius = 5*ScalePpth;
    whiteView.layer.masksToBounds = YES;
    [self.view addSubview:whiteView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, 9.5, 100, 13)];
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text = @"商品详情";
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(93,136, 241, 14.2)];
    label.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *numberText;
    label.font = FontSize(10);
    label.textColor = RGBHex(0x333333);
    numberText=  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%@件商品    合计：¥ %@",@1,@"52100"]];
    [numberText addAttribute:NSForegroundColorAttributeName value:RGBHex(0xCF392A) range:NSMakeRange(12, 7)];
    [numberText addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(13, 6)];
    label.attributedText = numberText;
    [whiteView addSubview:label];
}

- (void)setBottomView {
    UIView *whiteView = [[UIView alloc] initWithFrame:AutoFrame(12,(346.5-64), 351, 256)];
    whiteView.backgroundColor = RGBHex(0xffffff);
    whiteView.layer.cornerRadius = 5*ScalePpth;
    whiteView.layer.masksToBounds = YES;
    [self.view addSubview:whiteView];
    
    NSArray *nameArray = @[@"订单编号",@"订单时间",@"支付方式",@"配送方式",@"订单状态",@"备注"];
    NSArray *rightArray = @[@"1124560231644",@"2019-01-16 10:28:33",@"微信支付",@"免配送费",@"待付款",@""];
    for (NSInteger i = 0; i < 6; i ++) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(18, (14+i*40.5), 100, 13)];
        nameLabel.textColor = RGBHex(0x333333);
        nameLabel.text = nameArray[i];
        nameLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
        [whiteView addSubview:nameLabel];
        
        if (i < 5) {
            UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, (40+i*40.5), 351, 0.5)];
            line.backgroundColor = RGBHex(0xEEEEEE);
            [whiteView addSubview:line];
        }
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(133, (14+i*40.5), 200, 13)];
        rightLabel.textColor = RGBHex(0x333333);
        if (i == 1) {
            rightLabel.textColor = RGBHex(0xE70422);
        }
        rightLabel.text = rightArray[i];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
        [whiteView addSubview:rightLabel];
    }
}
- (void)payButtonAction:(UIButton *)button {
    [[UIApplication sharedApplication].keyWindow addSubview:self.grayView];
}

- (void)footerBtnAction:(UIButton *)button {
    
}
- (void)letBtnAction:(UIButton *)button {
    
}

@end
