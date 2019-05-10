//
//  AppManager.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "AppManager.h"
#import "BaseNavigationController.h"
#import "AdPageView.h"

@implementation AppManager

+(void)appStart{
    //加载广告
    AdPageView *adView = [[AdPageView alloc] initWithFrame:SCREEN_BOUNDS withTapBlock:^{
        BaseNavigationController *loginNavi =[[BaseNavigationController alloc] initWithRootViewController:[[RootWebViewController alloc] initWithUrl:@"http://www.hao123.com"]];
        [ZLRootViewController presentViewController:loginNavi animated:YES completion:nil];
    }];
    adView = adView;
}

@end
