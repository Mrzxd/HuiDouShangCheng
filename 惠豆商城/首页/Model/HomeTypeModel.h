//
//  HomeTypeModel.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/14.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTypeModel : NSObject

@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *sale_num;
@property (nonatomic, strong) NSString *original_price;
@property (nonatomic, strong) NSString *linkman;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString *km;

@end

NS_ASSUME_NONNULL_END
