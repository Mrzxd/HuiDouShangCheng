
//
//  CommodityImageCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/5.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "CommodityImageCell.h"

@implementation CommodityImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}
- (UILabel *)htmlLabel {
    if (!_htmlLabel) {
        _htmlLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 10, 355, 1000)];
        _htmlLabel.numberOfLines = 0;
        _htmlLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _htmlLabel;
}
- (void)setUpUI {
    [self.contentView addSubview:self.htmlLabel];
    [self.htmlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10*ScalePpth);
        make.bottom.right.equalTo(self.contentView).offset(-10*ScalePpth);
    }];
}

@end
