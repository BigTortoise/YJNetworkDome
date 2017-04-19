//
//  YJDataBaseModel.m
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import "YJDataBaseModel.h"

@implementation YJDataBaseModel

/** 看是否返回成功的数据 */
+ (NSDictionary *)isFailData:(NSData *)data resultBlock:(analyzeDataBlock)block {
    if (data.length < 1) {
        if (block) block(AnalyzeData_Fail,@"请求到的数据为空");
        return nil;
    }
    // 解析json数据
    NSDictionary * rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (rootDict.count < 1) {
        if (block) block(AnalyzeData_Fail,@"解析数据错误");
        return nil;
    }
    // 错误码
    NSString *status_code = [[rootDict objectForKey:@"status_code"] isEqual:[NSNull null]] ? nil : [rootDict objectForKey:@"status_code"];
    if (status_code == nil) {
        return rootDict;
    }else{
        NSString *status = [rootDict objectForKey:@"status"];
        block(AnalyzeData_Fail,status);
        return nil;
    }
}

/** 数据解析 */
+ (void)analyzeData:(NSData *)data resultBlock:(analyzeDataBlock)block {
    NSDictionary * rootDict = [YJDataBaseModel isFailData:data resultBlock:block];
    if (rootDict != nil) {
        if(block) block(AnalyzeData_Success , [rootDict objectForKey:@"status"]);
    }
}

@end
