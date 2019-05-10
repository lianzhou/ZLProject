//
//  ZLWechatSDK.h
//  ZLWechat
//
//  Created by lianzhou on 16/3/8.
//  Copyright © 2016年 com.chuangkit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLWechatResult.h"

typedef void(^ZLWechatResultBlock)(ZLWechatResult *result);

@class ZLWechatShareObject;


@interface ZLWechatSDK : NSObject

+ (ZLWechatSDK *)shareSDK;

/**
 *  注册第三方SDK
 */
+ (void) registerApp;

/**
 *  在AppDelegate中注册
 */
+ (BOOL) handleOpenURL:(NSURL *)url withOptions:(NSDictionary *)options;

/**
 *  拉起第三方程序，进行登录 （如果没有安装会调用web登录）
 */
- (void) wechatlogin:(ZLWechatResultBlock) loginBlock;


/**
 拉起第三方程序，进行登录 返回 Code
 */
- (void) wechatloginCode:(ZLWechatResultBlock) loginBlock;



- (void) wechatshare:(ZLWechatShareObject *)shareObject  result:(ZLWechatResultBlock) shareBlock;

@end
