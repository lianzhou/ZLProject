//
//  AppDelegate+AppService.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

/** 包含第三方 和 应用内业务的实现，减轻入口代码压力 */
@interface AppDelegate (AppService)

/**初始化服务*/
-(void)initService;

/**初始化 window*/
-(void)initWindow;

/**初始化 UMeng*/
-(void)initUMeng;

/**初始化用户系统*/
-(void)initUserManager;

/**监听网络状态*/
- (void)monitorNetworkStatus;

/**初始化网络配置  0:正式 1:测试 */
-(void)NetWorkConfig:(int)host;

/**单例*/
+ (AppDelegate *)shareAppDelegate;

/** 当前顶层控制器 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;

@end

NS_ASSUME_NONNULL_END
