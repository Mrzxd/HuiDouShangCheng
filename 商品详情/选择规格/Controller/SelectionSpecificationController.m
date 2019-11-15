//
//  SelectionSpecificationController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/6.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ConfirmationOrderController.h"
#import "SelectionSpecificationController.h"

@interface SelectionSpecificationController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIButton *backButtons;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIImageView *smallImageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *explainLabel;
@property (nonatomic, strong) UIButton *selectButton1;
@property (nonatomic, strong) UIButton *selectButton2;

@end

@implementation SelectionSpecificationController {
    NSInteger index1;
    NSInteger index2;
    NSString *key;
    NSMutableAttributedString *attri;
    UILabel *numLabel;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    key = _infoModel.spec.spec.count > 1?@"00":@"0";
    [self setUpUI];
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:AutoFrame(0, 149, 375, 29)];
    }
    return _scrollView;
}
- (UIScrollView *)scrollView2 {
    if (!_scrollView2) {
        _scrollView2 = [[UIScrollView alloc] initWithFrame:AutoFrame(0, (149+83), 375, 29)];
    }
    return _scrollView2;
}
- (void)setUpUI {
    [self.view addSubview:self.imageView];
    [self.imageView addSubview:self.grayView];
    [self.view addSubview:self.backButtons];
    [self.view addSubview:self.whiteView];
    [self.view addSubview:self.smallImageView];
    [self.whiteView addSubview:self.priceLabel];
    [self.whiteView addSubview:self.numberLabel];
    [self.whiteView addSubview:self.explainLabel];
    [self.view addSubview:self.rightButton];
    
    NSArray *typeArray = @[@"口味",@"规格",@"购买数量"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, (110+83.5*i), 375, 0.5)];
        line.backgroundColor = RGBHex(0xF0F0F0);
        [self.whiteView addSubview:line];
        CGFloat height;
        if (i == 0) {
            height = 122;
        } else if (i == 1) {
            height = 206;
        } else {
            height = 297.5;
        }
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:AutoFrame(11, height, 100, 14)];
        typeLabel.font = FontSize(14);
        typeLabel.textColor = RGBHex(0x333333);
        typeLabel.text = typeArray[i];
        [self.whiteView addSubview:typeLabel];
    }
    
//    NSArray *titleArray = @[@"酸酸的",@"甜甜的",@"5斤",@"10斤"];
//    for (NSInteger i = 0; i < 4; i ++) {
//        UIButton *typeButton = [[UIButton alloc] initWithFrame:AutoFrame((10+i%2*82), (149+i/2*83), 72, 29)];
//        [typeButton setTitle:titleArray[i] forState:UIControlStateNormal];
//        typeButton.titleLabel.font = FontSize(13);
//        typeButton.layer.cornerRadius = 3.2*ScalePpth;
//        typeButton.layer.masksToBounds = YES;
//        if (i == 0 || i == 3) {
//            [typeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//            typeButton.backgroundColor = RGBHex(0xE70422);
//        } else {
//            [typeButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
//            typeButton.backgroundColor = RGBHex(0xE5E5E5);
//        }
//
//
//        [self.whiteView addSubview:typeButton];
//    }
    
    [self.whiteView addSubview:self.scrollView];
    [self.whiteView addSubview:self.scrollView2];
    
    NSInteger count = _infoModel.spec.spec.count;
    if (count >= 1) {
        for (NSInteger i = 0; i <  [_infoModel.spec.spec[0][@"value"] count]; i ++) {
            UIButton *typeButton = [[UIButton alloc] initWithFrame:AutoFrame((10+i*82), 0, 72, 29)];
            [typeButton setTitle:_infoModel.spec.spec[0][@"value"][i] forState:UIControlStateNormal];
            typeButton.titleLabel.font = FontSize(13);
            typeButton.layer.cornerRadius = 3.2*ScalePpth;
            typeButton.layer.masksToBounds = YES;
            typeButton.tag = 100 + i;
            if (i == 0) {
                [typeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                typeButton.backgroundColor = RGBHex(0xE70422);
                _selectButton1 = typeButton;
            } else {
                [typeButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
                typeButton.backgroundColor = RGBHex(0xE5E5E5);
            }
            [self.scrollView addSubview:typeButton];
            self.scrollView.contentSize = ZxdSizeMake((10+i*82+72+10), 29);
            [typeButton addTarget:self action:@selector(selectButtonOne:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    if (count >= 2) {
        for (NSInteger i = 0; i <  [_infoModel.spec.spec[1][@"value"] count]; i ++) {
            UIButton *typeButton = [[UIButton alloc] initWithFrame:AutoFrame((10+i*82), 0, 72, 29)];
            [typeButton setTitle:_infoModel.spec.spec[1][@"value"][i] forState:UIControlStateNormal];
            typeButton.titleLabel.font = FontSize(13);
            typeButton.layer.cornerRadius = 3.2*ScalePpth;
            typeButton.layer.masksToBounds = YES;
            typeButton.tag = 200 + i;
            if (i == 0) {
                _selectButton2 = typeButton;
                [typeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                typeButton.backgroundColor = RGBHex(0xE70422);
            } else {
                [typeButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
                typeButton.backgroundColor = RGBHex(0xE5E5E5);
            }
            [self.scrollView2 addSubview:typeButton];
            self.scrollView2.contentSize = ZxdSizeMake((10+i*82+72+10), 29);
            [typeButton addTarget:self action:@selector(selectButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    UIView *numberVeiw = [[UIView alloc] initWithFrame:AutoFrame(274, 292, 80, 27)];
    numberVeiw.backgroundColor = RGBHex(0xF5F5F5);
    numberVeiw.layer.cornerRadius = 13.5*ScalePpth;
    numberVeiw.layer.masksToBounds = YES;
    [self.whiteView addSubview:numberVeiw];
    
    
    numLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 7, 60, 13)];
    numLabel.textColor = RGBHex(0x333333);
    numLabel.text = @"1";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont systemFontOfSize:12 *ScalePpth];
    [numberVeiw addSubview:numLabel];
    
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
    
    NSArray *textArray = @[@"加入购物车",@"立即购买"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(i *187.5, (ScreenHeight-47*ScalePpth)/ScalePpth, 187.5, 47)];
        if (i == 0) {
            button.backgroundColor = RGBHex(0xF59A07);
        } else {
            button.backgroundColor = RGBHex(0xE70422);
        }
        button.tag = 100+i;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = FontSize(14);
        [button setTitle:textArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
- (void)selectButtonOne:(UIButton *)button {
    index1 = button.tag - 100;
    key = _infoModel.spec.spec.count > 1?[NSString stringWithFormat:@"%ld%ld",index1,index2]:[@(index1) stringValue];
    [_selectButton1 setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    _selectButton1.backgroundColor = RGBHex(0xE5E5E5);
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.backgroundColor = RGBHex(0xE70422);
    _selectButton1 = button;
    [self changeValue];
}
- (void)selectButtonTwo:(UIButton *)button {
    index2 = button.tag - 200;
    key = [NSString stringWithFormat:@"%ld%ld",index1,index2];
    [_selectButton2 setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    _selectButton2.backgroundColor = RGBHex(0xE5E5E5);
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.backgroundColor = RGBHex(0xE70422);
    _selectButton2 = button;
    [self changeValue];
}
- (void)changeValue {
    attri = nil;
    attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%ld",[NoneNull(_infoModel.spec.price[key][@"price"]) integerValue] *numLabel.text.integerValue]];
    [attri addAttribute:NSFontAttributeName value:FontSize(10.5) range:NSMakeRange(0, 1)];
    _priceLabel.attributedText = attri;
    _numberLabel.text = [NSString stringWithFormat:@"库存%@件",NoneNull(_infoModel.spec.stock[key][@"stock"])];
    if (_infoModel.spec.spec.count  == 1) {
        _explainLabel.text =  [NSString stringWithFormat: @"已选：“%@”",NoneNull(_infoModel.spec.spec[0][@"value"][index1])];
    } else if (_infoModel.spec.spec.count > 1) {
        _explainLabel.text =  [NSString stringWithFormat: @"已选：“%@、%@”",NoneNull(_infoModel.spec.spec[0][@"value"][index1]),NoneNull(_infoModel.spec.spec[1][@"value"][index2])];
    }
//    (NSString *price,NSString *linePrice,NSInteger goodsCount,NSString *selectKey,NSString *selectSpec);
    if (_dataBlock) {
        _dataBlock([NSString stringWithFormat:@"¥%ld",[NoneNull(_infoModel.spec.price[key][@"price"]) integerValue] *numLabel.text.integerValue],
                   [NSString stringWithFormat:@"¥%ld",[NoneNull(_infoModel.spec.line_price[key][@"line_price"]) integerValue] *numLabel.text.integerValue],[numLabel.text integerValue],key,_explainLabel.text);
    }
}
- (void)buttonActions:(UIButton *)button {
    [self.navigationController pushViewController:[ConfirmationOrderController new] animated:YES];
}
- (void)selectButtonAction:(UIButton *)button {
    button.selected = !button.selected;
}
- (void)buttonAction:(UIButton *)button {
    NSInteger number = numLabel.text.integerValue;
    if (button.tag == 100) {
        number --;
        number= (number > 1)?:1;
    } else {
        number ++;
    }
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
    [self changeValue];
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:AutoFrame(331, 29, 29, 29)];
        _rightButton.backgroundColor = RGBHexAlpha(0x000000, 0.5);
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.cornerRadius = 14.5 *ScalePpth;
        [_rightButton setImage:[UIImage imageNamed:@"de_righttop"] forState:UIControlStateNormal];
        //        [_rightButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, 288)];
        _grayView.backgroundColor = RGBHexAlpha(0x000000, 0.5);
    }
    return _grayView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 375, 288)];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:_infoModel.img]]];
    }
    return _imageView;
}
- (UIButton *)backButtons {
    if (!_backButtons) {
        _backButtons = [[UIButton alloc] initWithFrame:AutoFrame(15, 29, 29, 29)];
        _backButtons.backgroundColor = RGBHexAlpha(0x000000, 0.5);
        _backButtons.layer.masksToBounds = YES;
        _backButtons.layer.cornerRadius = 14.5 *ScalePpth;
        [_backButtons setImage:[UIImage imageNamed:@"de_lefttop"] forState:UIControlStateNormal];
        [_backButtons addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButtons;
}
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:AutoFrame(0, 288, 375, (ScreenHeight - 288*ScalePpth- 47*ScalePpth)/ScalePpth)];
        _whiteView.backgroundColor = UIColor.whiteColor;
    }
    return _whiteView;
}
- (UIImageView *)smallImageView {
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] initWithFrame:AutoFrame(10, 266, 117, 117)];
        _smallImageView.layer.cornerRadius = 5.2*ScalePpth;
        _smallImageView.layer.masksToBounds = YES;
        [_smallImageView sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:_infoModel.img]]];
    }
    return _smallImageView;
}
- (void)backButtonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(138, 17.5, 200, 12.2)];
        _priceLabel.textColor = RGBHex(0xCF392A);
        _priceLabel.font = [UIFont boldSystemFontOfSize:14*ScalePpth];
        attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",NoneNull(_infoModel.spec.price[key][@"price"] )]];
        [attri addAttribute:NSFontAttributeName value:FontSize(10.5) range:NSMakeRange(0, 1)];
        _priceLabel.attributedText = attri;
    }
    return _priceLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:AutoFrame(137.5, 42.5, 200, 14)];
        _numberLabel.text = [NSString stringWithFormat:@"库存%@件",NoneNull(_infoModel.spec.stock[key][@"stock"])];
        _numberLabel.textColor = RGBHex(0x666666);
        _numberLabel.font = FontSize(14);
    }
    return _numberLabel;
}
- (UILabel *)explainLabel {
    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc] initWithFrame:AutoFrame(137.5, 66, 200, 14)];
        if (_infoModel.spec.spec.count  == 1) {
             _explainLabel.text =  [NSString stringWithFormat: @"已选：“%@”",NoneNull(_infoModel.spec.spec[0][@"title"])];
        } else if (_infoModel.spec.spec.count > 1) {
             _explainLabel.text =  [NSString stringWithFormat: @"已选：“%@、%@”",NoneNull(_infoModel.spec.spec[0][@"title"]),NoneNull(_infoModel.spec.spec[1][@"title"])];
        }
       
        _explainLabel.textColor = RGBHex(0x666666);
        _explainLabel.font = FontSize(14);
    }
    return _explainLabel;
}


@end
