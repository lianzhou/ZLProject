//
//  ZLSystemMacrocDefine.h
//  ZLCommonsKit
//
//  Created by zhoulian on 17/6/9.
//

#ifndef ZLSystemMacrocDefine_h
#define ZLSystemMacrocDefine_h

#import "ZLSystemUtils.h"               /* 系统相关 */


//颜色
 

// 十六进制颜色代码
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0xFF)) / 255.0 alpha : 1.0]

#define UIColorRGB(r, g, b) [ZLSystemUtils colorFromRed:(r) green:(g) blue:(b)] //RGB颜色
#define UIColorRGBA(r, g, b, a) [ZLSystemUtils colorFromRed:(r) green:(g) blue:(b) withAlpha:(a)]   //RGB颜色+透明
#define UIColorFromHex(rgbValue) [ZLSystemUtils colorFromHexString:((__bridge NSString *)CFSTR(#rgbValue))]
#define UIColorRandomColor [ZLSystemUtils randomColor]


#define ZLCheckObjectNull(object) [ZLSystemUtils isNullObject:object]    //检查对象是否为空
#define ZLCheckKeyValueHasNull(keyObj,valueObj) [ZLSystemUtils checkValue:valueObj key:keyObj]  //检查一个valueObj,keyObj对象是否有一个是空的

#define ZLCheckArrayNull(object) [ZLSystemUtils arrayIsNull:object]  //检查数组是否是空的

#define ZLSystemiPhone6Plus [ZLSystemUtils iPhone6PlusDevice]

#define ZLSystemiPhone6 [ZLSystemUtils iPhone6Device]

#define ZLSystemiPhone5 [ZLSystemUtils iPhone5Device]

#define ZLSystemiPhone4 [ZLSystemUtils iPhone4Device]

#define ZL_IOS7  ([ZLSystemUtils iPhoneDeviceVersion:7.0])
#define ZL_IOS8  ([ZLSystemUtils iPhoneDeviceVersion:8.0])
#define ZL_IOS9  ([ZLSystemUtils iPhoneDeviceVersion:9.0])
#define ZL_IOS10 ([ZLSystemUtils iPhoneDeviceVersion:10.0])
#define ZL_IOS11 ([ZLSystemUtils iPhoneDeviceVersion:11.0])
#define ZL_IOS12 ([ZLSystemUtils iPhoneDeviceVersion:12.0])

//设备
#define ZL_IPHONE_4 [UIScreen mainScreen].bounds.size.height == 480
#define ZL_IPHONE_5 [UIScreen mainScreen].bounds.size.height == 568
#define ZL_IPHONE_6 [UIScreen mainScreen].bounds.size.height == 667
#define ZL_IPHONE_6p [UIScreen mainScreen].bounds.size.height == 736
#define ZL_IPHONE_X [UIScreen mainScreen].bounds.size.height >= 812



#define  ZL_BLOCK(block, ...) if (block) { block(__VA_ARGS__);}; 

#define ZL_TempPath              NSTemporaryDirectory()
#define ZL_DocumentPath          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define ZL_CachePath             [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define ZLRootViewController [UIApplication sharedApplication].delegate.window.rootViewController


//定义UIImage对象
#define ZL_ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define ZL_IMAGE_NAMED(name) [UIImage imageNamed:name]

#pragma mark - 消除黄色警告⚠️

//找不到函数的黄色警告
#define ZLPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//方法可能弃用的警告
#define ZLDeprecatedSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#endif /* ZLSystemMacrocDefine_h */
