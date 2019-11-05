//
//  HomeTableThreeCell.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/1.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ButtonIndexBlock)(NSInteger index);
@interface HomeTableThreeCell : UITableViewCell

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *typeButton;
@property (nonatomic, strong) ButtonIndexBlock indexBlock;

@end

NS_ASSUME_NONNULL_END
