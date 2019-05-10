//
//  AppDelegate+UPushService.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "AppDelegate+UPushService.h"

//#import <UMCommon/UMCommon.h>
//#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation  AppDelegate (UPushService)

#pragma mark —————
-(void)pushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    /*
     [UMConfigure initWithAppkey:UM_APP_ID channel:@"App Store"];
     
     // Push功能配置
     UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
     entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
     //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
     if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
     UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
     action1.identifier = @"action1_identifier";
     action1.title=@"打开应用";
     action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
     
     UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
     action2.identifier = @"action2_identifier";
     action2.title=@"忽略";
     action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
     action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
     action2.destructive = YES;
     UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
     actionCategory1.identifier = @"category1";//这组动作的唯一标示
     [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
     NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
     entity.categories=categories;
     }
     
     if (@available(iOS 10.0, *)) {
     
     UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
     UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
     
     //UNNotificationCategoryOptionNone
     //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
     //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
     UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
     NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
     entity.categories=categories;
     
     [UNUserNotificationCenter currentNotificationCenter].delegate=self;
     } else {
     // Fallback on earlier versions
     }
     
     [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
     if (granted) {
     //点击允许
     //这里可以添加一些自己的逻辑
     
     } else {
     //点击不允许
     //这里可以添加一些自己的逻辑
     BSAlertView * alert = [[BSAlertView alloc]initWithTitle:@"温馨提示" message:@"您拒绝了通知服务,将无法收到新消息推送了\n是否开启" sureBtn:@"是" cancleBtn:@"否"];
     [alert show];
     alert.resultIndex = ^(NSInteger index) {
     if (index == 2) {
     NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
     if ([[UIApplication sharedApplication] canOpenURL:url]) {
     [[UIApplication sharedApplication] openURL:url];
     }
     }
     };
     }
     }];
     */
}

#pragma mark —接收推送


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    //接受服务端推送通知传来的值，全部在userinfo里面。
    //  [UMessage didReceiveRemoteNotification:userInfo];
    
    
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        // [UMessage setAutoAlert:NO];
        //必须加这句代码
        //  [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        //[UMessage didReceiveRemoteNotification:userInfo];
        if(userInfo.count>0){
            
            self.userInfo = userInfo;
            //消息处理
            NSLog(@"跳转到你想要的");
        }
    }else{
        //应用处于后台时的本地推送接受
    }
}

//iOS10以下使用这两个方法接收通知，
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    //   [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        //    [UMessage didReceiveRemoteNotification:userInfo];
        
        if(userInfo.count>0){
            
            self.userInfo = userInfo;
            //消息处理
            NSLog(@"跳转到你想要的");
        }
        
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

//打印设备注册码，需要在友盟测试设备上自己添加deviceToken
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    
    //    [UMessage registerDeviceToken:deviceToken];
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken success");
    NSString *strDeviceToken=[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<"withString: @""]
                               stringByReplacingOccurrencesOfString: @">"withString: @""]
                              stringByReplacingOccurrencesOfString: @" "withString: @""];
    
    NSLog(@"deviceToken————>>>%@", strDeviceToken);
    
}


//BUSINESS_NOTIFICATION_TYPE 3700:园所录像 3701:消息详情 3702:课程详情 3703:目标详情 3704:我的订单
- (void)setUserInfo:(NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
    if (userInfo == nil || ! isLogin) {
        return;
    }
    
    //刷新程序角标
    NSInteger appBadge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    appBadge -= 1;
    
    //设置APP角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = appBadge;
    
    [self jumpTovc:userInfo];
}


-(void)jumpTovc:(NSDictionary *)userInfo{
    
    NSString *noticeID = userInfo[@"noticeId"];
    NSString *businessTypeId = userInfo[@"businessTypeId"];
    NSString *noticeTypeId = userInfo[@"noticeTypeId"];
    
    UITabBarController *tabVC = (UITabBarController*)self.window.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabVC.selectedViewController;
    
    //目标
    if ([businessTypeId isEqualToString:@"3703"]&&noticeID.length>0) {
        tabVC.selectedIndex = 1;
        
        //        ViewController *vc = ViewController.new;
        //        vc.targetId = noticeID;
        //        [nav pushViewController:vc animated:YES];
        
    }
    
}

@end
