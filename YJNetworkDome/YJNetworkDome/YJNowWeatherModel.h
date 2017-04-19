//
//  YJNowWeatherModel.h
//  YJNetworkDome
//
//  Created by devRen on 2017/4/19.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJDataBaseModel.h"

/** location模型 */
@interface YJLocationModel : NSObject
@property (nonatomic,copy) NSString* locationId;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* country;
@property (nonatomic,copy) NSString* timezone;
@property (nonatomic,copy) NSString* timezone_offset;
@end
/** Now模型 */
@interface YJNowModel : NSObject
@property (nonatomic,copy) NSString* text;
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* feels_like;
@property (nonatomic,copy) NSString* pressure;
@property (nonatomic,copy) NSString* humidity;
@property (nonatomic,copy) NSString* visibility;
@property (nonatomic,copy) NSString* wind_direction;
@property (nonatomic,copy) NSString* wind_direction_degree;
@property (nonatomic,copy) NSString* wind_speed;
@property (nonatomic,copy) NSString* wind_scale;
@property (nonatomic,copy) NSString* clouds;
@property (nonatomic,copy) NSString* dew_point;
@end
/** NowWeatherModel模型 */
@interface YJNowWeatherModel : YJDataBaseModel
@property (nonatomic,strong) YJLocationModel* location;
@property (nonatomic,strong) YJNowModel* now;
@property (nonatomic,copy) NSString* last_update;
@end
