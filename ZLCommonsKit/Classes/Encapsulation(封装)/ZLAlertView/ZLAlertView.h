//
//  ZLAlertView.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLAlertButtonView.h"
#import "ZLAlertInfoView.h"
 

@interface ZLAlertView : NSObject


/**
 ZLAlertView 确认 + 取消按钮 无子标题

 @param title 标题
 @param contents 显示内容
 @param cancelButtonTitle 左边👈按钮标题  值为nil或空字符串时，按钮不显示
 @param otherButtonTitles 右边👉按钮标题  值为nil或空字符串时，按钮不显示
 @param alertBlock 按钮回调
 @return nil
 */
+ (instancetype _Nullable)alertWithTitle:(nullable NSString *)title
                       content:(nullable NSArray<NSString *> *)contents
                     headImage:(nullable UIImage *)headImage
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable NSString *)otherButtonTitles
                         block:(nullable ZLAlertBaseBlock)alertBlock;


/**
 ZLAlertView 确认 + 取消按钮 + 子标题

 @param title 标题
 @param subTitle 子标题
 @param contents 显示内容
 @param cancelButtonTitle 左边👈按钮标题 值为nil或空字符串时，按钮不显示
 @param otherButtonTitles 右边👉按钮标题 值为nil或空字符串时，按钮不显示
 @param alertBlock 按钮回调
 @return nil
 */
+ (instancetype _Nullable)alertWithTitle:(nullable NSString *)title
                      subTitle:(nullable NSString *)subTitle
                     headImage:(nullable UIImage *)headImage
                       content:(nullable NSArray<NSString *> *)contents
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable NSString *)otherButtonTitles
                         block:(nullable ZLAlertBaseBlock)alertBlock;


/**
 ZLAlertView 纯文本弹窗
 
 @param title 标题
 @param contents 显示内容
 @return nil
 */
+ (instancetype _Nullable)alertWithTitle:(nullable NSString *)title
                       content:(nullable id)contents;

 


@end
