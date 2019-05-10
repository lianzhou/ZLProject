//
//  ZLAlertCtrl.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLAlertViewController.h"

typedef void(^UIAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface ZLAlertCtrl : NSObject


/**
 只有标题、内容、按钮

 @param title title
 @param message message
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitle otherButtonTitle
 @param alertBlock alertBlock
 */
+ (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
      otherButtonTitle:(nullable NSString *)otherButtonTitle
                 block:(nullable UIAlertViewCallBackBlock)alertBlock;


/**
 只有标题、内容、按钮、删除按钮

 @param title title
 @param message message
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitle otherButtonTitle
 @param isShow isShow
 @param alertBlock alertBlock
 */
+ (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
      otherButtonTitle:(nullable NSString *)otherButtonTitle
    withDissmissButton:(BOOL)isShow
                 block:(nullable UIAlertViewCallBackBlock)alertBlock;


/**
 只有标题、内容、按钮、删除按钮、图标

 @param title title
 @param message message
 @param iconImageName iconImageName
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitle otherButtonTitle
 @param isShow isShow
 @param alertBlock alertBlock
 */
+ (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     withIconImageName:(nullable NSString *)iconImageName
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
      otherButtonTitle:(nullable NSString *)otherButtonTitle
    withDissmissButton:(BOOL)isShow
                 block:(nullable UIAlertViewCallBackBlock)alertBlock;

/**
 自定义View

 @param title title
 @param message message
 @param customView customView
 @param isShow isShow
 */
+ (void)alertShowTitle:(nullable NSString *)title
               message:(nullable NSString *)message
            customView:(ZLCustomAlertView *_Nullable)customView
    withDissmissButton:(BOOL)isShow
                 block:(nullable UIAlertViewCallBackBlock)alertBlock;

@end
