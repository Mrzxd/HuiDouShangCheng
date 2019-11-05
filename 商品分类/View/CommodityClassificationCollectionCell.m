
//
//  CommodityClassificationCollectionCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "CommodityClassificationCollectionCell.h"

@implementation CommodityClassificationCollectionCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:AutoFrame(0, 0, 276, 50)];
    self.backgroundColor  = UIColor.whiteColor;
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self setUI];
    return self;
}

- (void)setUI {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(18.5, 8, 55, 55)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 27.5*ScalePpth;
    [self.contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(0, 73, 276/3, 12)];
    label.font = FontSize(12);
    label.text = @"TCL";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBHex(0x333333);
    [self.contentView addSubview:label];
}

@end
