

//
//  TransactionDetailsCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "TransactionDetailsCell.h"

@implementation TransactionDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    UIView *contentView = [[UIView alloc] initWithFrame:AutoFrame(10, 0, 355, 107)];
    contentView.backgroundColor = UIColor.whiteColor;
    contentView.layer.cornerRadius = 5;
    contentView.layer.shadowColor = RGBHex(0xC6C6C6).CGColor;//阴影颜色
    contentView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    contentView.layer.shadowOpacity = 0.5;//不透明度
    contentView.layer.shadowRadius = 4;//半径
    [self.contentView addSubview:contentView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 19, 200, 15)];
    _nameLabel.text =  @"充值金额";
    _nameLabel.font = [UIFont systemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    [contentView addSubview:_nameLabel];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:AutoFrame(140, 17, 200, 20)];
    moneyLabel.text =  @"+600.00";
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.font = [UIFont systemFontOfSize:20*ScalePpth];
    moneyLabel.textColor = RGBHex(0xFF0000);
    [contentView addSubview:moneyLabel];
    
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 48, 80, 15)];
    timeLabel.text =  @"充值时间";
    timeLabel.font = [UIFont systemFontOfSize:15*ScalePpth];
    timeLabel.textColor = RGBHex(0x7B7B7B);
    [contentView addSubview:timeLabel];
    
    UILabel *timeNumLabel = [[UILabel alloc] initWithFrame:AutoFrame(140, 51, 200, 13)];
    timeNumLabel.text =  @"2019-02-23  15:18:20";
    timeNumLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
    timeNumLabel.textColor = RGBHex(0x7B7B7B);
    timeNumLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:timeNumLabel];
    
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 76, 80, 15)];
    stateLabel.text =  @"当前状态";
    stateLabel.font = [UIFont systemFontOfSize:15*ScalePpth];
    stateLabel.textColor = RGBHex(0x7B7B7B);
    [contentView addSubview:stateLabel];
    
    UILabel *successLabel = [[UILabel alloc] initWithFrame:AutoFrame(140, 76, 200, 13)];
    successLabel.text =  @"充值成功";
    successLabel.font = [UIFont systemFontOfSize:13*ScalePpth];
    successLabel.textColor = RGBHex(0x7B7B7B);
    successLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:successLabel];
}

@end
