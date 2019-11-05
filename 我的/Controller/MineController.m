
//
//  MineController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "MineController.h"

@interface MineController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MineController

- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = RGBHex(0xF7F6FA);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headerView];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.scrollView addSubview:self.middleView];
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:self.bottomView];

}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 375, (215*ScalePpth +statusHeight)/ScalePpth)];
        [self addheaderViewSubViews];
    }
    return _headerView;
}
- (UIView *)middleView {
    if (!_middleView) {
        _middleView = [[UIView alloc] initWithFrame:AutoFrame(10, (181.5*ScalePpth +statusHeight)/ScalePpth, 355, 115)];
        _middleView.backgroundColor = UIColor.whiteColor;
        _middleView.layer.masksToBounds = YES;
        _middleView.layer.cornerRadius = 5*ScalePpth;
        [self addMiddleSubViews];
    }
    return _middleView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleView.frame) + 10*ScalePpth, 375 *ScalePpth, 90 *ScalePpth)];
        _imageView.backgroundColor = UIColor.whiteColor;
        _imageView.image = [UIImage imageNamed:@"my_advertisement"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame)+5*ScalePpth, ScreenWidth,222*ScalePpth)];
        _bottomView.backgroundColor = UIColor.whiteColor;
        [self addBottomSubViews];
    }
    return _bottomView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KTabBarHeight)];
        _scrollView.backgroundColor = RGBHex(0xF7F6FA);
        _scrollView.contentSize = CGSizeMake(ScreenWidth, 629*ScalePpth+statusHeight);
 
    }
    return _scrollView;
}
- (void)addMiddleSubViews {
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(10.5,  12, 200, 13)];
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text = @"惠豆订单";
    nameLabel.font  = [UIFont boldSystemFontOfSize:13*ScalePpth];
    [_middleView addSubview:nameLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(275, 0, 70, 35)];
    [button setTitle:@"查看全部" forState:UIControlStateNormal];
    button.titleLabel.font = FontSize(12);
    [button setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"my_right_arrow"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 60*ScalePpth, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15*ScalePpth)];
    [_middleView addSubview:button];
    
    UIView *lineView = [[UIView alloc] initWithFrame:AutoFrame(0, 35, 355, 0.5)];
    lineView.backgroundColor = RGBHex(0xEEEEEE);
    [_middleView addSubview:lineView];
    
    NSArray *imageArray = @[@"my_pending",@"my_shipped",@"my_good",@"my_received",@"my_sale"];
    NSArray *titleArray = @[@"待付款",@"待发货",@"待收货",@"已收货",@"售后服务"];
    for (NSInteger i = 0; i < 5; i ++) {
        UIButton *typeButton = [[UIButton alloc] initWithFrame:AutoFrame(355/5 *i, 52, 355/5, 23.5)];
        [typeButton setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [_middleView addSubview:typeButton];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(355/5 *i, 83.5, 355/5, 12)];
        nameLabel.textColor = RGBHex(0x333333);
        nameLabel.text = titleArray[i];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font  = [UIFont systemFontOfSize:12*ScalePpth];
        [_middleView addSubview:nameLabel];
    }
}
- (void)addBottomSubViews {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(10,15,100,15)];
    nameLabel.textColor = RGBHex(0x333333);
    nameLabel.text = @"必备工具";
    nameLabel.font  = [UIFont boldSystemFontOfSize:15*ScalePpth];
    [_bottomView addSubview:nameLabel];
    
    NSArray *nameArray = @[@"my_property",@"my_center",@"my_indent",@"my_silver",@"my_site",@"my_invite",@"my_discount",@"my_service",@"my_about",@"my_application",@"my_data"];
    NSArray *titleArray = @[@"我的资产",@"商家中心",@"金豆订单",@"银豆订单",@"收货地址",@"邀请好友",@"优惠券",@"客服中心",@"我的好友",@"我的好友",@"我的资料"];
    for (NSInteger i = 0; i < 11; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(375.0/4 *(i%4), (44+i/4*61), 375.0/4, 25)];
        [button setImage:[UIImage imageNamed:nameArray[i]] forState:UIControlStateNormal];
        [_bottomView addSubview:button];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(375.0/4 *(i%4), (74+i/4*61.5), 375/4, 12)];
        nameLabel.textColor = RGBHex(0x666666);
        nameLabel.text = titleArray[i];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font  = [UIFont systemFontOfSize:12*ScalePpth];
        [_bottomView addSubview:nameLabel];
    }
}
- (void)addheaderViewSubViews {
//  创建CGContextRef
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    //绘制Path
    CGRect rect = _headerView.bounds;
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    //绘制渐变
    [self drawLinearGradient:gc path:path startColor:RGBHex(0xFF5044).CGColor endColor:RGBHex(0xE60121).CGColor];
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.userInteractionEnabled = YES;
    [_headerView addSubview:imgView];
    
    UIButton *messageButton = [[UIButton alloc] initWithFrame:AutoFrame(18, (13*ScalePpth +statusHeight)/ScalePpth, 17, 16)];
    [messageButton setImage:[UIImage imageNamed:@"home_news"] forState:UIControlStateNormal];
    [_headerView addSubview:messageButton];
    
    UIButton *setUpButton = [[UIButton alloc] initWithFrame:AutoFrame(343, (13*ScalePpth +statusHeight)/ScalePpth, 17, 17)];
    [setUpButton setImage:[UIImage imageNamed:@"my_set"] forState:UIControlStateNormal];
    [_headerView addSubview:setUpButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(16, (48*ScalePpth +statusHeight)/ScalePpth, 61, 61)];
    imageView.layer.cornerRadius = 61.0/2*ScalePpth;
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:@"my_head_img"];
    [_headerView addSubview:imageView];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:AutoFrame(87.5,  (58*ScalePpth +statusHeight)/ScalePpth, 200, 18)];
    phoneLabel.textColor = UIColor.whiteColor;
    phoneLabel.text = @"155****2186";
    phoneLabel.font  = [UIFont boldSystemFontOfSize:18*ScalePpth];
    [_headerView addSubview:phoneLabel];
    
    UILabel *numberLabel =  [[UILabel alloc] initWithFrame:AutoFrame(86.5,  (82*ScalePpth +statusHeight)/ScalePpth, 110, 19)];
    numberLabel.textColor = UIColor.whiteColor;
    numberLabel.text = @"邀请码：203001";
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.layer.cornerRadius  = 9.5*ScalePpth;
    numberLabel.layer.masksToBounds = YES;
    numberLabel.font  = [UIFont systemFontOfSize:12*ScalePpth];
    numberLabel.backgroundColor = RGBHexAlpha(0x000000, 0.16);
    [_headerView addSubview:numberLabel];
    
    NSArray *numberArray = @[@"200.00",@"628",@"221"];
    NSArray *nameArray = @[@"我的金币",@"我的金豆",@"我的银豆"];
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *numberLabel =  [[UILabel alloc] initWithFrame:AutoFrame(375.0/3 *i,  (129*ScalePpth +statusHeight)/ScalePpth, 375.0/3, 19)];
        numberLabel.textColor = UIColor.whiteColor;
        numberLabel.text = numberArray[i];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font  = [UIFont systemFontOfSize:19*ScalePpth];
        [_headerView addSubview:numberLabel];
        
        UILabel *nameLabel =  [[UILabel alloc] initWithFrame:AutoFrame(375.0/3 *i,  (155*ScalePpth +statusHeight)/ScalePpth, 375.0/3, 12)];
        nameLabel.textColor = UIColor.whiteColor;
        nameLabel.text = nameArray[i];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font  = [UIFont systemFontOfSize:12 *ScalePpth];
        [_headerView addSubview:nameLabel];
    }
}

@end
