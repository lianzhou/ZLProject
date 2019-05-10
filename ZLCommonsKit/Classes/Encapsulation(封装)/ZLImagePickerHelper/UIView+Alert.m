//
//  UIView+Alert.m
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <objc/runtime.h>

#import "UIView+Alert.h" 

#import "MBProgressHUD.h"

@implementation UIView (Alert)

#pragma mark - Alert

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void(^)(UIAlertAction *confirmAction))handler {
    [self showAlertWithTitle:title message:message confirmTitle:@"确定" confirmHandler:handler];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler {
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmlAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:handler];
    [self showAlertWithTitle:title message:message cancelAction:cancelAction confirmAction:confirmlAction];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelAction:(UIAlertAction *)cancelAction confirmAction:(UIAlertAction *)confirmAction {
    
    if (cancelAction == nil && confirmAction == nil) return;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    cancelAction != nil ? [alertController addAction:cancelAction] : nil;
    confirmAction != nil ? [alertController addAction:confirmAction] : nil;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - HUD

static void *HUDKEY = &HUDKEY;
- (MBProgressHUD *)HUD {
    return objc_getAssociatedObject(self, HUDKEY);
}

- (void)setHUD:(MBProgressHUD *)HUD {
    objc_setAssociatedObject(self, HUDKEY, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHUD {
    [self showHUDWithText:@""];
}

- (void)showHUDWithText:(NSString *)text {
    MBProgressHUD *HUD = [self HUD];
    if (!HUD) {
//        HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        //HUD.dimBackground = NO;
        HUD.removeFromSuperViewOnHide = YES;
        HUD.mode             = MBProgressHUDModeText;
        HUD.label.font       = [UIFont systemFontOfSize:16];
        HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
        HUD.animationType    = MBProgressHUDAnimationZoomOut;
        
        //HUD.detailsLabel.text = text;
        [self setHUD:HUD];
    }
    if (text.length == 0)
    {
        //msg = @"加载中...";
        HUD.mode = MBProgressHUDModeIndeterminate;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.label.text = text;
    [HUD showAnimated:YES];
}

- (void)hideHUD {
    [[self HUD] hideAnimated:YES];
    //[MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow  animated:YES];
}


@end

@implementation UIViewController (Alert)

- (void)showHUD {
    [self.view showHUD];
}

- (void)showHUDWithText:(NSString *)text {
    [self.view showHUDWithText:text];
}

- (void)hideHUD {
    [self.view hideHUD];
}


- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void(^)(UIAlertAction *confirmAction))handler {
    [self.view showAlertWithTitle:title message:message confirmHandler:handler];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler {
    [self.view showAlertWithTitle:title message:message confirmTitle:confirmTitle confirmHandler:handler];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelAction:(UIAlertAction *)cancelAction confirmAction:(UIAlertAction *)confirmAction {
    [self.view showAlertWithTitle:title message:message cancelAction:cancelAction confirmAction:confirmAction];
}


@end

@implementation NSObject (Alert)

- (void)showHubMsg:(NSString *)msg
{
    MBProgressHUD *hud   = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode             = MBProgressHUDModeText;
    hud.label.font       = [UIFont systemFontOfSize:16];
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.animationType    = MBProgressHUDAnimationZoomOut;
    if (msg.length == 0)
    {
        //msg = @"加载中...";
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    hud.detailsLabel.text = msg;
}

/**
 隐藏
 */
- (void)hideHub
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow  animated:YES];
}
@end
