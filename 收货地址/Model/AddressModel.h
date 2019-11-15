//
//  AddressModel.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/13.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject

@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *area_id;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *is_default;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *sca_name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *sheng_id;
@property (nonatomic, strong) NSString *user_id;

@end

NS_ASSUME_NONNULL_END
