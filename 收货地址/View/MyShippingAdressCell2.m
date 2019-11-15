
//
//  MyShippingAdressCell2.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/9.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "MyShippingAdressCell2.h"

@interface MyShippingAdressCell2 ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *adressLabel;

@end

@implementation MyShippingAdressCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(52, 15, 0, 0)];
        _nameLabel.font = FontSize(15);
        _nameLabel.text = @"张小仙子";
        _nameLabel.textColor = RGBHex(0x333333);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:AutoFrame((CGRectGetMaxX(self.nameLabel.frame)+14*ScalePpth)/ScalePpth, 19, 200, 9.6)];
        _phoneLabel.font = FontSize(12);
        _phoneLabel.textColor = RGBHex(0x999999);
        _phoneLabel.text = @"13040685972";
    }
    return _phoneLabel;
}

- (UILabel *)adressLabel {
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc] initWithFrame:AutoFrame(52, 36, 250, 33)];
        _adressLabel.font = FontSize(13);
        _adressLabel.textColor = RGBHex(0x333333);
        _adressLabel.text = @"山东省 济南市 槐荫区 前城杰座";
        _adressLabel.numberOfLines = 0;
    }
    return _adressLabel;
}

- (void)setUI {
    _selectButton = [[UIButton alloc] initWithFrame:AutoFrame(0, 5.5, 58, 58)];
    [_selectButton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateNormal];
    [self.contentView addSubview:_selectButton];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.adressLabel];
    WeakSelf;
    [_adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(52*ScalePpth);
        make.width.mas_equalTo(250*ScalePpth);
        make.top.equalTo(weakSelf.contentView).offset(36*ScalePpth);
        make.bottom.equalTo(weakSelf.contentView).offset(-15*ScalePpth);
    }];
    
    [self addSubViews];
}

- (void)addSubViews {
    UIView *line = [[UIView alloc] initWithFrame:AutoFrame(322, 29.5, 0.5, 21)];
    line.backgroundColor = RGBHex(0xEEEEEE);
    [self.contentView addSubview:line];
    UIButton *editButton = [[UIButton alloc] initWithFrame:AutoFrame(328, 12, 40, 40)];
    [editButton setImage:[UIImage imageNamed:@"E06C5CD9-E07C-4E6B-8DA0-06EC62D7F70A.png"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:editButton];
}
    
- (void)editButtonAction:(UIButton *)button {
    if (_MyShippingAdressCell2Delegate && [_MyShippingAdressCell2Delegate respondsToSelector:@selector(toEditNewAdressResult:)]) {
         [_MyShippingAdressCell2Delegate toEditNewAdressResult:_addressModel];
    }
}

- (void)setAddressModel:(AddressModel *)addressModel {
    _addressModel = addressModel;
    if (addressModel) {
        self.nameLabel.text = NoneNull(addressModel.name);
        self.phoneLabel.text = NoneNull(addressModel.phone);
        self.adressLabel.text = NoneNull(addressModel.address);
    }
}
@end
