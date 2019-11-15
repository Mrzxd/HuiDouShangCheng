//
//  ShopCollectionCell.h
//  YuTongInHand
//
//  Created by 张昊 on 2019/9/5.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopCollectionCell : UICollectionViewCell

@property (nonatomic, strong) GoodsListModel *listModel;

@end

NS_ASSUME_NONNULL_END
