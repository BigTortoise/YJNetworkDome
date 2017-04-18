//
//  YJAFNetManager.h
//  测试
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^YJSuccessBlock)(NSData *data,id JSONDict);   // 请求成功的回掉
typedef void (^YJFailedBlock)(NSError *error);              // 请求失败的回掉
typedef void (^YJSpeedBlock)(float  progress);              // 请求下载进度的回掉

@interface YJAFNetManager : NSObject

/**
 单例

 @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 GET请求 - 无Body参数

 @param path 路径
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)GET_Path:(NSString *)path completed:(YJSuccessBlock)success failed:(YJFailedBlock)failed;

/**
 GET请求 - 有Body参数

 @param path 路径
 @param params 参数
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)GET_Path:(NSString *)path  params:(NSDictionary *)params  completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed;

/**
 POST请求 - 无Body参数

 @param path 路径
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)POST_Path:(NSString *)path completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed;

/**
 POST请求 - 有Body参数

 @param path 路径
 @param paramsDic 参数
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)POST_Path:(NSString *)path params:(id)paramsDic completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed;

/**
 文件下载 (未实现)
 */
+(void)downloadFile:(NSString *)UrlAddress  completed:(YJSuccessBlock)successBlock failed:(YJFailedBlock)failed  progress:(YJSpeedBlock)progressBlock;
@end
