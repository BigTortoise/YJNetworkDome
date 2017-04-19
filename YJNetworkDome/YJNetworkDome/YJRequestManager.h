//
//  YJRequestManager.h
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YJRequestResult) {
    YJHttpServerStart        ,  /** 开始请求 */
    YJHttpServerSuccess      ,  /** 请求数据返回成功 */
    YJHttpServerError        ,  /** 请求失败 <登陆的原因、没网络的原因、服务器返回失败,请求条件有错误.....> */
};

/**
 请求完成的回调

 @param result 请求结果
 @param object 请求返回的对象
 */
typedef void(^YJRequestBlock)(YJRequestResult result , id object);

@interface YJRequestManager : NSObject

/**
 获取申请详情

 @param handler 回调
 */
+ (void)httpForNowWeatherModelWithHandler:(YJRequestBlock)handler;
@end
