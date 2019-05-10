//
//  AppDelegate.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/7.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化window
    [self initWindow];
    
    //初始化网络请求配置  0:正式 1:测试
    [self NetWorkConfig:0];
    
    //UMeng初始化
    [self initUMeng];
    
    //初始化app服务
    [self initService];
    
    //初始化用户系统
    [self initUserManager];
    
    //网络监听
    [self monitorNetworkStatus];
    
    //广告页
    [AppManager appStart];
    
    return YES;
}



#pragma mark ====== AppDelegate ======
//程序即将变成活跃状态
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

//程序已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

//程序将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

//程序将要变成活跃状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

//程序将要被终止
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
