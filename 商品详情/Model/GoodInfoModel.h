//
//  GoodInfoModel.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/11.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "GoodSpecModel.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodInfoModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) NSString *sale_num;
@property (nonatomic, strong) GoodSpecModel*spec;
@property (nonatomic, strong) NSString *sub_title;
@property (nonatomic, strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
