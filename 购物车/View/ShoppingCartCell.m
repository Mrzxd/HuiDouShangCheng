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
    UILabel *nameLabel;
    UILabel *weightLabel;
    UILabel *priceLabel;
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
    
    _selectButton = [[UIButton alloc] initWithFrame:AutoFrame(0, 31, 48, 48)];
    [_selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateSelected];
    [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectButton];
    [self.contentView addSubview:self.leftImageView];
    
    nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(141, 14.5, 200, 13)];
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text = @"惠豆定制玻璃杯纪念品生日礼物";
    nameLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    [self.contentView addSubview:nameLabel];
    
    weightLabel = [[UILabel alloc] initWithFrame:AutoFrame(141, 32.5, 60, 15)];
    weightLabel.textColor = RGBHex(0x999999);
    weightLabel.text = @"12克拉";
    weightLabel.backgroundColor = RGBHex(0xeeeeee);
    weightLabel.layer.masksToBounds = YES;
    weightLabel.layer.cornerRadius = 2*ScalePpth;
    weightLabel.textAlignment = NSTextAlignmentCenter;
    weightLabel.font = [UIFont systemFontOfSize:10 *ScalePpth];
    [self.contentView addSubview:weightLabel];
    
    priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(141, 85, 100, 13.5)];
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
    
    
    _numberLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 7, 60, 13)];
    _numberLabel.textColor = RGBHex(0x333333);
    _numberLabel.text = @"1";
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.font = [UIFont systemFontOfSize:12 *ScalePpth];
    [numberVeiw addSubview:_numberLabel];
    
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
    if (_buttonBlock) {
        if (button.selected) {
            _buttonBlock(_model.price.floatValue *_numberLabel.text.integerValue);
        } else {
            _buttonBlock(0.0);
        }
    }
}
- (void)buttonAction:(UIButton *)button {
      NSInteger number = _numberLabel.text.integerValue;
    if (button.tag == 100) {
        number --;
        number= (number >= 1)?number:1;
    } else {
        number ++;
    }
    _numberLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
    self.selectButton.selected = YES;
    if (_buttonBlock) {
        _buttonBlock(0.0);
    }
    if (_numberBlock) {
        _numberBlock(_numberLabel.text);
    }
}

- (void)setModel:(GetMyCartModel *)model {
    _model = model;
    if (model) {
        nameLabel.text = NoneNull(model.title);
        weightLabel.text = NoneNull(model.spec);
        [weightLabel sizeToFit];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",NoneNull(model.price)]];
        [attri addAttribute:NSFontAttributeName value:FontSize(8.7) range:NSMakeRange(0, 1)];
        priceLabel.attributedText = attri;
        _numberLabel.text = NoneNull(model.num);
    }
}

@end
