//
//  ZLWechatSDK.m
//  ZLWechat
//
//  Created by lianzhou on 16/3/8.
//  Copyright © 2016年 com.chuangkit. All rights reserved.
//

#import "ZLWechatSDK.h"
#import "WXApi.h"
#import "AFNetworking.h"

#define WX_ACCESS_TOKEN @"access_token"
#define WX_OPEN_ID @"openid"
#define WX_REFRESH_TOKEN @"refresh_token"
#define WX_UNION_ID @"unionid"
#define WX_BASE_URL @"https://api.weixin.qq.com/sns"
#define NICK_NAME @"nickname"
#define HEAD_IMG_URL @"headimgurl"
#define THIRD_LOGIN @"thirdLogin"

@interface  ZLWechatSDK ()<WXApiDelegate>
@property (nonatomic, copy)  ZLWechatResultBlock loginBlock;
@property (nonatomic, copy)  ZLWechatResultBlock shareBlock;

@property (nonatomic) BOOL onyCode;

@end

@implementation  ZLWechatSDK

//分享
// ZLWechatShareObject *shareObj = [[ ZLWechatShareObject alloc] init];
//shareObj.title = @"我只是个测试";
//shareObj.shareContent = @"测试内容哈~~~";
//shareObj.shareUrl = @"http://www.chuangkit.com";
//shareObj.thumbImageData = UIImagePNGRepresentation([UIImage imageNamed:@"icon_60"]);
//shareObj.scene =  ZLWechatShareSceneTimeLine;
//[[ZLWechatSDK shareSDK] wechatshare:shareObj  result:^( ZLWechatResult *result) {
//    
//}];


+ ( ZLWechatSDK *)shareSDK
{
    static dispatch_once_t onceToken;
    static  ZLWechatSDK *lemon ;
    dispatch_once(&onceToken, ^{
        if (lemon == nil) {
            lemon = [[ ZLWechatSDK alloc] init];
        }
    });
    return lemon;
}

+ (void) registerApp{
    [WXApi registerApp:WX_APP_ID];
}

+ (BOOL)handleOpenURL:(NSURL *)url withOptions:(NSDictionary *)options{
    return [WXApi handleOpenURL:url delegate:[ ZLWechatSDK shareSDK]];
}

static NSString *extracted() {
    return WX_ACCESS_TOKEN;
}

- (void)wechatloginCode:( ZLWechatResultBlock) loginBlock{
    self.onyCode=YES;
    self.loginBlock = loginBlock;
    [self wechatLogin];
}

- (void)wechatlogin:( ZLWechatResultBlock) loginBlock{
    self.loginBlock = loginBlock;
    //微信登录
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:extracted()];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
    if (accessToken && openID) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN];
        NSString *refreshUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",  WX_APP_ID, refreshToken];
        [manager GET:refreshUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求reAccess的response = %@", responseObject);
            NSDictionary *refreshDict = [NSDictionary dictionaryWithDictionary:responseObject];
            NSString *reAccessToken = [refreshDict objectForKey:@"access_token"];
            // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
            if (reAccessToken) {
                // 更新access_token、refresh_token、open_id
                [[NSUserDefaults standardUserDefaults] setObject:reAccessToken forKey:WX_ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:WX_OPEN_ID] forKey:WX_OPEN_ID];
                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:WX_REFRESH_TOKEN] forKey:WX_REFRESH_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //                    // 当存在reAccessToken不为空时直接执行AppDelegate中的wechatLoginByRequestForUserInfo方法
                [self  wechatLoginByRequestForUserInfo];
            }
            else {
                [self wechatLogin];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"用refresh_token来更新accessToken时出错 = %@", error);
        }];
    }
    else {
        [self wechatLogin];
    }
}

/**
 微信授权
 */
-(void)wechatLogin{
    //构造SendAuthReq结构体
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"APP";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

/**
 获取access_token
 
 @param code code
 */
-(void)respAccessToken:(NSString *)code {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *accessUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_APP_ID, WX_APP_SECERT, code];
    [manager GET:accessUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求access的response = %@", responseObject);
        NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:responseObject];
        NSString *accessToken = [accessDict objectForKey:WX_ACCESS_TOKEN];
        NSString *openID = [accessDict objectForKey:WX_OPEN_ID];
        NSString *refreshToken = [accessDict objectForKey:WX_REFRESH_TOKEN];
        NSString *unionid = [accessDict objectForKey:WX_UNION_ID];
        // 本地持久化，以便access_token的使用、刷新或者持续
        if (accessToken && ![accessToken isEqualToString:@""]) {
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] setObject:openID forKey:WX_OPEN_ID];
            [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
            [[NSUserDefaults standardUserDefaults] setObject:unionid forKey:WX_UNION_ID];
            [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
        }
        [self wechatLoginByRequestForUserInfo];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取access_token时出错 = %@", error);
        ZLWechatResult *resultObj = [[ ZLWechatResult alloc] init];
        resultObj.resultType =  ZLWechatResultTypeLogin;
    }];
}


/**
 获取用户个人信息（UnionID机制）
 */
- (void)wechatLoginByRequestForUserInfo {
    ZLWechatResult *resultObj = [[ ZLWechatResult alloc] init];
    resultObj.resultType =  ZLWechatResultTypeLogin;
    resultObj.result = NO;
    self.loginBlock(resultObj);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    NSString *userUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", accessToken, openID];
    // 请求用户数据
    [manager GET:userUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求用户信息的response = %@", responseObject);
        NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:responseObject];
        NSString *nickname = [accessDict objectForKey:NICK_NAME];
        NSString *headimgurl = [accessDict objectForKey:HEAD_IMG_URL];
        [[NSUserDefaults standardUserDefaults] setObject:nickname forKey:NICK_NAME];
        [[NSUserDefaults standardUserDefaults] setObject:headimgurl forKey:HEAD_IMG_URL];
        [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
        
        //发起登陆请求,用于获取用于信息后
        [[NSNotificationCenter defaultCenter] postNotificationName:THIRD_LOGIN object:nil];
        resultObj.result = YES;
        resultObj.access_token=accessToken;
        resultObj.refresh_token=[[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN];
        resultObj.openid=openID;
        resultObj.unionid= [accessDict objectForKey:WX_UNION_ID];
        self.loginBlock(resultObj);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取用户信息时出错 = %@", error);
        resultObj.result = NO;
        self.loginBlock(resultObj);
    }];
}

#pragma mark share
- (void)wechatshare:(ZLWechatShareObject *)shareObject  result:( ZLWechatResultBlock) shareBlock{
    self.shareBlock = shareBlock;
    //分享到微信
    WXMediaMessage *mediaMessage = [WXMediaMessage message];
    mediaMessage.title = shareObject.title;
    mediaMessage.description = shareObject.shareContent;
    mediaMessage.thumbData = shareObject.thumbImageData;
    
    WXWebpageObject *wObject = [WXWebpageObject object];
    wObject.webpageUrl = shareObject.shareUrl;
    mediaMessage.mediaObject = wObject;
    
    SendMessageToWXReq *testReq = [[SendMessageToWXReq alloc] init];
    testReq.message = mediaMessage;
    testReq.bText = NO;
    testReq.scene = shareObject.scene;
    [WXApi sendReq:testReq];
}

#pragma mark wechatDelegate
- (void)onReq:(BaseReq *)req{
    
}

#pragma mark - WXDelegate 微信分享／登录/支付方法回调
- (void)onResp:(BaseResp *)resp {
    // 1.分享后回调类
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *mResponse = (SendMessageToWXResp *)resp;
        ZLWechatResult *resultObj = [[ ZLWechatResult alloc] init];
        resultObj.resultType =  ZLWechatResultypeShare;
        if (mResponse.errCode == 0) {
            //分享成功
            resultObj.result = YES;
        }
        else{
            resultObj.result = NO;
        }
        self.shareBlock(resultObj);
    }
    
    // 2.微信登录向微信请求授权回调类
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *sResp = (SendAuthResp *)resp;
        
        if(self.onyCode){
            ZLWechatResult *resultObj = [[ ZLWechatResult alloc] init];
            resultObj.resultType =  ZLWechatResultTypeLogin;
            resultObj.code=ZLIFISNULL(sResp.code);
            resultObj.result = [ZLIFISNULL(sResp.code) length]==0 ? NO : YES ;
            self.loginBlock(resultObj);
        }
        else{
            [self respAccessToken:ZLIFISNULL(sResp.code)];
        }
    }
    // 3.支付后回调类
    //    if ([resp isKindOfClass:[PayResp class]]) {
    //        //对支付结果进行回调
    //        //PayResp *resp3 = (PayResp *)resp;
    //    }
}

@end
