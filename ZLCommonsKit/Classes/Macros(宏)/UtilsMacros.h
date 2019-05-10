//
//  UtilsMacros.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

//获取系统对象
#define ZLApplication           [UIApplication sharedApplication]
#define ZLKeyWindow          [UIApplication sharedApplication].keyWindow
#define ZLAppWindow          [UIApplication sharedApplication].delegate.window
#define ZLAppDelegate         [AppDelegate shareAppDelegate]
#define ZLAppVersion            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define ZLTempPath              NSTemporaryDirectory()
#define ZLDocumentPath      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define ZLCachePath             [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define ZLRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

#define ZLUserDefaults       [NSUserDefaults standardUserDefaults]

#define ZLNotificationCenter    [NSNotificationCenter defaultCenter]

//发送通知
#define ZLPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//property 属性快速声明 别用宏定义了，使用代码块+快捷键实现吧

//IOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)

//当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

//当前语言
#define CurrentLanguage ([NSLocale preferredLanguages] objectAtIndex:0])

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//通知状态
#define NotificationType ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIRemoteNotificationTypeNone)

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

/****** 基本设置 ******/
//APP名称
#define AppName Localized(@"AppName")

//判断机型
#define kIsiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsiPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

//判断齐刘海
#define kIsiPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//防止block里引用self造成循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
/* 屏幕相关 */
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
//屏幕frame,bounds,size
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
//系统nav高度
#define ZLNavBarHeight (kIsiPhoneX ? 88 : 64)
//系统tabbar高度
#define ZLTabBarHeight (kIsiPhoneX ? 83 : 49)

/*! @brief * ZL
 *  获取状态栏高度
 */
#define ZLStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height

//获取安全高度
#define ZLSafeHeight (kIsiPhoneX ? 34.0f : 0)

#define ZLBottomHeight (ZLSafeHeight +ZLNavBarHeight+ZLTabBarHeight)

//根据ip6的屏幕来拉伸
#define Iphone6ScaleWidth kScreenW/375.0
#define Iphone6ScaleHeight kScreenH/667.0

//代码适配宽度和高度间距
#define ZLScale_Width(value)   Iphone6ScaleWidth* value
#define ZLScale_Height(value)  Iphone6ScaleHeight * value

#define kRowHeight  50

//-------------------打印日志-------------------------
// 重定义 NSLog
#ifdef DEBUG 
#define NSLog(FORMAT, ...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSS"]; \
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"%s %s:%d %s\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,[[NSString stringWithFormat:FORMAT,##__VA_ARGS__] UTF8String]);\
}
#else
#define NSLog(...)
#endif

//-------------------单例对象申明 -------------------
//单例对象申明.h
#define SHARED_INSTANCE_DECLARE(className)   +(className *)shareInstance;

//单例对象申明.m
#define SHARED_INSTANCE_DEFINE(className) \
+ (className *)shareInstance { \
static className *_ ## className = nil; \
if (!_ ## className) { \
_ ## className = [[className alloc] init]; \
} \
return _ ## className; \
}

//------------------- 设定view -------------------
//取view的坐标及长宽
#define ZLW(view)    view.frame.size.width
#define ZLH(view)    view.frame.size.height
#define ZLX(view)    view.frame.origin.x
#define ZLY(view)    view.frame.origin.y
#define ZLMaxX(view)   CGRectGetMaxX(view.frame)
#define ZLMaxY(view)   CGRectGetMaxY(view.frame)

//重新设定view的Y值
#define setFrameY(view, newY) view.frame = CGRectMake(view.frame.origin.x, newY, view.frame.size.width, view.frame.size.height)
#define setFrameX(view, newX) view.frame = CGRectMake(newX, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
#define setFrameH(view, newH) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newH)
#define setFrameW(view, newW) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, newW, view.frame.size.height)

//View 圆角和加边框
#define ZLViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//View 圆角 加阴影效果
#define ZLViewBorderRadiusOpacity(View , Radius, Color)\
\
View.layer.cornerRadius = (Radius);\
View.layer.shadowColor = [Color CGColor] ;\
View.layer.shadowOffset = CGSizeMake(0,5);\
View.layer.shadowOpacity = 1;\
View.layer.shadowRadius = 10\

//v.layer.masksToBounds=YES;这行去掉
// View 圆角
#define ZLViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#endif /* UtilsMacros_h */
