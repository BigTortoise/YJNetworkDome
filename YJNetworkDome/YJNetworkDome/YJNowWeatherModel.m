//
//  YJNowWeatherModel.m
//  YJNetworkDome
//
//  Created by devRen on 2017/4/19.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import "YJNowWeatherModel.h"

@implementation YJLocationModel
- (instancetype)initWithDict:(NSDictionary*)dict {
    if (self = [super init]) {
        self.locationId = dict[@"id"];
        self.name = dict[@"name"];
        self.path = dict[@"path"];
        self.country = dict[@"country"];
        self.timezone = dict[@"timezone"];
        self.timezone_offset = dict[@"timezone_offset"];
    }
    return self;
}
@end

@implementation YJNowModel
- (instancetype)initWithDict:(NSDictionary*)dict {
    if (self = [super init]) {
        self.text = dict[@"text"];
        self.code = dict[@"code"];
        self.feels_like = dict[@"pressure"];
        self.pressure = dict[@"pressure"];
        self.humidity = dict[@"humidity"];
        self.visibility = dict[@"visibility"];
        self.wind_direction = dict[@"wind_direction"];
        self.wind_direction_degree = dict[@"wind_direction_degree"];
        self.wind_speed = dict[@"wind_speed"];
        self.wind_scale = dict[@"wind_scale"];
        self.clouds = dict[@"clouds"];
        self.dew_point = dict[@"dew_point"];
    }
    return self;
}
@end

@implementation YJNowWeatherModel

+ (void)analyzeData:(NSData *)data resultBlock:(analyzeDataBlock)block {
    NSDictionary * dict = [YJDataBaseModel isFailData:data resultBlock:block];
    if (dict != nil) {
        NSDictionary * resultsDic = [[dict objectForKey:@"results"] lastObject];
        // Location
        NSDictionary * locationDic = [resultsDic objectForKey:@"location"];
        YJLocationModel *locationModel = [[YJLocationModel alloc] initWithDict:locationDic];
        // now
        NSDictionary * nowDic = [resultsDic objectForKey:@"now"];
        YJNowModel *nowModel = [[YJNowModel alloc] initWithDict:nowDic];
        // nowWeather
        YJNowWeatherModel *nowWeatherModel = [[YJNowWeatherModel alloc] init];
        nowWeatherModel.location = locationModel;
        nowWeatherModel.now = nowModel;
        nowWeatherModel.last_update = [resultsDic objectForKey:@"last_update"];
        
        if (block) block(AnalyzeData_Success , nowWeatherModel);
    }
}

@end
