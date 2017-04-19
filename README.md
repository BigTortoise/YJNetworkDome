# YJNetworkDome
对AFN框架的二级封装以及JSON与Model的转化。
## YJAFNetManager
此类是对AFNetWorking的一级封装，包括:

* GET请求
* POST请求
* 文件的下载和上传(未完TODO)。

以GET请求为例，接口如下：

```
/**
 GET请求 - 无Body参数

 @param path 路径
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)GET_Path:(NSString *)path completed:(YJSuccessBlock)success failed:(YJFailedBlock)failed;
```

调用方式如下：

```
[YJAFNetManager GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        /** 解析数据 */
        [NSClassFromString(classString) analyzeData:stringData resultBlock:^(AnalyzeDataResult ret, id object) {
            if (ret == AnalyzeData_Fail) {
                /** 解析数据失败 */
                if (block) {
                    block(YJHttpServerError , object);
                }
            }else if(ret == AnalyzeData_Success){
                /** 解析数据成功 */
                if (block){
                    block(YJHttpServerSuccess , object);
                }
            }else if (ret == AnalyzeData_SessionOut){
                /** 解析数据超时 */
            }

        }];
    } failed:^(NSError *error) {
        /** 请求失败 */
    }];
```

## ViewModel
ViewModel中包含了两个类 YJURLManger与YJRequestManager。

### YJRequestManager
此类是对YJAFNetManager的二级封装，提供了终极网络请求接口，通过block回调的方式返回请求结果和数据。

* YJRequestResult枚举，枚举了三个HTTP请求状态。

```
typedef NS_ENUM(NSInteger, YJRequestResult) {
    YJHttpServerStart   ,  /** 开始请求 */
    YJHttpServerSuccess ,  /** 请求数据返回成功 */
    YJHttpServerError   ,  /** 请求失败 <登陆的原因、没网络的原因、服务器返回失败,请求条件有错误.....> */
};
```
* YJRequestBlock的定义

```
/**
 请求完成的回调

 @param result 请求结果
 @param object 请求返回的对象
 */
typedef void(^YJRequestBlock)(YJRequestResult result , id object);
```

* 终极网络请求接口

```
/**
 获取现在天气情况

 @param handler 回调
 */
+ (void)httpForNowWeatherWithHandler:(YJRequestBlock)handler;
```
* 调用方式

```
[YJRequestManager httpForNowWeatherWithHandler:^(YJRequestResult result, id object) {
	if (result == YJHttpServerStart) {
   		/** 开始请求 */
	} else if (result == YJHttpServerError){
   		/** 请求失败 */
	} else if (result == YJHttpServerSuccess){
  		/** 请求数据返回成功 */
   }
}];
```

* 实现原理

```
/** 获取现在天气情况 */
+ (void)httpForNowWeatherWithHandler:(YJRequestBlock)handler {
    [YJURLManger urlForNowWeatherWithHandler:^(NSString *url, id body) {
        [YJRequestManager getRequestWithHttpString:url classString:@"YJNowWeatherModel" httpBlock:handler sessionOutloginSucceess:nil];
    }];
}

+ (void)getRequestWithHttpString:(NSString *)url classString:(NSString *)classString httpBlock:(YJRequestBlock)block sessionOutloginSucceess:(void(^)())loginSuccess {
    /** 判断是否有网络 */
    if (block) block(YJHttpServerStart , @"请求中");
    
    /** 请求发起和解析数据 */
    	......
}
```

### YJURLManger  
此类是对URL的封装。

* 接口如下

```
/**
 获取完url后的回掉

 @param url 网络请求路径
 @param body body参数
 */
typedef void (^UrlBlock) (NSString * url , id body);

/**
 获取现在天气情况
 
 @param handler 回调
 */
+ (void)urlForNowWeatherWithHandler:(UrlBlock)handler;
```

* 调用方式见YJRequestManager实现原理

* 实现原理

```
+ (void)urlForNowWeatherWithHandler:(UrlBlock)handler {
    NSString * url = @"https://api.seniverse.com/v3/weather/now.json?key=qltdahy3vbzkgioj&location=beijing&language=zh-Hans&unit=c";
     if (handler) handler(url, nil);
}
```

## model
ViewModel中包含了两个类 YJDataBaseModel与YJNowWeatherModel。
### YJDataBaseModel
此类为YJNowWeatherModel的父类，用于判断数据是否返回成功和数据解析。

```
/** 返回代码的定义 */
typedef NS_ENUM(NSInteger, AnalyzeDataResult) {
    AnalyzeData_Success    = 1 ,    /** 1:成功 */
    AnalyzeData_SessionOut = 0 ,    /** 0:超时 */
    AnalyzeData_Fail       = -1 ,   /** -1:出错 */
};

typedef void(^analyzeDataBlock)( AnalyzeDataResult ret , id object);
```

* 接口如下

```
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
```

* 实现原理

```
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
    // 状态码
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
```

### YJNowWeatherModel
此类为实时天气model，继承于YJDataBaseModel

* 重写父类+analyzeData:resultBlock:方法

```
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
```

## 未完TODO
* 文件下载上传
* UI界面













