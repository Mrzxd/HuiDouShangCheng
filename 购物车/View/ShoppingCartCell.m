//
//  ShoppingCartCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ShoppingCartCell.h"

@interface ShoppingCartCell ()

@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation ShoppingCartCell {
    UILabel *numberLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:AutoFrame(45.5, 15, 80, 80)];
        _leftImageView.backgroundColor = RGBHex(0xF5F5F5);
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = 2*ScalePpth;
    }
    return _leftImageView;
}

- (void)setUpUI {
    
    UIButton *selectButton = [[UIButton alloc] initWithFrame:AutoFrame(0, 31, 48, 48)];
    [selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectButton];
    [self.contentView addSubview:self.leftImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(141, 14.5, 200, 13)];
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text = @"惠豆定制玻璃杯纪念品生日礼物";
    nameLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [self.contentView addSubview:nameLabel];
    
    UILabel *weightLabel = [[UILabel alloc] initWithFrame:AutoFrame(141, 32.5, 60, 15)];
    weightLabel.textColor = RGBHex(0x999999);
    weightLabel.text = @"12克拉";
    weightLabel.backgroundColor = RGBHex(0xeeeeee);
    weightLabel.layer.masksToBounds = YES;
    weightLabel.layer.cornerRadius = 2*ScalePpth;
    weightLabel.textAlignment = NSTextAlignmentCenter;
    weightLabel.font = [UIFont systemFontOfSize:10 *ScalePpth];
    [self.contentView addSubview:weightLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(141, 85, 100, 13.5)];
    priceLabel.textColor = RGBHex(0xE70422);
    priceLabel.font = [UIFont systemFontOfSize:13.5 *ScalePpth];
    [self.contentView addSubview:priceLabel];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"¥52100"];
    [attri addAttribute:NSFontAttributeName value:FontSize(8.7) range:NSMakeRange(0, 1)];
    priceLabel.attributedText = attri;
    
    UIView *numberVeiw = [[UIView alloc] initWithFrame:AutoFrame(256, 68, 80, 27)];
    numberVeiw.backgroundColor = RGBHex(0xF5F5F5);
    numberVeiw.layer.cornerRadius = 13.5*ScalePpth;
    numberVeiw.layer.masksToBounds = YES;
    [self.contentView addSubview:numberVeiw];
    
    
    numberLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 7, 60, 13)];
    numberLabel.textColor = RGBHex(0x333333);
    numberLabel.text = @"2";
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.font = [UIFont systemFontOfSize:12 *ScalePpth];
    [numberVeiw addSubview:numberLabel];
    
    UIButton *reduceButton = [[UIButton alloc] initWithFrame:AutoFrame(0, -2.5, 32, 32)];
    [reduceButton setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
    [reduceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    reduceButton.tag = 100;
    [numberVeiw addSubview:reduceButton];
    
    UIButton *summationButton = [[UIButton alloc] initWithFrame:AutoFrame(48, -2.5, 32, 32)];
    [summationButton setImage:[UIImage imageNamed:@"summation"] forState:UIControlStateNormal];
    [summationButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    summationButton.tag = 101;
    [numberVeiw addSubview:summationButton];
    
}
- (void)selectButtonAction:(UIButton *)button {
    button.selected = !button.selected;
}
- (void)buttonAction:(UIButton *)button {
      NSInteger number = numberLabel.text.integerValue;
    if (button.tag == 100) {
        number --;
        number= (number >= 0)?number:0;
    } else {
        number ++;
    }
    numberLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
}

@end
