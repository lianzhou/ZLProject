//
//  ZLPayManager.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLPayManager.h"

// 回调url地址为空
#define ZLTIP_CALLBACKURL @"url地址不能为空！"
// 订单信息为空字符串或者nil
#define ZLTIP_ORDERMESSAGE @"订单信息不能为空！"
// 没添加 URL Types
#define ZLTIP_URLTYPE @"请先在Info.plist 添加 URL Type"
// 添加了 URL Types 但信息不全
#define ZLTIP_URLTYPE_SCHEME(name) [NSString stringWithFormat:@"请先在Info.plist 的 URL Type 添加 %@ 对应的 URL Scheme",name]


@interface ZLPayManager ()<WXApiDelegate>
// 缓存回调
@property (nonatomic,copy)ZLCompleteCallBack callBack;
// 缓存appScheme
@property (nonatomic,strong)NSMutableDictionary *appSchemeDict;
@end

@implementation ZLPayManager


+ (instancetype)shareManager{
    static ZLPayManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)zl_handleUrl:(NSURL *)url{
    
    NSAssert(url, ZLTIP_CALLBACKURL);
    if ([url.host isEqualToString:@"pay"]) {// 微信
        return [WXApi handleOpenURL:url delegate:self];
    }
    else if ([url.host isEqualToString:@"safepay"]) {/*/ 支付宝
                                                      // 支付跳转支付宝钱包进行支付，处理支付结果(在app被杀模式下，通过这个方法获取支付结果）
                                                      [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                                                      NSString *resultStatus = resultDic[@"resultStatus"];
                                                      NSString *errStr = resultDic[@"memo"];
                                                      ZLErrCode errorCode = ZLErrCodeSuccess;
                                                      switch (resultStatus.integerValue) {
                                                      case 9000:// 成功
                                                      errorCode = ZLErrCodeSuccess;
                                                      break;
                                                      case 6001:// 取消
                                                      errorCode = ZLErrCodeCancel;
                                                      break;
                                                      default:
                                                      errorCode = ZLErrCodeFailure;
                                                      break;
                                                      }
                                                      if ([ZLPayManager shareManager].callBack) {
                                                      [ZLPayManager shareManager].callBack(errorCode,errStr);
                                                      }
                                                      }];
                                                      
                                                      // 授权跳转支付宝钱包进行支付，处理支付结果
                                                      [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@",resultDic);
                                                      // 解析 auth code
                                                      NSString *result = resultDic[@"result"];
                                                      NSString *authCode = nil;
                                                      if (result.length>0) {
                                                      NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                      for (NSString *subResult in resultArr) {
                                                      if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                      authCode = [subResult substringFromIndex:10];
                                                      break;
                                                      }
                                                      }
                                                      }
                                                      NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                                      }];
                                                      return YES;*/
        return NO;
    }
    else{
        return NO;
    }
}

- (void)zl_registerApp{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *urlTypes = dict[@"CFBundleURLTypes"];
    NSAssert(urlTypes, ZLTIP_URLTYPE);
    for (NSDictionary *urlTypeDict in urlTypes) {
        NSString *urlName = urlTypeDict[@"CFBundleURLName"];
        NSArray *urlSchemes = urlTypeDict[@"CFBundleURLSchemes"];
        NSAssert(urlSchemes.count, ZLTIP_URLTYPE_SCHEME(urlName));
        // 一般对应只有一个
        NSString *urlScheme = urlSchemes.lastObject;
        if ([urlName isEqualToString:ZLWECHATURLNAME]) {
            [self.appSchemeDict setValue:urlScheme forKey:ZLWECHATURLNAME];
            // 注册微信
            [WXApi registerApp:urlScheme];
        }
        else if ([urlName isEqualToString:ZLALIPAYURLNAME]){
            // 保存支付宝scheme，以便发起支付使用
            // [self.appSchemeDict setValue:urlScheme forKey:ZLALIPAYURLNAME];
        }
        else{
            
        }
    }
}

- (void)zl_payWithOrderMessage:(id)orderMessage callBack:(ZLCompleteCallBack)callBack{
    NSAssert(orderMessage, ZLTIP_ORDERMESSAGE);
    // 缓存block
    self.callBack = callBack;
    // 发起支付
    if ([orderMessage isKindOfClass:[PayReq class]]) {
        // 微信
        NSAssert(self.appSchemeDict[ZLWECHATURLNAME], ZLTIP_URLTYPE_SCHEME(ZLWECHATURLNAME));
        
        [WXApi sendReq:(PayReq *)orderMessage];
    }
    else if ([orderMessage isKindOfClass:[NSString class]]){
        /*/ 支付宝
         NSAssert(![orderMessage isEqualToString:@""], ZLTIP_ORDERMESSAGE);
         NSAssert(self.appSchemeDict[ZLALIPAYURLNAME], ZLTIP_URLTYPE_SCHEME(ZLALIPAYURLNAME));
         [[AlipaySDK defaultService] payOrder:(NSString *)orderMessage fromScheme:self.appSchemeDict[ZLALIPAYURLNAME] callback:^(NSDictionary *resultDic){
         NSString *resultStatus = resultDic[@"resultStatus"];
         NSString *errStr = resultDic[@"memo"];
         ZLErrCode errorCode = ZLErrCodeSuccess;
         switch (resultStatus.integerValue) {
         case 9000:// 成功
         errorCode = ZLErrCodeSuccess;
         break;
         case 6001:// 取消
         errorCode = ZLErrCodeCancel;
         break;
         default:
         errorCode = ZLErrCodeFailure;
         break;
         }
         if ([ZLPayManager shareManager].callBack) {
         [ZLPayManager shareManager].callBack(errorCode,errStr);
         }
         }];*/
    }
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    // 判断支付类型
    if([resp isKindOfClass:[PayResp class]]){
        //支付回调
        ZLErrCode errorCode = ZLErrCodeSuccess;
        NSString *errStr = resp.errStr;
        switch (resp.errCode) {
            case 0:
                errorCode = ZLErrCodeSuccess;
                errStr = @"订单支付成功";
                break;
            case -1:
                errorCode = ZLErrCodeFailure;
                errStr = resp.errStr;
                break;
            case -2:
                errorCode = ZLErrCodeCancel;
                errStr = @"用户中途取消";
                break;
            default:
                errorCode = ZLErrCodeFailure;
                errStr = resp.errStr;
                break;
        }
        if (self.callBack) {
            self.callBack(errorCode,errStr);
        }
    }
}

#pragma mark -- Setter & Getter

- (NSMutableDictionary *)appSchemeDict{
    if (_appSchemeDict == nil) {
        _appSchemeDict = [NSMutableDictionary dictionary];
    }
    return _appSchemeDict;
}

@end
