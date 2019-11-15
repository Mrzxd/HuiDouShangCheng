//
//  MyOrderController.m
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "ConfirmMyOrderController.h"
#import "YTSegmentBarVC.h"
#import "AllController.h"
#import "WillPayController.h"
#import "MyOrderController.h"
#import "ToBeShippedController.h"
#import "GoodsToBeReceivedController.h"
#import "AlreadyHarvestedController.h"

@interface MyOrderController ()

@property (nonatomic, strong) YTSegmentBarVC *segmentVC;

@end

@implementation MyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, ScreenWidth, 30);
    self.segmentVC.segmentBar.showIndicator = YES;
    self.segmentVC.segmentBar.space = 0;
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    NSArray *items = @[@"全部", @"有人邀请", @"进行中",@" 待付款",@"已完成"];
    WeakSelf;
    AllController *one = [[AllController alloc] init];
    one.immideiatelayPayBlock = ^(NSInteger index) {
        [weakSelf.navigationController pushViewController:[ConfirmMyOrderController new] animated:YES];
    };
    WillPayController *two = [[WillPayController alloc] init];
    ToBeShippedController *three = [[ToBeShippedController alloc] init];
    GoodsToBeReceivedController *four = [[GoodsToBeReceivedController alloc] init];
    AlreadyHarvestedController *five = [[AlreadyHarvestedController alloc] init];
    [self.segmentVC setUpWithItems:items ChildVCs:@[one,two,three,four,five]];
    self.segmentVC.segmentBar.selectIndex = 0;
    [self.segmentVC.segmentBar updateWithConfig:^(YTSegmentBarConfig *config) {
        config.itemNormalColor (RGBHex(0x999999))
        .itemSelectColor (RGBHex(0xE70422))
        .indicatorColor  (RGBHex(0xE70422));
    }];
}
- (YTSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        _segmentVC = [[YTSegmentBarVC alloc] init];
        _segmentVC.block = ^(NSInteger toIndex,NSInteger fromIndex){
            
        };
        [self addChildViewController:_segmentVC];
    }
    return _segmentVC;
}


@end
