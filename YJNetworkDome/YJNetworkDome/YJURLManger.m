//
//  YJURLManger.m
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import "YJURLManger.h"

@implementation YJURLManger

+(void)urlForAprovalDetailWithToken:(NSString *)token applyRequestId:(NSString *)applyId handler:(UrlBlock)handler
{
    NSString * url;
     if (handler) handler(url, nil );
}
@end
