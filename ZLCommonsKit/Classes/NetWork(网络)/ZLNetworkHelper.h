//
//  ZLNetworkRsponse.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPNetworkHelper.h"

NS_ASSUME_NONNULL_BEGIN 

typedef NS_ENUM(NSUInteger, RspStatus) {
    ///系统错误
    StatusError = -1,
    ///网络问题
    StatusNetwork = -2,
    ///成功
    StatusSuccess = 0
};

typedef NS_ENUM(NSInteger,HttpMethod) {
    GET,
    POST,
};


@interface ZLNetworkRsponse : NSObject

///状态
@property(nonatomic, assign) RspStatus status;

@property(nonatomic, assign)  BOOL success;

/**接口调用状态，空:正常，其他值：调用出错，返回码见响应返回码 */
@property(nonatomic, strong) NSString *code;

/** 结果说明，如果接口调用出错，那么返回错误描述，成功返回 ok */
@property(nonatomic, strong) NSString *msg;

/** 接口返回结果，各个接口自定义 */
@property(nonatomic, strong) id data;

@end


#pragma mark - 必须设置的参数

@interface ZLNetworkManager  : NSObject

//单例
SHARED_INSTANCE_DECLARE(ZLNetworkManager)


/** 所有网络请求的统一地址，网络请求前必须设置值 */
@property(nonatomic, strong)   NSString *host;

/** 上传图片地址 */
@property(nonatomic, strong)  NSString *imageHost;

@end

/**请求返回 */
typedef void (^requestBlock)(ZLNetworkRsponse *rsp);

@interface ZLNetworkHelper : NSObject

/**
 POST

 @param interface 接口
 @param parameters 参数
 @param completion 返回
 */
+(void)POST:(NSString *)interface parameters:(NSDictionary*)parameters
        completion:(requestBlock)completion; 


/**
 GET
 
 @param interface 接口
 @param parameters 参数
 @param completion 返回
 */
+(void)GET:(NSString *)interface parameters:(NSDictionary*)parameters
 completion:(requestBlock)completion;

/**
 上传图片

 @param interface 图片接口
 @param parameters 参数
 @param images UIImage *数组
 @param completion 返回
 */
+(void)uploadImages:(NSString *)interface parameters:(NSDictionary*)parameters images:(NSArray<UIImage *> *) images completion:(requestBlock)completion;
@end
NS_ASSUME_NONNULL_END
