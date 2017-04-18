# YJNetworkDome
AFN框架的二次封装以及JSON与Model的转化  
### YJAFNetManager
对AFNetWorking的封装 

```
/**
 单例

 @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 GET请求 - 无Body参数

 @param path 路径
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)GET_Path:(NSString *)path completed:(YJSuccessBlock)success failed:(YJFailedBlock)failed;
```

### ViewModel
* YJURLManger
* YJRequestManager