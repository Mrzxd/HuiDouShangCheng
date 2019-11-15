//
//  MyOderTableCell.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ImmideiatelayPayBlock)(NSInteger index);

@interface MyOderTableCell : UITableViewCell

@property (nonatomic, strong) ImmideiatelayPayBlock immideiatelayPayBlock;

@end

NS_ASSUME_NONNULL_END
