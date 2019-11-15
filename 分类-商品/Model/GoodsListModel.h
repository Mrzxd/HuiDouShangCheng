//
//  GoodsListModel.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/9.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsListModel : NSObject

@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *idName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *original_price;

@end

NS_ASSUME_NONNULL_END
