//
//  GPAdaptationHeader.h
//  GamePlatform
//
//  Created by 张兴栋 on 2019/8/30.
//  Copyright © 2019 ZCF. All rights reserved.
//

#ifndef GPAdaptationHeader_h
#define GPAdaptationHeader_h

#ifdef __OBJC__

#import "ZXDBaseViewController.h"
#import "ZLImageViewDisplayView.h"
#import "LBNavigationController.h"
#import "UIViewController+ImagePicker.h"
//#import "UIScrollView+MJRefreshEX.h"
#import "ZXD_NetWorking.h"
#import <MJExtension/MJExtension.h>
#import <MBProgressHUD.h>
#import "WHToast.h"
#import <Masonry/Masonry.h>
#import "YTSegmentBar.h"
//#import "ZXDNavigationContoller.h"
#import "NSObject+JudgmentClass.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "惠豆商城-Swift.h"
#import "GlobalSingleton.h"

#endif

#define MB_INSTANCETYPE instancetype

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


#define  rootUrl @"http://huidoushop.huizukeji.cn"

#define NonNull ?:@""
#define NoneNull(x)  [NSString stringWithFormat:@"%@", [x isKindOfClass:[NSNumber class]]?(NSNumber *)(x?x:@0):(NSString *)([x isKindOfClass:[NSNull class]] ?(x = @""):(([x length] > 0)?x:@""))]
 #define NonNullNum ?:@0
#define WeakSelf  __weak __typeof(&*self)weakSelf = self;
#define StrongSelf  __strong typeof(weakSelf) strongSelf = weakSelf;
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
//获取状态栏的rect
#define statusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define KStatusBarHeight ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44.0 : 20.0)
#define KNavigationHeight ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)
#define KTabBarHeight ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 83.0 : 49.0)
#define KSafetyZoneHeighe ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 34 : 0)

#define AutoFrame(x,y,width,height)  CGRectMake((CGFloat)x*ScalePpth, (CGFloat)y*ScalePpth, (CGFloat)width *ScalePpth, (CGFloat)height *ScalePpth)
#define ScreenWidth                     (CGFloat)[UIScreen mainScreen].bounds.size.width
#define ScreenHeight                    (CGFloat)[UIScreen mainScreen].bounds.size.height
#define ScalePpth                           (CGFloat)(ScreenWidth/375.0)
#define CategoryTitleHeight                    34.0
#define FontSize(n) [UIFont systemFontOfSize:(CGFloat)n * ScalePpth]
#define ZxdSizeMake(x,y) CGSizeMake((CGFloat)x *ScalePpth, (CGFloat)y *ScalePpth)

#endif /* GPAdaptationHeader_h */
