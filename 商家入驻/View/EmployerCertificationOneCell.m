//
//  EmployerCertificationOneCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "EmployerCertificationOneCell.h"

@implementation EmployerCertificationOneCell

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
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 18, 120, 15)];
    _nameLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    _nameLabel.text = @"位置信息";
    [self.contentView addSubview:_nameLabel];
    
    _rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(203, 18, 145, 15)];
    _rightLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
    _rightLabel.textColor = RGBHex(0xcccccc);
    _rightLabel.text = @"";
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:AutoFrame(352, 21, 6, 10)];
    arrowImgView.image = [UIImage imageNamed:@"issue_arrow"];
    [self.contentView addSubview:arrowImgView];
    
}

@end
