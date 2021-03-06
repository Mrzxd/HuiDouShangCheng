//
//  ZXD_NetWorking.h
//  YuTongInHand
//
//  Created by 张兴栋 on 2019/9/11.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef enum {
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
}NetworkStatus;

typedef void(^ZXDResponseSuccess)(id response);
typedef void(^ZXDResponseFail)(NSError *error);
typedef void(^ZXDUploadProgress)(int64_t bytesProgress,
                                 int64_t totalBytesProgress);
typedef void(^ZXDDownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask ZXDURLSessionTask;

@interface ZXD_NetWorking : NSObject
    
    
/**
 *  单例
 *
 *
 */
+ (ZXD_NetWorking *)sharedZXD_NetWorking;

/**
 *  获取网络
 */
@property (nonatomic,assign)NetworkStatus networkStats;

/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+ (ZXDURLSessionTask *)getWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(void(^)(id respones))success
                             fail:(void(^)(NSError *error))fail
                          showHUD:(BOOL)showHUD
                         hasToken:(BOOL)hasToken;

/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+ (ZXDURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                           success:(ZXDResponseSuccess)success
                              fail:(ZXDResponseFail)fail
                           showHUD:(BOOL)showHUD
                          hasToken:(BOOL)hasToken;

/**
 *  上传图片方法
 *
 *  @param image      上传的图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+ (ZXDURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                               params:(NSDictionary *)params
                             progress:(ZXDUploadProgress)progress
                              success:(ZXDResponseSuccess)success
                                 fail:(ZXDResponseFail)fail
                              showHUD:(BOOL)showHUD;

/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return 返回请求任务对象，便于操作
 */
+ (ZXDURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(ZXDDownloadProgress )progressBlock
                              success:(ZXDResponseSuccess )success
                              failure:(ZXDResponseFail )fail
                              showHUD:(BOOL)showHUD;

@end

NS_ASSUME_NONNULL_END
