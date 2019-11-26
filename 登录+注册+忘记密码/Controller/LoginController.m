//
//  LoginController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "ZXDTabBarController.h"

@interface LoginController () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginController

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:AutoFrame(154, (94.5*ScalePpth+statusHeight)/ScalePpth, 67, 67)];
        _imageView.image = [UIImage imageNamed:@"login_logo"];
    }
    return _imageView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:AutoFrame(25,  (232*ScalePpth+statusHeight)/ScalePpth, 325, 45)];
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

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:AutoFrame(25,  (302*ScalePpth+statusHeight)/ScalePpth, 325, 45)];
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
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(25*ScalePpth, 397*ScalePpth +statusHeight, 325*ScalePpth, 45*ScalePpth)];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _loginButton.titleLabel.font = FontSize(16);
        _loginButton.backgroundColor = RGBHex(0xFF5044);
        _loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
        _loginButton.layer.masksToBounds = YES;
        _loginButton.clipsToBounds = YES;
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(52*ScalePpth, 455*ScalePpth +statusHeight, 60*ScalePpth, 13*ScalePpth)];
        [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [registerButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
        registerButton.titleLabel.font = FontSize(13);
        [registerButton addTarget:self action:@selector(toRegisters:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:registerButton];
        
        UIButton *forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(272*ScalePpth, 455*ScalePpth +statusHeight, 60*ScalePpth, 13*ScalePpth)];
        [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
        forgetButton.titleLabel.font = FontSize(13);
        [forgetButton addTarget:self action:@selector(forgetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forgetButton];
        
    }
    return _loginButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
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
}
- (void)loginButtonAction:(UIButton *)button {
    if (![self isMobileNumberOnly:_phoneTextField.text NonNull]) {
        [WHToast showErrorWithMessage:@"请输入正确的手机号码"];
        return;
    }
    if (_passwordTextField.text.length < 6) {
        [WHToast showErrorWithMessage:@"请输入6位数以上密码"];
        return;
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/index/userLogin"] params:@{
                                                                                                   @"type":@"2",
                                                                                                   @"account":_phoneTextField.text,
                                                                                                   @"password":_passwordTextField.text,
                                                                                                   } success:^(id  _Nonnull response) {
                                                                                                       if ([response[@"status"] intValue] != 1) {
                                                                                                           [WHToast showErrorWithMessage:response[@"msg"]];
                                                                                                       } else {
                                                                                                           [[NSUserDefaults standardUserDefaults] setObject:response[@"data"][@"token"] forKey:@"user-token"];
                                                                                                           ZXDTabBarController *tabbarVc = [ZXDTabBarController new];
                                                                                                            GlobalSingleton.gS_ShareInstance.zxdTabBarController = tabbarVc;
                                                                                                           [weakSelf presentViewController:tabbarVc animated:YES completion:nil];
                                                                                                       }
    } fail:^(NSError * _Nonnull error) {
         [WHToast showErrorWithMessage:@"网络错误"];
    } showHUD:YES hasToken:NO];
}
- (void)forgetButtonAction:(UIButton *)button {
    LBNavigationController *navi = [[LBNavigationController alloc] initWithRootViewController:[ForgetPasswordController new]];
    [self presentViewController:navi animated:YES completion:nil];
}
- (void)toRegisters:(UIButton *)button {
    [self presentViewController:[[RegisterController alloc] init] animated:YES completion:nil];
}
@end


