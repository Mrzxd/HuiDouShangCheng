//
//  ZXDBaseViewController.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXDBaseViewController : UIViewController

@property BOOL isPresent;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIButton *rightButtons;
@property (nonatomic, strong) UILabel *titleLabel;
- (void)setWhiteBackButton;
- (void)rightButtonAction:(UIButton *)button;

@end

NS_ASSUME_NONNULL_END
