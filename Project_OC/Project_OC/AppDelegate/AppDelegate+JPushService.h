//
//  AppDelegate+JPushService.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "AppDelegate.h"


//引入JSPush功能所需头文件
//#import "JPUSHService.h"
//ios 10注册APNS所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>


NS_ASSUME_NONNULL_BEGIN

//极光推送
@interface AppDelegate (JPushService)//<JPUSHRegisterDelegate>

-(void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(void)setJPushAlias:(NSString *)alias;

@end

NS_ASSUME_NONNULL_END

#endif



