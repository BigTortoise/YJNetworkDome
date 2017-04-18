# YJNetworkDome
AFN框架的二次封装以及JSON与Model的转化  
### YJAFNetManager
对AFNetWorking的封装 

```
[YJAFNetManager GET_Path:url completed:^(NSData *stringData, id JSONDict) {
     // 解析数据
     [NSClassFromString(classString) analyzeData:stringData resultBlock:^(AnalyzeDataResult ret, id object) {
     	if (ret == AnalyzeData_Fail) {
     		if (block) {
     			block(KCHttpServerError , object);
     		}
     	} else if(ret == AnalyzeData_Success){
     		if (block){
     			block(KCHttpServerSuccess , object);
     		}
     	} else if (ret == AnalyzeData_SessionOut){
     		// 登录超时的情况
     	}
     }];
     
     } failed:^(NSError *error) {
     	NSString * errorMsg = error.localizedFailureReason.length != 0 ? error.localizedFailureReason:@"请求错误<未知原因>" ;
     	if (block) block(KCHttpServerError,errorMsg);
     }];
```

### ViewModel
* YJURLManger
* YJRequestManager