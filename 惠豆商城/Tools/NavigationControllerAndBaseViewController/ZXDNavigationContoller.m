//
//  ZXDNavigationContoller.m
//  YuTongInHand
//
//  Created by 张昊 on 2019/9/5.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import "ZXDNavigationContoller.h"

@interface ZXDNavigationContoller ()


@end

@implementation ZXDNavigationContoller

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}
- (void)changeBackItemToWhite {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationBar.backIndicatorImage = [[UIImage imageNamed:@"sign_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"sign_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 去掉文字
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateHighlighted];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)changeBackItemToBlack {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationBar.backIndicatorImage = [[UIImage imageNamed:@"details_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"details_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 去掉文字
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateHighlighted];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationBar.backIndicatorImage = [[UIImage imageNamed:@"details_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"details_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 去掉文字
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateHighlighted];
    self.navigationItem.backBarButtonItem = backItem;
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)changeTextTowhite {
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.barTintColor = RGBHex(0x252b33);
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

/**
 *  通过拦截push方法来设置每个push进来的控制器的返回按钮
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view并调用viewController的viewDidLoad方法。可以在viewDidLoad方法中重新设置自己想要的左上角按钮样式
    [super pushViewController:viewController animated:animated];
}


@end
