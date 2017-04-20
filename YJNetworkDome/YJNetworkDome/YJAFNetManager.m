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

+ (void)GET_Path:(NSString *)path completed:(YJSuccessBlock)success failed:(YJFailedBlock)failed {
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
        
        success([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed(error);
    }];
}

+ (void)GET_Path:(NSString *)path  params:(NSDictionary *)params  completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed {
    //1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed(error);
    }];
}

+ (void)POST_Path:(NSString *)path completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed {
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 添加 text/html 类型到可接收内容类型中
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [manager POST:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed(error);
    }];
}

+ (void)POST_Path:(NSString *)path params:(id)paramsDic completed:(YJSuccessBlock )success failed:(YJFailedBlock )failed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed(error);
    }];
}

+(void)downloadFile:(NSString *)UrlAddress  completed:(YJSuccessBlock)successBlock failed:(YJFailedBlock)failed  progress:(YJSpeedBlock)progressBlock {
    
}
@end
