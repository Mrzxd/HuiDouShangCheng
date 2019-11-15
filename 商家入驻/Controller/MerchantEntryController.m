//
//  MerchantEntryController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "SettledInDepositCell.h"
#import "PublishImageTableCell.h"
#import "VerificationCodeCell.h"
#import "EmployerCertificationOneCell.h"
#import "EmployerCertificationTexyfieldCell.h"
#import "MerchantEntryController.h"

@interface MerchantEntryController ()  <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *footerView;

@end

@implementation MerchantEntryController  {
    UIButton *lastButton;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 135)];
        _footerView.backgroundColor = UIColor.whiteColor;
        UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 10*ScalePpth, 11*ScalePpth, 11*ScalePpth)];
        [yesButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        lastButton = yesButton;
        yesButton.tag = 200;
        [yesButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:yesButton];
        
        UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 27*ScalePpth, 11*ScalePpth, 11*ScalePpth)];
        [noButton setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
        noButton.tag = 201;
        [noButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:noButton];
        
        UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(66*ScalePpth, 10*ScalePpth, 250*ScalePpth, 10*ScalePpth)];
        explainLabel.font = FontSize(10);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意《商家申请条款》"];
        [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0x333333) range:NSMakeRange(0, 7)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0xE70422) range:NSMakeRange(7, 8)];
        explainLabel.attributedText = attributedString;
        [_footerView addSubview:explainLabel];
        
        UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(25*ScalePpth, 55*ScalePpth, 325*ScalePpth, 45*ScalePpth)];
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        submitButton.titleLabel.font = FontSize(17);
        submitButton.backgroundColor = RGBHex(0xFF5044);
        submitButton.layer.cornerRadius = 45.0/2*ScalePpth;
        submitButton.layer.masksToBounds = YES;
        submitButton.clipsToBounds = YES;
        [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:submitButton];
    }
    return _footerView;
}
- (void)submitAction:(UIButton *)button {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家入驻";
    [self.view addSubview:self.tableView];
}
- (void)buttonAction:(UIButton *)button {
    if (lastButton != button) {
        [lastButton setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        lastButton = button;
    }
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KNavigationHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[SettledInDepositCell class] forCellReuseIdentifier:@"SettledInDepositCell"];
        [_tableView registerClass:[PublishImageTableCell class] forCellReuseIdentifier:@"PublishImageTableCell"];
        [_tableView registerClass:[VerificationCodeCell class] forCellReuseIdentifier:@"VerificationCodeCell"];
        [_tableView registerClass:[EmployerCertificationOneCell class] forCellReuseIdentifier:@"EmployerCertificationOneCell"];
        [_tableView registerClass:[EmployerCertificationTexyfieldCell class] forCellReuseIdentifier:@"EmployerCertificationTexyfieldCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.0000000001, 0.0000000001)];
        _tableView.tableFooterView = self.footerView;
        _tableView.backgroundColor = UIColor.whiteColor;
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
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 9 || indexPath.row == 10) {
        return 167*ScalePpth;
    }
    return 50*ScalePpth;
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
    if (indexPath.row ==  2) {
        EmployerCertificationOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationOneCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row != 2 && indexPath.row < 8) {
         EmployerCertificationTexyfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployerCertificationTexyfieldCell" forIndexPath:indexPath];
        cell.nameLabel.text = @[@"法人姓名",@"商户名称",@"位置信息",@"详细地址",@"身份证号",@"开户银行",@"银行卡号",@"手机号码"][indexPath.row];
        return cell;
    } else if (indexPath.row == 8) {
        VerificationCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VerificationCodeCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 11) {
        SettledInDepositCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettledInDepositCell" forIndexPath:indexPath];
        return cell;
    } else {
        PublishImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishImageTableCell" forIndexPath:indexPath];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@[@"门店照片 (图片仅支持png，jpg格式最多三张)                                  ",@"营业执照 (支持扩展名：.rar .zip .doc .docx .pdf .jpg）  "][indexPath.row-9]];
        [attri addAttribute:NSFontAttributeName value:FontSize(12) range:NSMakeRange(5, 38)];
        [attri addAttribute:NSForegroundColorAttributeName value:RGBHex(0xcccccc) range:NSMakeRange(5, 38)];
        cell.nameLabel.attributedText = attri;
        WeakSelf;
        __weak typeof(cell) weakCell = cell;
        cell.buttonBlock = ^(UIButton * _Nonnull button) {
            
            [weakSelf pickImageWithCompletionHandler:^(NSData *imageData, UIImage *image) {
                if (image) {
                    [button setImage:image forState:UIControlStateNormal];
                    if (button.tag == 300) {
                        weakCell.imageButton1.hidden = NO;
                    } else if (button.tag == 301) {
                        weakCell.imageButton2.hidden = NO;
                    }
                    button.enabled = NO;
                }
            }];
        };
        return cell;
    }
}

@end
