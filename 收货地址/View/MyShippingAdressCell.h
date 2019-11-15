//
//  MyShippingAdressCell.h
//  惠豆商城
//
//  Created by 张昊 on 2019/11/9.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MyShippingAdressCellDelegate <NSObject>
@required
- (void)toEditNewAdressResult:(AddressModel *)addressModel;
@end

@interface MyShippingAdressCell : UITableViewCell
    
@property(nonatomic, strong) UIButton *selectButton;
@property(nonatomic, weak) id MyShippingAdressCellDelegate;
@property(nonatomic, strong) AddressModel *addressModel;
    
@end



NS_ASSUME_NONNULL_END
