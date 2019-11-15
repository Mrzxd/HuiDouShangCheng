//
//  HomeTableTwoCell.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "HomeTypeModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NavigationBlock)(HomeTypeModel *typeModel);

@interface HomeTableTwoCell : UITableViewCell

@property (nonatomic, strong) UIButton *oneButton;
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) NavigationBlock navigationBlock;

@property (nonatomic, strong) HomeTypeModel *typeModel;

@end

NS_ASSUME_NONNULL_END
