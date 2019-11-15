//
//  NewAddressController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "NewAddressController.h"
#import "MyShippingAddressController.h"

@interface NewAddressController () <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *addressContentLabel;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectIdArray;
@property (nonatomic, strong) NSMutableArray *textFieldArray;
@property (nonatomic, strong) NSString *sex;

@property (nonatomic, assign) NSInteger selectRow1;
@property (nonatomic, assign) NSInteger selectRow2;
@property (nonatomic, assign) NSInteger selectRow3;
@property (nonatomic, assign) NSInteger isDefault;

@property (nonatomic, strong) UISwitch *switchs;

@end

@implementation NewAddressController

- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc] initWithFrame:self.view.bounds];
        _grayView.backgroundColor = RGBHexAlpha(0x000000, 0.6);
        [_grayView addSubview:self.whiteView];
    }
    return _grayView;
}

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 297*ScalePpth, ScreenWidth, 297*ScalePpth)];
        _whiteView.backgroundColor = UIColor.whiteColor;
        UIButton *cancleButton = [[UIButton alloc] initWithFrame:AutoFrame(0, 0, 60, 57)];
        [cancleButton setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
        [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        cancleButton.titleLabel.font = FontSize(16);
        [cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:cancleButton];
        
        UIButton *sureButton = [[UIButton alloc] initWithFrame:AutoFrame(315, 0, 60, 57)];
        [sureButton setTitleColor:RGBHex(0xE01212) forState:UIControlStateNormal];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        sureButton.titleLabel.font = FontSize(16);
        [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:sureButton];
        [_whiteView addSubview:self.pickerView];
    }
    
    return _whiteView;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:AutoFrame(0, 57, 375, 240)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
- (void)cancleAction:(UIButton *)button {
    [_grayView removeFromSuperview];
}
- (void)sureAction:(UIButton *)button {
    [_grayView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增地址";
    _sex = @"男";
    _isDefault = 1;
    _selectRow1 = _selectRow2 = _selectRow3  = 0;
    _textFieldArray = [NSMutableArray new];
    NSArray *array1 = @[@"联系人：",@"手机号：",@"详细地址："];
    NSArray *array2 = @[@"请输入姓名",@"请输入手机号码",@"详细地址（例如：3号楼5层501室）"];
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *_nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(19, (28+102*i), 140, 14)];
        _nameLabel.font  = [UIFont systemFontOfSize:14*ScalePpth];
        _nameLabel.textColor = RGBHex(0x333333);
        _nameLabel.text = array1[i];
        [self.view addSubview:_nameLabel];
        
        UITextField *_textField = [[UITextField alloc] initWithFrame:CGRectMake(100*ScalePpth, (15.5+102*i)*ScalePpth, 280*ScalePpth, 40*ScalePpth)];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = FontSize(15);
        _textField.delegate = self;
        _textField.placeholder = array2[i];
        [self.view addSubview:_textField];
        [_textFieldArray addObject:_textField];
    }
    
    NSArray *typeArray = @[@"女士",@"先生"];
    for (NSInteger i = 0; i < 2; i ++) {
        UILabel *_nameLabel = [[UILabel alloc] initWithFrame:AutoFrame((124+i*80.5), 79, 30, 13)];
        _nameLabel.font  = [UIFont systemFontOfSize:13*ScalePpth];
        _nameLabel.textColor = RGBHex(0x333333);
        _nameLabel.text = typeArray[i];
        [self.view addSubview:_nameLabel];
        
        UIButton *selectButton = [[UIButton alloc] initWithFrame:AutoFrame((81.5+i*80.5), 60.5, 40, 40)];
        selectButton.tag = 100+i;
        [selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        if (i == 1) {
            [selectButton setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateNormal];
            _selectButton = selectButton;
        }
        [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectButton];
    }
    UILabel *_addressLabel = [[UILabel alloc] initWithFrame:AutoFrame(20, 180, 140, 14)];
    _addressLabel.font  = [UIFont systemFontOfSize:14*ScalePpth];
    _addressLabel.textColor = RGBHex(0x333333);
    _addressLabel.text = @"所在地区：";
    [self.view addSubview:_addressLabel];
    
    _addressContentLabel = [[UILabel alloc] initWithFrame:AutoFrame(100, 180, 260, 14)];
    _addressContentLabel.font  = [UIFont systemFontOfSize:14*ScalePpth];
    _addressContentLabel.textColor = RGBHex(0x333333);
    [self.view addSubview:_addressContentLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:AutoFrame(333, 182, 7.5, 12.5)];
    arrowView.image = [UIImage imageNamed:@"issue_arrows"];
    [self.view addSubview:arrowView];
    
    UILabel *_addressLabel2 = [[UILabel alloc] initWithFrame:AutoFrame(20, 280, 140, 14)];
    _addressLabel2.font  = [UIFont systemFontOfSize:14*ScalePpth];
    _addressLabel2.textColor = RGBHex(0x333333);
    _addressLabel2.text = @"设为默认地址:";
    [self.view addSubview:_addressLabel2];
    
    _switchs = [[UISwitch alloc] initWithFrame:AutoFrame(309,278, 30, 18)];
    _switchs.on = YES;
    _switchs.onTintColor = RGBHex(0xE70422);
    _switchs.thumbTintColor = [UIColor whiteColor];
    _switchs.tintColor = [UIColor blueColor];
    _switchs.layer.cornerRadius = 14*ScalePpth;
    _switchs.layer.masksToBounds = YES;
    _switchs.clipsToBounds = YES;
    _switchs.backgroundColor = UIColor.lightGrayColor;
    [_switchs addTarget:self action:@selector(valueChangedMethod:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_switchs];
    
    UIButton *_loginButton = [[UIButton alloc] initWithFrame:CGRectMake(15*ScalePpth, 333*ScalePpth, 345*ScalePpth, 40*ScalePpth)];
    [_loginButton setTitle:@"保存" forState:UIControlStateNormal];
    [_loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _loginButton.titleLabel.font = FontSize(16);
    _loginButton.backgroundColor = RGBHex(0xFF5044);
    _loginButton.layer.cornerRadius = 40/2*ScalePpth;
    _loginButton.layer.masksToBounds = YES;
    _loginButton.clipsToBounds = YES;
    [_loginButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    for (NSInteger i = 0; i < 6; i ++) {
        UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(20, (60+i*50), 335, 0.5)];
        lineView.backgroundColor = RGBHex(0xEEEEEE);
        [self.view addSubview:lineView];
    }
    UIButton *alphaButton = [[UIButton alloc] initWithFrame:AutoFrame(75, 160, 300, 51)];
    [alphaButton addTarget:self action:@selector(alphaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alphaButton];
}
- (void)alphaButtonAction:(UIButton *)button {
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/index/getAreaValue"] params:@{} success:^(id  _Nonnull response) {
        if (response && [response[@"status"] intValue] == 1) {
            weakSelf.dataArray = response[@"data"];
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.grayView];
        }
    } fail:^(NSError * _Nonnull error) {} showHUD:YES hasToken:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textFieldArray enumerateObjectsUsingBlock:^(UITextField  *textField, NSUInteger idx, BOOL * _Nonnull stop) {
        [textField endEditing:YES];
    }];
}
- (void)connectToTheNetwork {
    UITextField *nameTextField = _textFieldArray[0];
    UITextField *phoneTextField = _textFieldArray[1];
    UITextField *addressTextField = _textFieldArray[2];
    if (nameTextField.text.length < 2) {
        [WHToast showErrorWithMessage:@"请填写联系人"];
        return;
    }
    if (![self isMobileNumberOnly:phoneTextField.text NonNull]) {
        [WHToast showErrorWithMessage:@"请填写正确的手机号码"];
        return;
    }
    if (addressTextField.text.length < 2) {
        [WHToast showErrorWithMessage:@"请填写好详细地址"];
        return;
    }
    if (_addressContentLabel.text.length == 0) {
        [WHToast showErrorWithMessage:@"请选择省，市，区"];
        return;
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl stringByAppendingString:@"/api/user/updateAddress"] params:@{
                                                                                                      @"name":nameTextField.text,
                                                                                                      @"tel":phoneTextField.text,
                                                                                                      @"sheng_id":_selectIdArray[0],
                                                                                                      @"city_id":_selectIdArray[1],
                                                                                                      @"area_id":_selectIdArray[2],
                                                                                                      @"sex":_sex,
                                                                                                      @"sca_name":_addressContentLabel.text,
                                                                                                      @"address":addressTextField.text,
                                                                                                      @"is_default":@(_isDefault),
                                                                                                      } success:^(id  _Nonnull response) {
                                                                                                          if (response && [response[@"status"] intValue] == 1) {
                                                                                                              [weakSelf.navigationController popViewControllerAnimated:YES];
                                                                                                          }
    } fail:^(NSError * _Nonnull error) {
    } showHUD:YES hasToken:YES];
}
- (void)saveButtonAction:(UIButton *)button {
    [self connectToTheNetwork];
}
- (void)valueChangedMethod:(UISwitch *)switchs {
    _isDefault =  switchs.on?1:0;
}
- (void)selectButtonAction:(UIButton *)button {
    [_selectButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"checklist"] forState:UIControlStateNormal];
    _selectButton = button;
    if (button.tag == 100) {
        _sex = @"女";
    } else {
        _sex = @"男";
    }
}


#pragma mark -------- UIPickerViewDelegate


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return _dataArray.count;
            break;
        case 1:
            return [_dataArray[_selectRow1][@"son"] count];
            break;
        case 2:
            return [_dataArray[_selectRow1][@"son"][_selectRow2][@"son"] count];
            break;
        default:
            break;
    }
    return 0;
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30*ScalePpth;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
      return _dataArray[row][@"title"];
    } else if (component == 1) {
      return _dataArray[_selectRow1][@"son"][row][@"title"];
    } else {
         return _dataArray[_selectRow1][@"son"][_selectRow2][@"son"][row][@"title"];
    }
}
//被选择的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0: {
            _selectRow1 = row;
            _selectRow2 = 0;
            _selectRow3 = 0;
        }
            break;
        case 1: {
            _selectRow2 = row;
            _selectRow3 = 0;
        }
            break;
        case 2: {
            _selectRow3 = row;
        }
            break;
        default:
            break;
    }
    _addressContentLabel.text = [NSString stringWithFormat:@"%@,%@,%@",_dataArray[_selectRow1][@"title"],_dataArray[_selectRow1][@"son"][_selectRow2][@"title"],_dataArray[_selectRow1][@"son"][_selectRow2][@"son"][_selectRow3][@"title"]];
    _selectIdArray = @[_dataArray[_selectRow1][@"id"],_dataArray[_selectRow1][@"son"][_selectRow2][@"id"],_dataArray[_selectRow1][@"son"][_selectRow2][@"son"][_selectRow3][@"id"]].mutableCopy;
    [pickerView reloadAllComponents];
}



@end
