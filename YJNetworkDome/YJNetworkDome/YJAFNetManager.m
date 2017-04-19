//
//  YJAFNetManager.m
//  测试
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import "YJAFNetManager.h"
#import "AFNetworking.h"

@implementation YJAFNetManager

+ (void)GET_Path:(NSString *)path completed:(YJSuccessBlock)successBlock failed:(YJFailedBlock)failed {
    // 路径中的中文、特殊符号&％和空格都必须进行转译
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 在Wifi情况下请求时间大于10秒即为超时
    manager.requestSerializer.timeoutInterval = 10;
    
    // 申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    // GET请求
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed(error);
    }];
}

+ (void)GET_Path:(NSString *)path  params:(NSDictionary *)params  completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed {
    
}

+ (void)POST_Path:(NSString *)path completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed {
    
}

+ (void)POST_Path:(NSString *)path params:(id)paramsDic completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed {
    
}

+(void)downloadFile:(NSString *)UrlAddress  completed:(YJSuccessBlock)successBlock failed:(YJFailedBlock)failed  progress:(YJSpeedBlock)progressBlock {
    
}
@end
