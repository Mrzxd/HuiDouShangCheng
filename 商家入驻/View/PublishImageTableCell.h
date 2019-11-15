//
//  ImageTableCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ImageButtonBlock)(UIButton *button);
@interface PublishImageTableCell : UITableViewCell

@property (nonatomic, strong) ImageButtonBlock buttonBlock;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *imageButton1;
@property (nonatomic, strong) UIButton *imageButton2;
@property (nonatomic, strong) UIButton *imageButton;

@end

NS_ASSUME_NONNULL_END
