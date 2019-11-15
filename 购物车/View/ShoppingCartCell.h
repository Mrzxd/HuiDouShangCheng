//
//  ShoppingCartCell.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/4.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetMyCartModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CellButtonBlock)(CGFloat OneCellTotoalPrice);
typedef void(^CellNumberBlock)(NSString *number);
@interface ShoppingCartCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) GetMyCartModel *model;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) CellButtonBlock buttonBlock;
@property (nonatomic, strong) CellNumberBlock numberBlock;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
