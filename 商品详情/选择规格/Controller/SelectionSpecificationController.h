//
//  SelectionSpecificationController.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/6.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "GoodInfoModel.h"
#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^GoodsDataBlock)(NSString *price,NSString *linePrice,NSInteger goodsCount,NSString *selectKey,NSString *selectSpec);
@interface SelectionSpecificationController : ZXDBaseViewController

@property (nonatomic, strong) GoodInfoModel *infoModel;

@property (nonatomic, strong) GoodsDataBlock dataBlock;

@end

NS_ASSUME_NONNULL_END
