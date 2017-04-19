//
//  YJDataBaseModel.h
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 返回代码的定义 */
typedef NS_ENUM(NSInteger, AnalyzeDataResult) {
    AnalyzeData_Success    = 1 ,    /** 1:成功 */
    AnalyzeData_SessionOut = 0 ,    /** 0:超时 */
    AnalyzeData_Fail       = -1 ,   /** -1:出错 */
};

typedef void(^analyzeDataBlock)( AnalyzeDataResult ret , id object);

@interface YJDataBaseModel : NSObject
/**
 看是否返回成功的数据

 @param data 数据
 @param block 代码的定义
 @return 正常数据
 */
+ (NSDictionary *)isFailData:(NSData *)data resultBlock:(analyzeDataBlock)block;

/**
 数据解析

 @param data 数据
 @param block 代码的定义
 */
+ (void)analyzeData:(NSData *)data resultBlock:(analyzeDataBlock)block;
@end
