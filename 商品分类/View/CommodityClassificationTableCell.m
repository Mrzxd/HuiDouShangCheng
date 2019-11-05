//
//  CommodityClassificationTableCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "CommodityClassificationTableCell.h"

@implementation CommodityClassificationTableCell

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
    _titleLabel = [[UILabel alloc] initWithFrame:AutoFrame(30, 18.5, 70, 13)];
    _titleLabel.font = FontSize(13);
    _titleLabel.textColor = RGBHex(0xD90004);
    _titleLabel.text = @"大家电";
    [self.contentView addSubview:self.titleLabel];
}

@end
