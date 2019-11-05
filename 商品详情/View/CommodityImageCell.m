
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

- (void)setUpUI {
    self.theImageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 375, 375)];
    self.theImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.theImageView.image = [UIImage imageNamed:@"detailImage.png"];
    [self.contentView addSubview:self.theImageView];
}

@end
