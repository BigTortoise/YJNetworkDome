//
//  ViewController.m
//  YJNetworkDome
//
//  Created by devRen on 2017/4/18.
//  Copyright © 2017年 devRen. All rights reserved.
//

#import "ViewController.h"
#import "YJRequestManager.h"
#import "YJNowWeatherModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [YJRequestManager httpForNowWeatherWithHandler:^(YJRequestResult result, id object) {
        if (result == YJHttpServerStart) {
            /** 开始请求 */
        } else if (result == YJHttpServerError){
            /** 请求失败 */
        } else if (result == YJHttpServerSuccess){
            /** 请求数据返回成功 */
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
