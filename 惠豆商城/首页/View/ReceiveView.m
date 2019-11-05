//
//  ReceiveView.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ReceiveView.h"

@interface ReceiveView ()

@property (nonatomic, strong) UIView *whiteView;

@end

@implementation ReceiveView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self setUpUI];
    return self;
}

- (void)setUpUI {
    self.backgroundColor = RGBHexAlpha(0x000000, 0.6);
    [self addSubview:self.whiteView];
}

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:AutoFrame(54, 230, 267, 220)];
        _whiteView.layer.cornerRadius = 10*ScalePpth;
        _whiteView.layer.masksToBounds = YES;
        _whiteView.backgroundColor = UIColor.whiteColor;
        [self addSubViews];
    }
    return _whiteView;
}

- (void)addSubViews {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:AutoFrame(0, 19, 267, 15)];
    titleLabel.font = [UIFont boldSystemFontOfSize:15 *ScalePpth];
    titleLabel.text = @"恭喜您领取成功";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGBHex(0x000000);
    [_whiteView addSubview:titleLabel];
    
    NSArray *imageArray = @[@"",@""];
    NSArray *titleArray = @[@"x 1",@"x 2"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(104, (70+i*31), 21, 21)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [_whiteView addSubview:imageView];
        
        UILabel *numLabel = [[UILabel alloc] initWithFrame:AutoFrame(140, (76+i*31), 100, 15)];
        numLabel.font = [UIFont systemFontOfSize:15 *ScalePpth];
        numLabel.text = titleArray[i];
        numLabel.textColor = RGBHex(0x000000);
        [_whiteView addSubview:numLabel];
    }
    
    UIButton *receiveButton = [[UIButton alloc] initWithFrame:AutoFrame(43.5, 162, 180, 38)];
    receiveButton.backgroundColor = RGBHex(0xE60121);
    receiveButton.layer.cornerRadius = 19*ScalePpth;
    receiveButton.layer.masksToBounds = YES;
    [receiveButton setTitle:@"点击领取" forState:UIControlStateNormal];
    [receiveButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [receiveButton addTarget:self action:@selector(receiveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    receiveButton.titleLabel.font = FontSize(15);
    [_whiteView addSubview:receiveButton];
}

- (void)receiveButtonAction:(UIButton *)button {
    [self removeFromSuperview];
}


@end
