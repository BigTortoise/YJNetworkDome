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
    
    [YJRequestManager httpForNowWeatherModelWithHandler:^(YJRequestResult result, id object) {
        if (result == YJHttpServerStart) {

        } else if (result == YJHttpServerError){
            
        } else if (result == YJHttpServerSuccess){
            YJNowWeatherModel *nowWeather = object;
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
