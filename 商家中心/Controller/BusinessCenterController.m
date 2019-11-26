//
//  BusinessCenterController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "BusinessCenterController.h"

@interface BusinessCenterController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *businessLabel;

@end

@implementation BusinessCenterController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.titleLabel.textColor = UIColor.whiteColor;
    self.navigationController.navigationBar.barTintColor = RGBHex(0xE60121);
    self.view.backgroundColor = RGBHex(0xF7F6FA);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家中心";
    [self setWhiteBackButton];
    [self setUpUI];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView  = [[UIImageView alloc] initWithFrame:AutoFrame(15, 4, 75, 75)];
        _imageView.layer.cornerRadius = 37.5*ScalePpth;
        _imageView.layer.masksToBounds = YES;
        _imageView.backgroundColor = RGBHex(0xDCDCDC);
        _imageView.layer.borderColor = UIColor.whiteColor.CGColor;
        _imageView.layer.borderWidth = 0.7;
    }
    return _imageView;
}

-(UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:AutoFrame(102, 18, 120, 18)];
        _userNameLabel.textColor = UIColor.whiteColor;
        _userNameLabel.text = @"流沙包";
        _userNameLabel.font = FontSize(18);
    }
    return _userNameLabel;
}
-(UILabel *)businessLabel {
    if (!_businessLabel) {
        _businessLabel = [[UILabel alloc] initWithFrame:AutoFrame(102, 44, 120, 12)];
        _businessLabel.textColor = UIColor.whiteColor;
        _businessLabel.text = @"商家名称：店铺名称";
        _businessLabel.font = FontSize(12);
    }
    return _businessLabel;
}
- (void)setUpUI {
    UIView *redView = [[UIView alloc] initWithFrame:AutoFrame(0, 0,375, 128)];
    redView.backgroundColor = RGBHex(0xE60121);
    [self.view addSubview:redView];
    [redView addSubview:self.imageView];
    [redView addSubview:self.userNameLabel];
    [redView addSubview:self.businessLabel];
    
    UIView *centerWhiteView = [[UIView alloc] initWithFrame:AutoFrame(10, 94, 355, 140)];
    centerWhiteView.backgroundColor = UIColor.whiteColor;
    centerWhiteView.layer.cornerRadius = 5*ScalePpth;
    centerWhiteView.layer.masksToBounds = YES;
    [self.view addSubview:centerWhiteView];
    
    NSArray *array1 = @[@"1000",@"900",@"800"];
    NSArray *array2 = @[@"今日销售额",@"订单总数",@"付款人数"];
    
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *numLabel = [[UILabel alloc] initWithFrame:AutoFrame((355.0/3*i), 26.8, 355.0/3, 13.8)];
        numLabel.text = array1[i];
        numLabel.textColor = RGBHex(0x000000);
        numLabel.font = FontSize(18);
        numLabel.textAlignment = NSTextAlignmentCenter;
        [centerWhiteView addSubview:numLabel];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:AutoFrame((355.0/3*i), 51, 355.0/3, 12)];
        typeLabel.text = array2[i];
        typeLabel.textColor = RGBHex(0x999999);
        typeLabel.font = FontSize(12);
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [centerWhiteView addSubview:typeLabel];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, 90, 355, 0.5)];
    line.backgroundColor = RGBHex(0xEEEEEE);
    [centerWhiteView addSubview:line];
    
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:AutoFrame(30, 106.5, 250, 18)];
    totalLabel.textColor = RGBHex(0x000000);
    totalLabel.font = FontSize(15);
    [centerWhiteView addSubview:totalLabel];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"总收入：￥500"];
    [attri addAttribute:NSForegroundColorAttributeName value:RGBHex(0xE70422) range:NSMakeRange(4, 4)];
    [attri addAttribute:NSFontAttributeName value:FontSize(18) range:NSMakeRange(4, 4)];
    totalLabel.attributedText = attri;
    
    UIButton *cashWithdrawalButton = [[UIButton alloc] initWithFrame:AutoFrame(275, 103, 60, 25)];
    cashWithdrawalButton.backgroundColor = RGBHex(0xE60121);
    cashWithdrawalButton.layer.cornerRadius = 12.5*ScalePpth;
    cashWithdrawalButton.layer.masksToBounds = YES;
    [cashWithdrawalButton setTitle:@"提现 " forState:UIControlStateNormal];
    [cashWithdrawalButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    cashWithdrawalButton.titleLabel.font = FontSize(13);
    [cashWithdrawalButton addTarget:self action:@selector(cashWithdrawalButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerWhiteView addSubview:cashWithdrawalButton];
    
    UIView *bottomWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(centerWhiteView.frame)+10*ScalePpth, ScreenWidth, ScreenHeight - KNavigationHeight - 244*ScalePpth)];
    bottomWhiteView.backgroundColor = RGBHex(0xffffff);
    [self.view addSubview:bottomWhiteView];
    
    NSArray *array3 = @[@"收银台",@"扫一扫",@"营业概况",@"订单管理",@"商家资料"];
    for (NSInteger i = 0; i < 5; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(17, (15.5+i*50.5), 17, 17)];
        imageView.image = [UIImage imageNamed:@"AE8D7D15-DCA3-406E-86FD-DD1C367BBF0A.png"];
        [bottomWhiteView addSubview:imageView];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:AutoFrame(45, (19+i*50.5), 200, 15)];
        typeLabel.text = array3[i];
        typeLabel.textColor = RGBHex(0x404040);
        typeLabel.font = FontSize(15);
        [bottomWhiteView addSubview:typeLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, (50+i*50.5), 375, 0.5)];
        line.backgroundColor = RGBHex(0xEEEEEE);
        [bottomWhiteView addSubview:line];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:AutoFrame(355, (20.5+i*50.5), 6, 11)];
        arrowView.image = [UIImage imageNamed:@"issue_arrows"];
        [bottomWhiteView addSubview:arrowView];
        
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(0, i*50.5, 375, 50)];
        [button addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 500+i;
        [bottomWhiteView addSubview:button];
    }
}

- (void)typeButtonAction:(UIButton *)button {
    if (button.tag == 500) {
        [self.navigationController pushViewController:[CashierController new] animated:YES];
    }
}
- (void)cashWithdrawalButtonAction:(UIButton *)button {
    [self.navigationController pushViewController:[CashWithDrawalController new] animated:YES];
}





@end
