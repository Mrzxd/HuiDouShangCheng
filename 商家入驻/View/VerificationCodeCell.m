//
//  VerificationCodeCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "VerificationCodeCell.h"

@implementation VerificationCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    UILabel *_nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 18, 120, 15)];
    _nameLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    _nameLabel.text = @"验证码";
    [self.contentView addSubview:_nameLabel];
    
    UIButton *verificationButton = [[UIButton alloc] initWithFrame:AutoFrame(268, 12, 88, 25)];
    verificationButton.backgroundColor = RGBHex(0xFF5044);
    verificationButton.layer.cornerRadius = 5*ScalePpth;
    verificationButton.layer.masksToBounds = YES;
    verificationButton.titleLabel.font = FontSize(13);
    [verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verificationButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.contentView addSubview:verificationButton];
}

@end
