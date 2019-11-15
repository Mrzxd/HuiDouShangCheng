//
//  ShopCollectionCell.m
//  YuTongInHand
//
//  Created by 张昊 on 2019/9/5.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import "ShopCollectionCell.h"

@interface ShopCollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation ShopCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius  = 5*ScalePpth;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.shadowColor = RGBHex(0x999999).CGColor;//阴影颜色
        self.contentView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        self.contentView.layer.shadowOpacity = 0.6;//不透明度
        self.contentView.layer.shadowRadius = 4;//半径
        [self CreatUI];
    }
    return self;
}

- (void)CreatUI {
    
    _imageView =  [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 165, 165)];
    _imageView.image = [UIImage imageNamed:@"cycle_image2.png"];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _imageView.frame;
    maskLayer.path = maskPath.CGPath;
    [_imageView.layer addSublayer:maskLayer];
    _imageView.layer.mask = maskLayer;
    _imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _centerLabel = [[UILabel alloc] initWithFrame:AutoFrame(12, 172, 150, 35)];
    _centerLabel.font = FontSize(13);
    _centerLabel.textColor = RGBHex(0x333333);
    _centerLabel.numberOfLines = 2;
    _centerLabel.text = @"【礼盒装】北海老渔村正宗北部湾红树林...";
    [self.contentView addSubview:_centerLabel];
 
    _priceLabel = [[UILabel alloc] initWithFrame:AutoFrame(13, 218, 163, 16)];
    _priceLabel.font = FontSize(16);
    _priceLabel.textColor = RGBHex(0xE70422);
    _priceLabel.text = @"￥1.88";
    [self.contentView addSubview:_priceLabel];
}

- (void)setListModel:(GoodsListModel *)listModel {
    _listModel = listModel;
    if (_listModel) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:listModel.img]]];
         _centerLabel.text = listModel.title NonNull;
        _priceLabel.text = [@"￥" stringByAppendingString:listModel.price NonNull];
    }
}


@end
