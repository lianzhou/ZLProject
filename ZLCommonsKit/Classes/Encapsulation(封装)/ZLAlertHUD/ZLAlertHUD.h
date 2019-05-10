//
//  ZLAlertHUD.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+ZLExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZLAlertHUD : NSObject


#pragma mark - MBProgressHUD
#pragma mark - 显示
+ (MBProgressHUD *)showHUDTitle:(NSString *)title
                     customView:(UIView *)customView
                         toView:(UIView *)view
                      hideAfter:(NSTimeInterval)afterSecond;
+ (MBProgressHUD *)showHUDTitle:(NSString *)title;
+ (MBProgressHUD *)showHUDTitle:(NSString *)title
                         toView:(UIView *)view ;
+ (MBProgressHUD *)showHUDCustomView:(UIView *)customView
                              toView:(UIView *)view ;
+ (MBProgressHUD *)showHUDTitle:(NSString *)title
                     customView:(UIView *)customView
                         toView:(UIView *)view;
+ (MBProgressHUD *)showHUDTitle:(NSString *)title
                         toView:(UIView *)view
                 imageNamedType:(ZLHUDImageNamedType)imageNamedType;

#pragma mark ————— 顶部tip —————
+ (void)showTopTipMessage:(NSString *)msg;
+ (void)showTopTipMessage:(NSString *)msg isWindow:(BOOL) isWindow;

#pragma mark - automatic 自动隐藏
+ (MBProgressHUD *)showTipTitle:(NSString *)title;
+ (MBProgressHUD *)showTipTitle:(NSString *)title
                         toView:(UIView *)view ;
+ (MBProgressHUD *)showTipCustomView:(UIView *)customView
                              toView:(UIView *)view;
+ (MBProgressHUD *)showTipTitle:(NSString *)title
                     customView:(UIView *)customView
                         toView:(UIView *)view;
+ (MBProgressHUD *)showTipTitle:(NSString *)title
                         toView:(UIView *)view
                 imageNamedType:(ZLHUDImageNamedType)imageNamedType;

#pragma mark - 隐藏
+(void)hideHUD:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
