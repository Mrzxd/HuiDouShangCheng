//
//  HomeTableFourCell.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "HomeTypeModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableFourCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *explainLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) HomeTypeModel *typeModel;

@end

NS_ASSUME_NONNULL_END
