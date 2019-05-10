//
//  ZLWechatResult.h
//  ZLWechat
//
//  Created by lianzhou on 16/3/8.
//  Copyright © 2016年 com.chuangkit. All rights reserved.
//
// 当前需求是微信第三方登陆获取到Code 然后交给服务器处理

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ZLWechatResultType) {
    ZLWechatResultTypeLogin = 0,
    ZLWechatResultypeShare,
};


/**
 *  微信登陆获
 */
@interface ZLWechatResult : NSObject


@property (nonatomic, assign) BOOL result;

@property (nonatomic, assign) ZLWechatResultType resultType;

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *refresh_token;

@property (nonatomic, copy) NSString *openid;

/**
 微信授权code
 */
@property (nonatomic, copy) NSString *code;

/**
 *  用户唯一标示
 */
@property (nonatomic, copy) NSString *unionid;


@end


typedef NS_ENUM(NSUInteger, ZLWechatShareScene) {
    ZLWechatShareSceneSession = 0,
    ZLWechatShareSceneTimeLine,
};


/**
 微信分享
 */
@interface ZLWechatShareObject : NSObject

/**
 *  默认分享到对话
 */
@property (nonatomic, assign) ZLWechatShareScene scene;
/**
 *  分享标题
 */
@property (nonatomic, copy) NSString *title;

/**
 * 分享描述
 */
@property (nonatomic, copy) NSString *shareContent;

/**
 *  分享图片地址列表
 */
@property (nonatomic, strong) NSData *thumbImageData;

/**
 *  分享URI
 */
@property (nonatomic, copy) NSString *shareUrl;

@end
