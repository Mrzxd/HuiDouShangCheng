//
//  HomeTableThreeCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "HomeTableThreeCell.h"

@interface HomeTableThreeCell ()

@property (nonatomic, strong) UIButton *lastButton;

@end

@implementation HomeTableThreeCell

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
    
    _lineView = [[UIView alloc] initWithFrame:AutoFrame(12.5, 27.5, 75, 5)];
    _lineView.backgroundColor = RGBHex(0xFF5F56);
    [self.contentView addSubview:_lineView];
    
    _typeButton = [[UIButton alloc] initWithFrame:AutoFrame(12.5,13.5, 80, 19)];
    [_typeButton setTitle: @"附近门店" forState:UIControlStateNormal];
    [_typeButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    _typeButton.titleLabel.font = [UIFont boldSystemFontOfSize:19*ScalePpth];
    _typeButton.tag = 100;
    [_typeButton addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_typeButton];
    _lastButton = _typeButton;
    
    UIButton *_typeButton2 = [[UIButton alloc] initWithFrame:AutoFrame(86,13.5, 60, 19)];
    [_typeButton2 setTitle: @"美食汇" forState:UIControlStateNormal];
    [_typeButton2 setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    _typeButton2.titleLabel.font = [UIFont boldSystemFontOfSize:14*ScalePpth];
    _typeButton2.tag = 101;
    [_typeButton2 addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_typeButton2];
    
    UIButton *_typeButton3 = [[UIButton alloc] initWithFrame:AutoFrame(143,13.5, 80, 19)];
    [_typeButton3 setTitle: @"会员专属" forState:UIControlStateNormal];
    [_typeButton3 setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    _typeButton3.titleLabel.font = [UIFont boldSystemFontOfSize:14*ScalePpth];
    _typeButton3.tag = 102;
    [_typeButton3 addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_typeButton3];
    
}

- (void)typeButtonAction:(UIButton *)button {
    _lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:14*ScalePpth];
    [_lastButton  setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [button setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:19*ScalePpth];
    _lastButton = button;
    CGRect frame = _lineView.frame;
    frame.origin.x = button.frame.origin.x - 0.6;
    frame.size.width = button.frame.size.width *1.01;
    _lineView.frame = frame;
    if (_indexBlock) {
        _indexBlock(button.tag -100);
    }
}

@end
