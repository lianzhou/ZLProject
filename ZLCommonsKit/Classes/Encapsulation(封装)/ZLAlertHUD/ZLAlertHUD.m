//
//  ZLAlertHUD.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertHUD.h"

@implementation ZLAlertHUD


#pragma mark - MBProgressHUD
#pragma mark - 显示
+ (MBProgressHUD *)showHUDTitle:(NSString *)title
                     customView:(UIView *)customView
                         toView:(UIView *)view
                      hideAfter:(NSTimeInterval)afterSecond{
    return [MBProgressHUD showHUDTitle:title
                            customView:customView
                                toView:view
                             hideAfter:afterSecond];
}
+ (MBProgressHUD *)showHUDTitle:(NSString *)title{
    return [MBProgressHUD showHUDTitle:title];
}
+ (MBProgressHUD *)showHUDTitle:(NSString *)title
                         toView:(UIView *)view{
    
    NSLog(@"----------++++++%@",NSStringFromClass([[view nextResponder] class]));
    
    return [MBProgressHUD showHUDTitle:title
                                toView:view];
}

+ (MBProgressHUD *)showHUDCustomView:(UIView *)customView
                              toView:(UIView *)view{
    return [MBProgressHUD showHUDCustomView:customView
                                     toView:view];
}
+ (MBProgressHUD *)showHUDTitle:(NSString *)title
                     customView:(UIView *)customView
                         toView:(UIView *)view{
    return [MBProgressHUD showHUDTitle:title
                            customView:customView
                                toView:view];
    
}
+ (MBProgressHUD *)showHUDTitle:(NSString *)title
                         toView:(UIView *)view
                 imageNamedType:(ZLHUDImageNamedType)imageNamedType{
    return [MBProgressHUD showHUDTitle:title
                                toView:view
                        imageNamedType:imageNamedType];
}

#pragma mark - automatic 自动隐藏
+ (MBProgressHUD *)showTipTitle:(NSString *)title{
    return [MBProgressHUD showTipTitle:title];
}
+ (MBProgressHUD *)showTipTitle:(NSString *)title
                         toView:(UIView *)view{
    return [MBProgressHUD showTipTitle:title
                                toView:view];
}
+ (MBProgressHUD *)showTipCustomView:(UIView *)customView
                              toView:(UIView *)view{
    return [MBProgressHUD showTipCustomView:customView
                                     toView:view];
}
+ (MBProgressHUD *)showTipTitle:(NSString *)title
                     customView:(UIView *)customView
                         toView:(UIView *)view{
    return [MBProgressHUD showTipTitle:title
                            customView:customView
                                toView:view];
    
}
+ (MBProgressHUD *)showTipTitle:(NSString *)title
                         toView:(UIView *)view
                 imageNamedType:(ZLHUDImageNamedType)imageNamedType{
    return [MBProgressHUD showTipTitle:title
                                toView:view
                        imageNamedType:imageNamedType];
}

#pragma mark - 隐藏
+(void)hideHUD:(UIView *)view{
    [MBProgressHUD hideHUD:view];
}


#pragma mark ————— 顶部tip —————
+ (void)showTopTipMessage:(NSString *)msg {
    [self showTopTipMessage:msg isWindow:NO];
}

+ (void)showTopTipMessage:(NSString *)msg isWindow:(BOOL) isWindow{
    CGFloat padding = 10;
    
    YYLabel *label = [YYLabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.8];
    label.width = kScreenW;
    label.textContainerInset = UIEdgeInsetsMake(padding+padding, padding, 0, padding);
    
    if (isWindow) {
        label.height = ZLNavBarHeight;
        label.bottom = 0;
        [ZLAppWindow addSubview:label];
        
        [UIView animateWithDuration:0.3 animations:^{
            label.top = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                label.bottom = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
        
    }else{
        label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
        label.bottom = (kiOS7Later ? 64 : 0);
        [[ZLAppDelegate getCurrentUIVC].view addSubview:label];
        
        [UIView animateWithDuration:0.3 animations:^{
            label.top = (kiOS7Later ? 64 : 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                label.bottom = (kiOS7Later ? 64 : 0);
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
        
    }
    
}

@end
