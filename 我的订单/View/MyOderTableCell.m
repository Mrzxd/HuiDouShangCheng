//
//  MyOderTableCell.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "MyOderTableCell.h"

@interface MyOderTableCell ()

@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation MyOderTableCell {
    UIButton *footerBtn;
    UIButton *letBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.contentView.layer.cornerRadius = 5*ScalePpth;
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 5*ScalePpth;
        self.clipsToBounds = YES;
        self.contentView.layer.masksToBounds = YES;
        [self setUI];
    };
    return self;
}
- (UILabel *)orderNumberLabel {
    if (!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc] initWithFrame:AutoFrame(10, 16, 290, 12)];
        _orderNumberLabel.text = @"订单编号：5645546684463223";
        _orderNumberLabel.textColor = RGBHex(0x999999);
        _orderNumberLabel.font = FontSize(12);
    }
    return _orderNumberLabel;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:AutoFrame(251, 15, 74, 12)];
        _stateLabel.textColor = RGBHex(0xE70422);
        _stateLabel.text = @"待付款";
        _stateLabel.font = FontSize(12);
        _stateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _stateLabel;
}
- (void)setUI {
    [self.contentView addSubview:self.orderNumberLabel];
    [self.contentView addSubview:self.stateLabel];
    [self addArrowImageView];
}
- (void)addArrowImageView {
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:AutoFrame(331, 15, 7, 11)];
    arrowImage.image = [UIImage imageNamed:@""];
    arrowImage.backgroundColor = RGBHex(0xf0f0f0);
    [self.contentView addSubview:arrowImage];
    
    UIView *line = [[UIView alloc] initWithFrame:AutoFrame(0, 41, 351, 0.5)];
    line.backgroundColor = RGBHex(0xF1F1F1);
    [self.contentView addSubview:line];
    
    UIView *line2 = [[UIView alloc] initWithFrame:AutoFrame(0, 147, 351, 0.5)];
    line2.backgroundColor = RGBHex(0xF1F1F1);
    [self.contentView addSubview:line2];
    
    UIView *grayView = [[UIView alloc] initWithFrame:AutoFrame(18, 53.5, 315, 83)];
    grayView.backgroundColor = RGBHex(0xFAFAFA);
    grayView.layer.cornerRadius = 3*ScalePpth;
    grayView.layer.masksToBounds = YES;
    [self.contentView addSubview:grayView];
    
    for (NSInteger i = 0; i < 2; i ++ ) {
        UIImageView *imgeView = [[UIImageView alloc] initWithFrame:AutoFrame((5+i*90), 5, 85, 73)];
        imgeView.image = [UIImage imageNamed:@"fruit.png"];
        imgeView.backgroundColor = RGBHex(0xffffff);
        [grayView addSubview:imgeView];
    }
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:AutoFrame(195, 36, 100, 12)];
    numLabel.textColor = RGBHex(0x999999);
    numLabel.text = @"共2件";
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.font = [UIFont systemFontOfSize:12*ScalePpth];
    [grayView addSubview:numLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:AutoFrame(299, 37, 6, 10)];
    arrowView.image = [UIImage imageNamed:@"issue_arrow"];
    [grayView addSubview:arrowView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(97,157, 241, 14.2)];
    label.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *numberText;
    label.font = FontSize(10);
    label.textColor = RGBHex(0x333333);
    //    =  [[NSMutableAttributedString alloc] initWithString:@"共1件商品    合计：¥5999积分+3元"];
    numberText=  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%@件商品    合计：¥ %@",@1,@"52100"]];
    [numberText addAttribute:NSForegroundColorAttributeName value:RGBHex(0xCF392A) range:NSMakeRange(12, 7)];
    [numberText addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(13, 6)];
    label.attributedText = numberText;
    [self.contentView addSubview:label];
    
    footerBtn = [[UIButton alloc] initWithFrame:AutoFrame(182,183,73, 26)];
    [footerBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    
    [footerBtn setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(footerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    footerBtn.layer.masksToBounds = YES;
    footerBtn.layer.cornerRadius = 13 *ScalePpth;
    footerBtn.clipsToBounds = YES;
    footerBtn.layer.borderColor = RGBHex(0xCCCCCC).CGColor;
    footerBtn.layer.borderWidth = 0.5 *ScalePpth;
    footerBtn.titleLabel.font = FontSize(14);
    [self.contentView addSubview:footerBtn];
    
    letBtn =  [[UIButton alloc] initWithFrame:AutoFrame(265, 183, 73, 26)];
    [letBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    letBtn.titleLabel.font = FontSize(14);
    letBtn.backgroundColor = RGBHex(0xE60121);
    [letBtn setTitleColor:RGBHex(0xffffff)forState:UIControlStateNormal];
    [letBtn addTarget:self action:@selector(letBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    letBtn.clipsToBounds = YES;
    letBtn.layer.masksToBounds = YES;
    letBtn.layer.cornerRadius = 26.0 *ScalePpth/2.0;
    [self.contentView addSubview:letBtn];
}

- (void)footerBtnAction:(UIButton *)button {
    
}
- (void)letBtnAction:(UIButton *)button {
    if (_immideiatelayPayBlock) {
        _immideiatelayPayBlock(0);
    }
}

@end
