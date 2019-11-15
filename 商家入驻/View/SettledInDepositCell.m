//
//  SettledInDepositCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "SettledInDepositCell.h"

@implementation SettledInDepositCell

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
    
    UILabel *_nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 18, 120, 15)];
    _nameLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    _nameLabel.text = @"入驻押金";
    [self.contentView addSubview:_nameLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(175, 18, 182, 15)];
    rightLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
    rightLabel.textColor = RGBHex(0x333333);
    rightLabel.text = @"10000元";
    rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:rightLabel];
    
}

@end
