//
//  GlobalSingleton.m
//  YuTongInHand
//
//  Created by 张昊 on 2019/9/7.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import "GlobalSingleton.h"

@implementation GlobalSingleton

 static GlobalSingleton * _globalSingleton = nil;
+ (instancetype)gS_ShareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _globalSingleton = [[GlobalSingleton alloc] init];
        _globalSingleton.times = 600;
    });
    return _globalSingleton;
}
@end
