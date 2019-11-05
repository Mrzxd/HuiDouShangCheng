
//
//  CenterTableCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/5.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "CenterTableCell.h"

@implementation CenterTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 13.5, 30, 13)];
    _nameLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    _nameLabel.textColor = RGBHex(0xA7A7A7);
    _nameLabel.text = @"规格";
    [self.contentView addSubview:_nameLabel];
    
    _nameContentLabel = [[UILabel alloc] initWithFrame:AutoFrame(50, 11, 90, 18)];
    _nameContentLabel.font = [UIFont systemFontOfSize:13 *ScalePpth];
    _nameContentLabel.textColor = RGBHex(0x333333);
    _nameContentLabel.text = @"默认";
    [self.contentView addSubview:_nameContentLabel];
}

@end
