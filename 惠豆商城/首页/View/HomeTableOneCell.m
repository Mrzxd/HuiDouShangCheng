



//
//  HomeTableOneCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "HomeTableOneCell.h"

@implementation HomeTableOneCell

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
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(12.5, 27.5, 75, 5)];
    lineView.backgroundColor = RGBHex(0xFF5F56);
    [self.contentView addSubview:lineView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(12.5,13.5, 100, 19)];
    label.text = @"附近门店";
    label. textColor = RGBHex(0x333333);
    label.font =[UIFont boldSystemFontOfSize:19*ScalePpth];
    [self.contentView addSubview:label];
    
   
    
    _oneButton = [[UIButton alloc] initWithFrame:AutoFrame(128.5, 17, 70, 14.5)];
    _oneButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.5*ScalePpth];
    [_oneButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [_oneButton setTitle:@"美食汇" forState:UIControlStateNormal];
    [self.contentView addSubview:_oneButton];
    
    _twoButton = [[UIButton alloc] initWithFrame:AutoFrame(207.5, 17, 70, 14.5)];
    _twoButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.5*ScalePpth];
    [_twoButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [_twoButton setTitle:@"会员专属" forState:UIControlStateNormal];
    [self.contentView addSubview:_twoButton];
    
    _leftImageView = [[UIImageView alloc] initWithFrame:AutoFrame(16.5, 56, 48, 48)];
    _leftImageView.image = [UIImage imageNamed:@"zhanwei"];
    _leftImageView.layer.masksToBounds = YES;
    _leftImageView.layer.cornerRadius = 24*ScalePpth;
    [self.contentView addSubview:_leftImageView];
    
    _centerLabel = [[UILabel alloc] initWithFrame:AutoFrame(76.5, 60, 190, 15)];
    _centerLabel.font = [UIFont boldSystemFontOfSize:15*ScalePpth];
    _centerLabel.text = @"luckin coffee瑞幸咖啡门店";
    _centerLabel.textColor = RGBHex(0x333333);
    [self.contentView addSubview:_centerLabel];
    
    _bottomLabel = [[UILabel alloc] initWithFrame:AutoFrame(76.5, 85.5, 190, 10)];
    _bottomLabel.font = [UIFont systemFontOfSize:10*ScalePpth];
    _bottomLabel.text = @"中关村东路118号神州优车集团总部1层";
    _bottomLabel.textColor = RGBHex(0x999999);
    [self.contentView addSubview:_bottomLabel];
    
    _rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(265, 63.5, 100, 10)];
    _rightLabel.font = [UIFont boldSystemFontOfSize:10*ScalePpth];
    _rightLabel.text = @"距离2.45公里";
    _rightLabel.textColor = RGBHex(0xFF0000);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(292, (71+47), 73, 23)];
    button.layer.cornerRadius = 11.5*ScalePpth;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = RGBHex(0xFF5F56).CGColor;
    [button setTitle:@"导航" forState:UIControlStateNormal];
    button.titleLabel.font = FontSize(12);
    [button setTitleColor:RGBHex(0xFF5F56) forState:UIControlStateNormal];
    [self.contentView addSubview:button];
}

@end
