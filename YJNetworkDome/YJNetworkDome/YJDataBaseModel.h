//
//  YJDataBaseModel.h
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    ApprovalStatusNew   = 0 ,      /** 新建  */
    ApprovalStatusAuditing  ,      /** 审批中 */
    ApprovalStatusRefused   ,      /** 已拒绝 */
    ApprovalStatusStepOver  ,      /** 超级审批 */
    ApprovalStatusCance     ,      /** 已撤销 */
    ApprovalStatusAudited   ,      /** 同意并通过 */
    ApprovalStatusFailed    ,      /** 审批未通过 */
    ApprovalStatusAuditedAndNext , /** 同意并转交 */
    
}ApprovalStatusType;

/** 返回代码的定义  1:成功  0:超时  -1:出错 */
typedef NS_ENUM(NSInteger, AnalyzeDataResult) {
    AnalyzeData_Success    = 1 ,
    AnalyzeData_SessionOut = 0 ,
    AnalyzeData_Fail       = -1 ,
};

typedef void(^analyzeDataBlock)( AnalyzeDataResult ret , id object);

@interface YJDataBaseModel : NSObject
/**
 看是否返回成功的数据

 @param data 数据
 @param block 代码的定义
 @return 正常数据
 */
+(NSDictionary *)isFailData:(NSData *)data resultBlock:(analyzeDataBlock)block;

/**
 数据解析

 @param data 数据
 @param block 代码的定义
 */
+(void)analyzeData:(NSData *)data resultBlock:(analyzeDataBlock)block;
@end
