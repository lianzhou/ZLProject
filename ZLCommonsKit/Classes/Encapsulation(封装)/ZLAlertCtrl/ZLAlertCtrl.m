//
//  ZLAlertCtrl.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertCtrl.h"


@interface ZLAlertCtrl ()


@end

@implementation ZLAlertCtrl

static ZLAlertCtrl *instance = nil;

+ (ZLAlertCtrl *) sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZLAlertCtrl alloc] init];
    });
    return instance;
}

+ (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
      otherButtonTitle:(nullable NSString *)otherButtonTitle
                 block:(nullable UIAlertViewCallBackBlock)alertBlock {
    
    [self alertShowTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle  withDissmissButton:YES block:alertBlock];
}
+ (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
      otherButtonTitle:(nullable NSString *)otherButtonTitle
    withDissmissButton:(BOOL)isShow
                 block:(nullable UIAlertViewCallBackBlock)alertBlock {
    
    [self alertShowTitle:title message:message withIconImageName:nil cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle withDissmissButton:isShow block:alertBlock];
}
//只有标题、内容、按钮、删除按钮、图标
+ (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     withIconImageName:(nullable NSString *)iconImageName
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
      otherButtonTitle:(nullable NSString *)otherButtonTitle
    withDissmissButton:(BOOL)isShow
                 block:(nullable UIAlertViewCallBackBlock)alertBlock {
    
    [[ZLAlertCtrl sharedInstance] alertShowTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle withIconImageName:iconImageName withDissmissButton:isShow block:alertBlock];
}

//自定义View
+ (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
            customView:(ZLCustomAlertView *_Nullable)customView
    withDissmissButton:(BOOL)isShow
                 block:(nullable UIAlertViewCallBackBlock)alertBlock {
    ZLAlertViewController *alertViewCtrl = [ZLAlertViewController zl_alertControllerWithTitle:title withMessage:message withCustomView:customView withCallBackBlock:^(NSInteger buttonIndex) {
        if (alertBlock) {
            alertBlock(buttonIndex);
        }
    }];
    alertViewCtrl.isShow = isShow;
    
    UIViewController *currentCtrl =ZLRootViewController;
    [currentCtrl presentViewController:alertViewCtrl animated:YES completion:^{
        
    }];
    
}

- (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
      otherButtonTitle:(nullable NSString *)otherButtonTitle
     withIconImageName:(nullable NSString *)iconImageName
    withDissmissButton:(BOOL)isShow
                 block:(nullable UIAlertViewCallBackBlock)alertBlock {
    
    ZLAlertViewController *alertViewCtrl = [ZLAlertViewController zl_alertControllerWithTitle:title withMessage:message withIconImage:iconImageName withCallBackBlock:^(NSInteger buttonIndex) {
        if (alertBlock) {
            alertBlock(buttonIndex);
        }
    }];
    alertViewCtrl.isShow = isShow;
    if(ZLStringIsNull(otherButtonTitle)){
        if (ZLStringIsNull(cancelButtonTitle)) {
            cancelButtonTitle = @"返回";
        }
        ZLAlertAction *cancleAction = [ZLAlertAction zl_actionWithTitle:cancelButtonTitle withTitleSize:[UIFont systemFontOfSize:17.0f] withTitleColor:[UIColor whiteColor] withBgColor:[UIColor orangeColor] handler:^(ZLAlertAction *action) {
            
        }];
        
        [alertViewCtrl addAction:cancleAction];
    }else{
        if (!ZLStringIsNull(cancelButtonTitle)) {
            ZLAlertAction *cancleAction = [ZLAlertAction zl_actionWithTitle:cancelButtonTitle withTitleSize:[UIFont systemFontOfSize:17.0f] withTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor] handler:^(ZLAlertAction *action) {
                
            }];
            [alertViewCtrl addAction:cancleAction];
        }
    }
    if(!ZLStringIsNull(otherButtonTitle)){
        ZLAlertAction *sureAction = [ZLAlertAction zl_actionWithTitle:otherButtonTitle withTitleSize:[UIFont systemFontOfSize:17.0f] withTitleColor:UIColorHex(0xffffff) withBgColor:UIColorHex(0xff6f26) handler:^(ZLAlertAction *action) {
            
        }];
        
        [alertViewCtrl addAction:sureAction];
    }
    
    UIViewController *currentCtrl =ZLRootViewController;
    [currentCtrl presentViewController:alertViewCtrl animated:YES completion:^{

    }];
 
}

@end
