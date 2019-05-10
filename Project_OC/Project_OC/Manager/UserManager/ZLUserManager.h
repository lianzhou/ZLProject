//
//  ZLUserManager.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UserLoginType){
    kUserLoginTypeUnKnow = 0,//未知
    kUserLoginTypeWeChat,//微信登录
    kUserLoginTypeQQ,///QQ登录
    kUserLoginTypePwd,///账号登录
};

typedef void (^loginBlock)(BOOL success, NSString * des);

#define isLogin [ZLUserManager shareInstance].isLogined
#define zlUser [ZLUserManager shareInstance].zlUserInfo
#define userManager [ZLUserManager shareInstance]

@interface ZLUserManager : NSObject

//单例
SHARED_INSTANCE_DECLARE(ZLUserManager)

///当前用户
@property (nonatomic, strong) ZLUserInfo *zlUserInfo;
@property (nonatomic, assign) UserLoginType loginType;
///登录状态
@property (nonatomic, assign) BOOL isLogined;

#pragma mark - ——————— 登录相关 ————————

/**
 三方登录
 
 @param loginType 登录方式
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion;

/**
 带参登录
 
 @param loginType 登录方式
 @param params 参数，手机和账号登录需要
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion;

/**
 自动登录
 
 @param completion 回调
 */
-(void)autoLoginToServer:(loginBlock)completion;

/**
 退出登录
 
 @param completion 回调
 */
- (void)logout:(loginBlock)completion;

/**
 加载缓存用户数据
 
 @return 是否成功
 */
-(BOOL)loadUserInfo;

@end

NS_ASSUME_NONNULL_END
