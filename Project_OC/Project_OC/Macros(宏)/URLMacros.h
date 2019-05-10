//
//  URLMacros.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1

/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

 

//验证码倒计时
#define kDefaultCodeCountdown 60

//分页每页数据数量
#define kDefaultPageSize @"20"


#pragma mark - ——————— 详细接口地址 ————————

//测试接口
#define URL_Test @"/api/cast/home/start"

#pragma mark - ——————— 用户相关 ————————

//登录
#define URL_user_login @"/app/family/loginByPassword"
//用户详情
#define URL_user_info_detail @"/api/user/info/detail"
//自动登录
#define URL_user_auto_login @"/api/autoLogin"

#endif /* URLMacros_h */
