//
//  ClassificationCommodityController.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//  分类-商品
#import "GoodsListModel.h"
#import "ZXDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassificationCommodityController : ZXDBaseViewController

@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSArray <GoodsListModel *>*listModelArray;
    
@end

NS_ASSUME_NONNULL_END
