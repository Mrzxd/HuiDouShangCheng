//
//  GoodSpecModel.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/11.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodSpecModel : NSObject

@property (nonatomic, strong) NSDictionary *line_price;
@property (nonatomic, strong) NSDictionary *price;
@property (nonatomic, strong) NSArray *spec;
@property (nonatomic, strong) NSDictionary *stock;

@end

NS_ASSUME_NONNULL_END
