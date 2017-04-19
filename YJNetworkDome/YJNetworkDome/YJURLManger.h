//
//  YJURLManger.h
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 获取完url后的回掉

 @param url 网络请求路径
 @param body body参数
 */
typedef void (^UrlBlock) (NSString * url , id body);

@interface YJURLManger : NSObject

/**
 获取申请详情  (根据具体业务传入url参数)
 
 @param token 参数1
 @param applyId 参数2
 @param handler 回调
 */
+ (void)urlForAprovalDetailWithToken:(NSString *)token applyRequestId:(NSString *)applyId handler:(UrlBlock)handler;

@end
