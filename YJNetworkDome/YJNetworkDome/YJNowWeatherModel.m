//
//  YJNowWeatherModel.m
//  YJNetworkDome
//
//  Created by devRen on 2017/4/19.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import "YJNowWeatherModel.h"


@implementation YJNowWeatherModel

+ (void)analyzeData:(NSData *)data resultBlock:(analyzeDataBlock)block {
    NSDictionary * dict = [YJDataBaseModel isFailData:data resultBlock:block];
    if (dict != nil) {
        NSDictionary * resultsDic = [dict objectForKey:@"results"];
        // Location
        NSDictionary * locationDic = [resultsDic objectForKey:@"location"];
        YJLocationModel *locationModel = [[YJLocationModel alloc] init];
        [locationModel setValuesForKeysWithDictionary:locationDic];
        // now
        NSDictionary * nowDic = [resultsDic objectForKey:@"now"];
        YJNowModel *nowModel = [[YJNowModel alloc] init];
        [nowModel setValuesForKeysWithDictionary:nowDic];
        // nowWeather
        YJNowWeatherModel *nowWeatherModel = [[YJNowWeatherModel alloc] init];
        nowWeatherModel.location = locationModel;
        nowWeatherModel.now = nowModel;
        nowWeatherModel.last_update = [resultsDic objectForKey:@"last_update"];
        
        if (block) block(AnalyzeData_Success , nowWeatherModel);
    }
}

@end
