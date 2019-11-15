//
//  GetMyCartModel.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/12.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetMyCartModel : NSObject

@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *checked;
@property (nonatomic, strong) NSString *shop_id;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *stock;
@property (nonatomic, strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
