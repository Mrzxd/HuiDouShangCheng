//
//  ZXDBaseViewController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved .
//

#import "ZXDBaseViewController.h"

@interface ZXDBaseViewController ()

@end

@implementation ZXDBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
}

- (UIButton *)backButton {
    
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(-30, 0, 35, 35);
        [_backButton setTitle:@"" forState:UIControlStateNormal];
        [_backButton setImage:[[UIImage imageNamed:@"top_left_arrow-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_backButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:19 *ScalePpth];
    _titleLabel.textColor = RGBHex(0x333333);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _titleLabel;
}
- (void)setWhiteBackButton {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 35);
    [rightButton setImage:[[UIImage imageNamed:@"de_lefttop"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [rightButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)rightButtons {
    if (!_rightButtons) {
        _rightButtons= [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButtons.frame = CGRectMake(0, 0, 35, 35);
        [_rightButtons setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
        _rightButtons.titleLabel.font = FontSize(13);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButtons];
        [_rightButtons addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButtons;
}
- (void)setTitle:(NSString *)title {
    _titleLabel.text  = title;
    [_titleLabel sizeToFit];
}
- (void)pop
{
    if (_isPresent)
        [self dismissViewControllerAnimated:YES completion:nil];
     else
         [self.navigationController popViewControllerAnimated:NO];
}

@end
