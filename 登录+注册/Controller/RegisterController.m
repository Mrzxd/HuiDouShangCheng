//
//  registerController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *nextpassWordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UITextField *verificationCodeField;

@end

@implementation RegisterController {
    UIButton *lastButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:AutoFrame(154, (63*ScalePpth+statusHeight)/ScalePpth, 67, 67)];
        _imageView.image = [UIImage imageNamed:@"login_logo"];
    }
    return _imageView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:AutoFrame(25,  (184*ScalePpth+statusHeight)/ScalePpth, 325, 45)];
        _phoneTextField.backgroundColor = RGBHex(0xF5F5F5);
        _phoneTextField.delegate = self;
        _phoneTextField.placeholder = @"请输入手机号码";
        _phoneTextField.font  = FontSize(15);
        _phoneTextField.layer.cornerRadius = 22.5*ScalePpth;
        _phoneTextField.layer.masksToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 14, 52, 20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"register_phone"];
        _phoneTextField.leftView = imageView;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneTextField;
}

- (UITextField *)verificationCodeField {
    if (!_verificationCodeField) {
        _verificationCodeField = [[UITextField alloc] initWithFrame:AutoFrame(25,  (249*ScalePpth+statusHeight)/ScalePpth, 325, 45)];
        _verificationCodeField.backgroundColor = RGBHex(0xF5F5F5);
        _verificationCodeField.delegate = self;
        _verificationCodeField.placeholder = @"请输入验证码";
        _verificationCodeField.font  = FontSize(15);
        _verificationCodeField.layer.cornerRadius = 22.5*ScalePpth;
        _verificationCodeField.layer.masksToBounds = YES;
        _verificationCodeField.keyboardType = UIKeyboardTypeNumberPad;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 14, 52, 20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"register_verification"];
        _verificationCodeField.leftView = imageView;
        _verificationCodeField.leftViewMode = UITextFieldViewModeAlways;
        _verificationCodeField.borderStyle = UITextBorderStyleNone;
        _verificationCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _verificationCodeField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:AutoFrame(25,  (314*ScalePpth+statusHeight)/ScalePpth, 325, 45)];
        _passwordTextField.backgroundColor = RGBHex(0xF5F5F5);
        _passwordTextField.delegate = self;
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.font  = FontSize(15);
        _passwordTextField.layer.cornerRadius = 22.5*ScalePpth;
        _passwordTextField.layer.masksToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 14, 52, 20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"register_password"];
        _passwordTextField.leftView = imageView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passwordTextField;
}
- (UITextField *)nextpassWordTextField {
    if (!_nextpassWordTextField) {
        _nextpassWordTextField = [[UITextField alloc] initWithFrame:AutoFrame(25,  (379*ScalePpth+statusHeight)/ScalePpth, 325, 45)];
        _nextpassWordTextField.backgroundColor = RGBHex(0xF5F5F5);
        _nextpassWordTextField.delegate = self;
        _nextpassWordTextField.placeholder = @"请再次输入密码";
        _nextpassWordTextField.font  = FontSize(15);
        _nextpassWordTextField.layer.cornerRadius = 22.5*ScalePpth;
        _nextpassWordTextField.layer.masksToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 14, 52, 20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"register_password"];
        _nextpassWordTextField.leftView = imageView;
        _nextpassWordTextField.leftViewMode = UITextFieldViewModeAlways;
        _nextpassWordTextField.borderStyle = UITextBorderStyleNone;
        _nextpassWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _nextpassWordTextField;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(25*ScalePpth, 479*ScalePpth +statusHeight, 325*ScalePpth, 45*ScalePpth)];
        [_loginButton setTitle:@"注册" forState:UIControlStateNormal];
        [_loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _loginButton.titleLabel.font = FontSize(16);
        _loginButton.backgroundColor = RGBHex(0xFF5044);
        _loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
        _loginButton.layer.masksToBounds = YES;
        _loginButton.clipsToBounds = YES;
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.nextpassWordTextField];
    [self.view addSubview:self.verificationCodeField];
    [self.view addSubview:self.loginButton];
    [self getVerificationCode];
}

- (void)getVerificationCode {
    UIButton *getVerificationCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(258*ScalePpth, 249*ScalePpth +statusHeight, 68*ScalePpth, 45*ScalePpth)];
    [getVerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerificationCodeButton setTitleColor:RGBHex(0xE70422) forState:UIControlStateNormal];
    [getVerificationCodeButton addTarget:self action:@selector(getVerificationCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    getVerificationCodeButton.titleLabel.font = FontSize(13);
    [self.view addSubview:getVerificationCodeButton];
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(66*ScalePpth, 432*ScalePpth +statusHeight, 250*ScalePpth, 10*ScalePpth)];
    explainLabel.font = FontSize(10);
    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 431*ScalePpth +statusHeight, 11*ScalePpth, 11*ScalePpth)];
    [yesButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    lastButton = yesButton;
    yesButton.tag = 200;
    [yesButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yesButton];
    
    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 447*ScalePpth +statusHeight, 11*ScalePpth, 11*ScalePpth)];
    [noButton setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
    noButton.tag = 201;
    [noButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noButton];
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并接受惠豆商城注册协议、用户隐私政策"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0x333333) range:NSMakeRange(0, 7)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(0xE70422) range:NSMakeRange(7, 15)];
    explainLabel.attributedText = attributedString;
    [self.view addSubview:explainLabel];
    
    UIButton *tologinButton = [[UIButton alloc] initWithFrame:CGRectMake(233*ScalePpth, 535*ScalePpth +statusHeight, 100*ScalePpth, 13*ScalePpth)];
    [tologinButton setTitle:@"已有账号去登录" forState:UIControlStateNormal];
    [tologinButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [tologinButton addTarget:self action:@selector(tologin:) forControlEvents:UIControlEventTouchUpInside];
    tologinButton.titleLabel.font = FontSize(13);
    [self.view addSubview:tologinButton];
}
- (void)getVerificationCodeButtonAction:(UIButton *)button {
    if (![self isMobileNumberOnly:_phoneTextField.text NonNull]) {
        [WHToast showErrorWithMessage:@"请输入正确的手机号码"];
        return;
    }
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/index/getCodeByPhone"]params:@{@"phone":_phoneTextField.text} success:^(id  _Nonnull response) {
        if ([response[@"status"] intValue] != 1) {
            [WHToast showErrorWithMessage:response[@"msg"]];
        }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES hasToken:NO];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phoneTextField endEditing:YES];
    [_passwordTextField endEditing:YES];
    [_verificationCodeField endEditing:YES];
    [_nextpassWordTextField endEditing:YES];
}
    
    //注册
- (void)loginButtonAction:(UIButton *)button {
    if (![self isMobileNumberOnly:_phoneTextField.text NonNull]) {
        [WHToast showErrorWithMessage:@"请输入正确的手机号码"];
        return;
    }
    if (_passwordTextField.text.length < 6) {
        [WHToast showErrorWithMessage:@"请输入6位以上密码"];
        return;
    }
    if (![_passwordTextField.text isEqualToString:_nextpassWordTextField.text]) {
        [WHToast showErrorWithMessage:@"两次输入密码不一致"];
        return;
    }
    if (_verificationCodeField.text.length < 4) {
         [WHToast showErrorWithMessage:@"请填写正确的验证码"];
        return;
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/index/userRegister"] params:@{
                                                                                                      @"tel":_phoneTextField.text,
                                                                                                      @"password":_passwordTextField.text,
                                                                                                      @"re_password":_nextpassWordTextField.text,
                                                                                                      @"code":_verificationCodeField.text,
                                                                                                      } success:^(id  _Nonnull response) {
                                                                                                          if ([response[@"status"] intValue] != 1) {
                                                                                                              [WHToast showErrorWithMessage:response[@"msg"]];
                                                                                                              [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                                                                                          } else {
                                                                                                              [WHToast showSuccessWithMessage:response[@"msg"]];
                                                                                                          }
    } fail:^(NSError * _Nonnull error) {
        [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES hasToken:NO];
}
- (void)tologin:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)buttonAction:(UIButton *)button {
    if (lastButton != button) {
        [lastButton setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        lastButton = button;
    }
}
@end

