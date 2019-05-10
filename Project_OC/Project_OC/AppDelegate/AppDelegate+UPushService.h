//
//  AppDelegate+UPushService.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN
//友盟推送
@interface  AppDelegate (UPushService)

-(void)pushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
