//
//  ZXD_NetWorking.m
//  YuTongInHand
//
//  Created by 张兴栋 on 2019/9/11.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import "ZXD_NetWorking.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>


static NSMutableArray *tasks = nil;
static ZXD_NetWorking *handler = nil;

typedef NS_ENUM(NSUInteger, ZXD_NetWorking_ENUM) {
    ZXD_NetWorking_ENUM_NONE,
    ZXD_NetWorking_ENUM_GET,
    ZXD_NetWorking_ENUM_POST,
};

@implementation ZXD_NetWorking
    

+ (ZXD_NetWorking *)sharedZXD_NetWorking {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[ZXD_NetWorking alloc] init];
    });
    return handler;
}

+ (NSMutableArray *)tasks {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

+ (ZXDURLSessionTask *)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success fail:(void (^)(NSError * _Nonnull))fail showHUD:(BOOL)showHUD hasToken:(BOOL)hasToken {
    return [self baseRequestType:ZXD_NetWorking_ENUM_GET url:url params:params success:success fail:fail showHUD:showHUD hasToken:hasToken];
}

+ (ZXDURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                           success:(ZXDResponseSuccess)success
                              fail:(ZXDResponseFail)fail
                           showHUD:(BOOL)showHUD
                          hasToken:(BOOL)hasToken {
    return [self baseRequestType:ZXD_NetWorking_ENUM_POST url:url params:params success:success fail:fail showHUD:showHUD hasToken:hasToken];
}

+(ZXDURLSessionTask *)baseRequestType:(ZXD_NetWorking_ENUM)type
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                             success:(ZXDResponseSuccess)success
                                fail:(ZXDResponseFail)fail
                             showHUD:(BOOL)showHUD
                            hasToken:(BOOL)hasToken
    {
//   DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (url==nil) {
        return nil;
    }
    
    if (showHUD) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    AFHTTPSessionManager *manager = [self getAFManager];
        if (hasToken) {
            [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user-token"] forHTTPHeaderField:@"user-token"];
        }
    ZXDURLSessionTask *sessionTask=nil;
    if (type == 1) {
        sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            DLog(@"请求结果=%@",responseObject);
            if (success) {
                success(responseObject);
            }
            [[self tasks] removeObject:sessionTask];
            if (showHUD == YES) {
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            }
        }];
    } else {
        
        sessionTask = [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//             DLog(@"请求成功=%@",responseObject);
            if (success) {
                success(responseObject);
            }
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            }
        }];
    }
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}

+ (ZXDURLSessionTask *)uploadWithImage:(UIImage *)image url:(NSString *)url filename:(NSString *)filename name:(NSString *)name params:(NSDictionary *)params progress:(ZXDUploadProgress)progress success:(ZXDResponseSuccess)success fail:(ZXDResponseFail)fail showHUD:(BOOL)showHUD {
//    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (url==nil) {
        return nil;
    }
    if (showHUD==YES) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    AFHTTPSessionManager *manager=[self getAFManager];
    ZXDURLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        if (success) {
            success(responseObject);
        }
        [[self tasks] removeObject:sessionTask];
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
        [[self tasks] removeObject:sessionTask];
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        }
    }];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}

+ (ZXDURLSessionTask *)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath progress:(ZXDDownloadProgress)progressBlock success:(ZXDResponseSuccess)success failure:(ZXDResponseFail)fail showHUD:(BOOL)showHUD {
    
//    DLog(@"请求地址----%@\n    ",url);
    if (url==nil) {
        return nil;
    }
    if (showHUD==YES) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFManager];
    ZXDURLSessionTask *sessionTask = nil;
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//            DLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }else{
            return [NSURL fileURLWithPath:saveToPath];
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        DLog(@"下载文件成功");
        [[self tasks] removeObject:sessionTask];
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
        } else {
            if (fail) {
                fail(error);
            }
        }
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        }
    }];
    //开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
    
}



+(AFHTTPSessionManager *)getAFManager {
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    return manager;
}

+ (void)startMonitoring {
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                DLog(@"未知网络");
                [ZXD_NetWorking sharedZXD_NetWorking].networkStats=StatusUnknown;
                
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                DLog(@"没有网络");
                [ZXD_NetWorking sharedZXD_NetWorking].networkStats=StatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                DLog(@"手机自带网络");
                [ZXD_NetWorking sharedZXD_NetWorking].networkStats=StatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [ZXD_NetWorking sharedZXD_NetWorking].networkStats=StatusReachableViaWiFi;
                DLog(@"WIFI--%d",[ZXD_NetWorking sharedZXD_NetWorking].networkStats);
                break;
        }
    }];
    [mgr startMonitoring];
}

+(NSString *)strUTF8Encoding:(NSString *)str {
        //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}




@end
