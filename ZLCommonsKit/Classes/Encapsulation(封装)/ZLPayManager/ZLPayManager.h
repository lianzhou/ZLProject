//
//  ZLPayManager.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
//#import <AlipaySDK/AlipaySDK.h>

/**
 *  @author zhoulian
 *
 *  此处必须保证在Info.plist 中的 URL Types 的 Identifier 对应一致
 */

#if BundleTest

/**测试*/
#define ZLWECHATURLNAME @"weixin"

#else

#define ZLWECHATURLNAME @"wechat"

#endif

#define ZLALIPAYURLNAME @"zhifubao"

#define ZLPAYMANAGER [ZLPayManager shareManager]
/**
 *  @author zhoulian
 *
 *  回调状态码
 */
typedef NS_ENUM(NSInteger,ZLErrCode){
    ZLErrCodeSuccess,// 成功
    ZLErrCodeFailure,// 失败
    ZLErrCodeCancel// 取消
};

typedef void(^ZLCompleteCallBack)(ZLErrCode errCode,NSString *errStr);

@interface ZLPayManager : NSObject
/**
 *  @author zhoulian
 *
 *  单例管理
 */
+ (instancetype)shareManager;
/**
 *  @author zhoulian
 *
 *  处理跳转url，回到应用，需要在delegate中实现
 */
- (BOOL)zl_handleUrl:(NSURL *)url;
/**
 *  @author zhoulian
 *
 *  注册App，需要在 didFinishLaunchingWithOptions 中调用
 */
- (void)zl_registerApp;

/**
 *  @author zhoulian
 *
 *  发起支付
 *
 * @param orderMessage 传入订单信息,如果是字符串，则对应是跳转支付宝支付；如果传入PayReq 对象，这跳转微信支付,注意，不能传入空字符串或者nil
 * @param callBack     回调，有返回状态信息
 */
- (void)zl_payWithOrderMessage:(id)orderMessage callBack:(ZLCompleteCallBack)callBack;


@end


