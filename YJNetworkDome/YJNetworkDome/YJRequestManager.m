//
//  YJRequestManager.m
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import "YJRequestManager.h"
#import "YJAFNetManager.h"
#import "YJURLManger.h"
#import "YJNowWeatherModel.h"

@implementation YJRequestManager
/** 获取申请详情 */
+ (void)httpForNowWeatherModelWithHandler:(YJRequestBlock)handler {
    [YJURLManger urlForNowWeatherModelWithHandler:^(NSString *url, id body) {
        [YJRequestManager getRequestWithHttpString:url classString:@"YJNowWeatherModel" httpBlock:handler sessionOutloginSucceess:nil];
    }];
}

#pragma mark - 请求发起和解析数据
+ (void)getRequestWithHttpString:(NSString *)url classString:(NSString *)classString httpBlock:(YJRequestBlock)block sessionOutloginSucceess:(void(^)())loginSuccess {
    /** 判断是否有网络 */
    if (block) block(YJHttpServerStart , @"请求中");
    
    [YJAFNetManager GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        /** 解析数据 */
        [NSClassFromString(classString) analyzeData:stringData resultBlock:^(AnalyzeDataResult ret, id object) {
            if (ret == AnalyzeData_Fail) {
                if (block) {
                    block(YJHttpServerError , object);
                }
            }else if(ret == AnalyzeData_Success){
                if (block){
                    block(YJHttpServerSuccess , object);
                }
            }else if (ret == AnalyzeData_SessionOut){
                /** 登录超时的情况 */
            }

        }];
    } failed:^(NSError *error) {
        
    }];
}

+ (void)postRequestWithHttpString:(NSString *)url params:(NSDictionary *)params classString:(NSString *)classString httpBlock:(YJRequestBlock)block sessionOutloginSucceess:(void(^)())loginSuccess {
    NSLog(@"\n\npost_url %@\n\n" , url);
    /** 判断是否有网络 */
    if (block) block(YJHttpServerStart , @"请求中");
    /*
     AFHTTPSessionManager * manager = [AFHTTPSessionManager manager] ;
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     manager.requestSerializer=[AFJSONRequestSerializer serializer];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html" ,  nil];
     
     [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
     NSLog(@"%@",responseObject);
     
     NSData * data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
     
     // 解析数据
     [NSClassFromString(classString) analyzeData:data resultBlock:^(AnalyzeDataResult ret, id object) {
     if (ret == AnalyzeData_Fail) {
     if (block) {
     block(KCHttpServerError , object);
     }
     }else if(ret == AnalyzeData_Success){
     if (block){
     block(KCHttpServerSuccess , object);
     }
     }else if (ret == AnalyzeData_SessionOut){
     // 登录超时的情况
     if (block) {
     block(KCHttpServerError , @"登陆超时");
     }
     }
     }];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
     
     NSString * errorMsg = error.localizedFailureReason.length != 0 ? error.localizedFailureReason:@"请求错误<未知原因>" ;
     if (block) block(KCHttpServerError,errorMsg);
     }];
     */
}
@end
