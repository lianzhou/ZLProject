//
//  AppDelegate+JPushService.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "AppDelegate+JPushService.h"



@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (nonatomic, strong) NSDictionary *userInfo;

@end
@implementation  AppDelegate (JPushService)

-(void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    /*
     
     //初始化极光推送
     NSString *kJPushChannel;
     BOOL isProduction;
     #ifdef DEBUG
     kJPushChannel = @"In-house Testing";
     isProduction = NO;
     #else
     kJPushChannel = @"App Store";
     isProduction = YES;
     #endif
     
     JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc]init];
     entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
     
     //获取自定义消息
     [ZLNotificationCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
     [ZLNotificationCenter addObserver:self selector:@selector(networkDidLogin:)
     name:kJPFNetworkDidLoginNotification object:nil];
     //可以添加自定义categories  ios 8.0
     [JPUSHService registerForRemoteNotificationTypes:( UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert) categories:nil];
     
     [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
     [JPUSHService setupWithOption:launchOptions appKey:appJPushKey channel:kJPushChannel apsForProduction:isProduction advertisingIdentifier:nil];
     */
}

#pragma mark 获取自定义消息内容
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSLog(@"获取自定义消息内容--%@",userInfo);
    NSDictionary *extra = [userInfo valueForKey:@"extras"];
    self.userInfo=extra;
}

// 在app进入前台后，将icon右上角的红字置为0
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

-(void)setJPushAlias:(NSString *)alias{
    //    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    //        ZLLog(@"setJPushAlias----%@ :  %zd",alias,iResCode);
    //    } seq:10];
}

//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    /// Required - 注册 DeviceToken  onoe
    //    [JPUSHService registerDeviceToken:deviceToken];
}

//要获得registeID,可以在这里获取啊
- (void)networkDidLogin:(NSNotification *)notification {
    //下面是我拿到registeID,发送给服务器的代码，可以根据你需求来处理
    //  NSString *registerid = [JPUSHService registrationID];
    
    //   NSLog(@"要获得registeID,可以在这里获取啊--%@",registerid);
    
}
//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//请在AppDelegate.m实现该回调方法并添加回调方法中的代码
#pragma mark- JPUSHRegisterDelegate
//// iOS 10 Support  此状态为活跃状态 即app在前台获取通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler{
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //   [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
    } else {
        // Fallback on earlier versions
    }
    //现在需要来处理自己的逻辑了(跳转等等)，现在推送的消息都在userInfo里面。。。。。。
    self.userInfo=userInfo;
}

// iOS 10 Support 锁屏 横幅
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //      [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
    } else {
        // Fallback on earlier versions
    } // // 系统要求执行这个方法
    //现在需要来处理自己的逻辑了(跳转等等)，现在推送的消息都在userInfo里面。。。。。。
    self.userInfo=userInfo;
}


//活跃状态 锁屏进来
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    //   [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    //现在需要来处理自己的逻辑了(跳转等等)，现在推送的消息都在userInfo里面。。。。。。
    self.userInfo=userInfo;
}

//活跃状态
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    //   [JPUSHService handleRemoteNotification:userInfo];
    
    //        NSInteger num = [UIApplication sharedApplication].applicationIconBadgeNumber;
    //        [UIApplication sharedApplication].applicationIconBadgeNumber = num + 1;
    //现在需要来处理自己的逻辑了(跳转等等)，现在推送的消息都在userInfo里面。。。。。。
    self.userInfo=userInfo;
}


- (void)setUserInfo:(NSDictionary *)userInfo{
    //对接收信息的处理
    if(userInfo==nil)return;
    @try
    {
        NSString * category = userInfo[@"category"];
        NSString * operation = userInfo[@"operation"];
        NSDictionary *body =  nil;//[userInfo valueForKey:@"body"];
        NSDictionary *extras = nil;// [userInfo valueForKey:@"extra"];
        
        id bodyObj = [userInfo valueForKey:@"body"];
        
        if([bodyObj isKindOfClass:[NSDictionary class]])
        {
            body=bodyObj;
        }
        else  if([bodyObj isKindOfClass:[NSString class]])
        {
            body = [NSString jsonStringToNSDictionary:bodyObj];
        }
        
        id extrasObj = [userInfo valueForKey:@"extra"];
        
        if([extrasObj isKindOfClass:[NSDictionary class]])
        {
            extras=extrasObj;
        }
        else  if([extrasObj isKindOfClass:[NSString class]])
        {
            extras = [NSString jsonStringToNSDictionary:extrasObj];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"对接收信息的处理  %s\n%@", __FUNCTION__, exception);
    }
    @finally {
        // 8
        NSLog(@"tryTwo -对接收信息的处理-- 我一定会执行");
    }
}



@end
