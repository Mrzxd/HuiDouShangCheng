//
//  EmployerCertificationTexyfieldCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "EmployerCertificationTexyfieldCell.h"

@implementation EmployerCertificationTexyfieldCell

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
        _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 18, 80, 15)];
        _nameLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
        _nameLabel.textColor = RGBHex(0x333333);
        _nameLabel.text = @"真实姓名";
        [self.contentView addSubview:_nameLabel];

        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100*ScalePpth, 0*ScalePpth, 257*ScalePpth, 50*ScalePpth)];
    //    _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = FontSize(15);
        [self.contentView addSubview:_textField];

}

@end
