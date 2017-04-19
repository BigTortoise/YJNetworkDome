//
//  YJURLManger.m
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import "YJURLManger.h"

@implementation YJURLManger
+ (void)urlForNowWeatherWithHandler:(UrlBlock)handler {
    NSString * url = @"https://api.seniverse.com/v3/weather/now.json?key=qltdahy3vbzkgioj&location=beijing&language=zh-Hans&unit=c";
     if (handler) handler(url, nil);
}
@end
