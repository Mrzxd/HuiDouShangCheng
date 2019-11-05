

//
//  HomeTableFourCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "HomeTableFourCell.h"

@implementation HomeTableFourCell

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
    _leftImageView = [[UIImageView alloc] initWithFrame:AutoFrame(13.5, 15, 94, 94)];
    _leftImageView.image = [UIImage imageNamed:@"zhanwei3"];
    [self.contentView addSubview:_leftImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(127.5, 17, 190, 14)];
    _nameLabel.font = [UIFont boldSystemFontOfSize:14*ScalePpth];
    _nameLabel.text = @"巧克力蛋糕生日蛋糕定制";
    _nameLabel.textColor = RGBHex(0x333333);
    [self.contentView addSubview:_nameLabel];
    
    _explainLabel = [[UILabel alloc] initWithFrame:AutoFrame(128, 36.5, 100, 15)];
    _explainLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    _explainLabel.text = @"店铺券满100减10";
    _explainLabel.textColor = RGBHex(0xE70422);
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    _explainLabel.layer.masksToBounds = YES;
    _explainLabel.layer.cornerRadius = 1.56*ScalePpth;
    _explainLabel.backgroundColor = RGBHexAlpha(0xE70422, 0.1);
    [self.contentView addSubview:_explainLabel];
    
    _numberLabel = [[UILabel alloc] initWithFrame:AutoFrame(127, 60, 190, 10)];
    _numberLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    _numberLabel.text = @"1120人付款";
    _numberLabel.textColor = RGBHex(0x999999);
    [self.contentView addSubview:_numberLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(128, 89.5, 190, 16)];
    _priceLabel.font = [UIFont boldSystemFontOfSize:16*ScalePpth];
    _priceLabel.text = @"会员价：￥29.90";
    _priceLabel.textColor = RGBHex(0xE70422);
    [self.contentView addSubview:_priceLabel];
}

@end
