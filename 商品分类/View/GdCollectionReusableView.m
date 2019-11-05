


//
//  GdCollectionReusableView.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "GdCollectionReusableView.h"

@implementation GdCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:AutoFrame(0, 0, 276, 50)];
    
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(15, 25, 100, 13)];
        label.font = FontSize(13);
        label.text = @"热门品牌";
        self.backgroundColor = UIColor.whiteColor;
        label.textColor = RGBHex(0x333333);
        [self addSubview:label];
    }
    return self;
}

@end
