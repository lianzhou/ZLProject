//
//  ZLNetworkRsponse.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLNetworkHelper.h"
#import "HeaderModel.h"
@implementation ZLNetworkRsponse

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    //  return @{@"CifName":@"cifName",@"IdNo":@"idNo"};
    // 映射可以设定多个映射字段
    return @{@"msg":@[@"message",@"msg"]};
}

@end

@implementation ZLNetworkManager

SHARED_INSTANCE_DEFINE(ZLNetworkManager);

@end


@implementation ZLNetworkHelper

/**POST*/
+(void)POST:(NSString *)interface
 parameters:(NSDictionary*)parameters
 completion:(requestBlock)completion{
    
    return[self requsetWithHTTPMethod:POST
                            interface:interface
                           parameters:parameters
                           completion:completion];
}


/** GET */
+(void)GET:(NSString *)interface
parameters:(NSDictionary*)parameters
completion:(requestBlock)completion{
    
    return[self requsetWithHTTPMethod:GET
                            interface:interface
                           parameters:parameters
                           completion:completion];
}


+(void)requsetWithHTTPMethod: (HttpMethod) method
                  interface :(NSString *)interface
                  parameters:(NSDictionary*)parameters
                  completion:(requestBlock)completion{ 
    
    
    if(!kIsNetwork){
        
        ZLNetworkRsponse *rsp=[[ZLNetworkRsponse alloc]init];
        rsp.msg=@"网络链接失败,请检查网络。";
        rsp.status=StatusNetwork;
        rsp.success=NO;
        completion(rsp);
    }
    else
    {
        NSString *userId =  zlUser.userid;
        if(userId == nil) userId=@"";
        
//        HeaderModel *head=HeaderModel.new;
//        NSLog(@"手机型号 %@",  head.mobile_model);
//        NSLog(@"手机版本 %@",  head.mobile_version);
 
        
        /**
         *  设置请求头
         */
                NSMutableDictionary *extra=[[NSMutableDictionary alloc]init];
                [extra setValue:ZLAppVersion forKey:@"version"];
                [extra setValue:@"1201" forKey:@"client"];
                [extra setValue:@"3300" forKey:@"platform"];
        
                if (extra != nil) {
                    for (NSString *httpHeaderField in extra.allKeys) {
                        NSString *value = extra[httpHeaderField];
                        [PPNetworkHelper setValue:value forHTTPHeaderField:httpHeaderField];
                    }
                }
        
        
        NSString *URL=[NSString stringWithFormat:@"%@%@",[ZLNetworkManager shareInstance].host,interface];
        
        if(method ==POST){
            [PPNetworkHelper POST:URL parameters:parameters success:^(id responseObject) {
                NSLog(@"POST 返回结果%@",responseObject);
                if (ValidDict(responseObject)) {
                     
                    ZLNetworkRsponse *rsp=[ZLNetworkRsponse modelWithJSON:responseObject];
                    rsp.status=StatusSuccess;
                    rsp.success=YES;
                    completion(rsp);
                }
                
            } failure:^(NSError *error) {
                
                ZLNetworkRsponse *rsp=[[ZLNetworkRsponse alloc]init];
                rsp.msg=[self requestFailed: error path:URL ];
                if(error.code ==NSURLErrorNotConnectedToInternet || error.code ==NSURLErrorTimedOut){
                    rsp.status=StatusNetwork;
                }
                else{
                    rsp.status=StatusError;
                }
                rsp.success=NO;
                completion(rsp);
            }];
        }
        else{
            
            [PPNetworkHelper GET:URL parameters:parameters success:^(id responseObject) {
                NSLog(@"GET 返回结果%@",responseObject);
                if (ValidDict(responseObject)) {
                    
                    ZLNetworkRsponse *rsp=[ZLNetworkRsponse modelWithJSON:responseObject];
                    rsp.msg=responseObject[@"desc"];
                    rsp.status=StatusSuccess;
                    rsp.success=YES;
                    completion(rsp);
                }
                
            } failure:^(NSError *error) {
                
                ZLNetworkRsponse *rsp=[[ZLNetworkRsponse alloc]init];
                rsp.msg=[self requestFailed: error path:URL ];
                if(error.code ==NSURLErrorNotConnectedToInternet || error.code ==NSURLErrorTimedOut){
                    rsp.status=StatusNetwork;
                }
                else{
                    rsp.status=StatusError;
                }
                rsp.success=NO;
                completion(rsp);
            }];
        }
    }
}

//单/多图片上传
+(void)uploadImages:(NSString *)interface
         parameters:(NSDictionary*)parameters
             images:(NSArray<UIImage *> *) images
         completion:(requestBlock)completion{
    
    if(!kIsNetwork){
        
        ZLNetworkRsponse *rsp=[[ZLNetworkRsponse alloc]init];
        rsp.msg=@"网络链接失败,请检查网络。";
        rsp.status=StatusNetwork;
        rsp.success=NO;
        completion(rsp);
        
    }
    else
    {
        NSString *userId =  zlUser.userid;
        if(userId == nil) userId=@"";
        
        /**
         *  设置请求头
         */
        //        NSMutableDictionary *extra=[[NSMutableDictionary alloc]init];
        //        [extra setValue:ZLAppVersion forKey:@"version"];
        //        [extra setValue:@"1201" forKey:@"client"];
        //        [extra setValue:@"3300" forKey:@"platform"];
        
        //        if (extra != nil) {
        //            for (NSString *httpHeaderField in extra.allKeys) {
        //                NSString *value = extra[httpHeaderField];
        //                [PPNetworkHelper setValue:value forHTTPHeaderField:httpHeaderField];
        //            }
        //        }
        
        NSString *url=[NSString stringWithFormat:@"%@%@",[ZLNetworkManager shareInstance].host,interface];
        
        [PPNetworkHelper uploadImagesWithURL:url parameters:parameters name:@"" images:images fileNames:nil imageScale:1 imageType:@"png" progress:nil success:^(id responseObject) {
            
            NSLog(@"图片上传 返回结果%@",responseObject);
            if (ValidDict(responseObject)) {
                
                ZLNetworkRsponse *rsp=[ZLNetworkRsponse modelWithJSON:responseObject];
                rsp.status=StatusSuccess;
                rsp.success=YES;
                completion(rsp);
            }
        } failure:^(NSError *error) {
            
            //上传失败
            ZLNetworkRsponse *rsp=[[ZLNetworkRsponse alloc]init];
            rsp.msg=[self requestFailed: error path:url ];
            if(error.code ==NSURLErrorNotConnectedToInternet || error.code ==NSURLErrorTimedOut){
                rsp.status=StatusNetwork;
            }
            else{
                rsp.status=StatusError;
            }
            rsp.success=NO;
            completion(rsp);
        }];
        
    }
} 


+(void)uploadFile:(NSString *)interface
       parameters:(NSDictionary*)parameters
             name:(NSString *) name
       completion:(requestBlock)completion{
    
    if(!kIsNetwork){
        
        ZLNetworkRsponse *rsp=[[ZLNetworkRsponse alloc]init];
        rsp.msg=@"网络链接失败,请检查网络。";
        rsp.status=StatusNetwork;
        rsp.success=NO;
        completion(rsp);
        
    }
    else
    {
        NSString *userId =  zlUser.userid;
        if(userId == nil) userId=@"";
        
        
        NSString *url=[NSString stringWithFormat:@"%@%@",[ZLNetworkManager shareInstance].host,interface];
        
        //文件上传
        [PPNetworkHelper uploadFileWithURL:url
                                parameters:parameters
                                      name:name
                                  filePath:nil
                                  progress:^(NSProgress *progress) {
                                      //上传进度
                                      //NSLog(@"上传进度:%.2f%%",100.0 * progress.completedUnitCount/progress.totalUnitCount);
                                  } success:^(id responseObject) {
                                      //上传成功
                                      NSLog(@"文件上传 返回结果%@",responseObject);
                                      if (ValidDict(responseObject)) {
                                          
                                          ZLNetworkRsponse *rsp=[ZLNetworkRsponse modelWithJSON:responseObject];
                                          rsp.status=StatusSuccess;
                                          rsp.success=YES;
                                          completion(rsp);
                                      }
                                  } failure:^(NSError *error) {
                                      //上传失败
                                      ZLNetworkRsponse *rsp=[[ZLNetworkRsponse alloc]init];
                                      rsp.msg=[self requestFailed: error path:url ];
                                      if(error.code ==NSURLErrorNotConnectedToInternet || error.code ==NSURLErrorTimedOut){
                                          rsp.status=StatusNetwork;
                                      }
                                      else{
                                          rsp.status=StatusError;
                                      }
                                      rsp.success=NO;
                                      completion(rsp);
                                  }];
        
        
    }
    
} 



/**
 *  请求失败回调方法
 *  @param error 错误对象
 */
+ (NSString *)requestFailed:(NSError *)error   path:(NSString*)path {
    if(error){
        NSLog(@"\n----接口----%@\n CODE----%zd %@",path,error.code, [error localizedDescription] );
        switch (error.code) {
            case NSURLErrorNotConnectedToInternet ://-1009 断网
                return  @"网络链接失败,请检查网络。";
                break;
            case NSURLErrorTimedOut ://-1001 请求超时
                return @"访问服务器超时,请检查网络。";
                break;
            case 3840 :
                return @"服务器报错了,请求或返回不是纯Json格式。";
                break;
            case NSURLErrorBadServerResponse ://-1011 404错误 500
                return @"服务器异常";
                break;
            case NSURLErrorUnsupportedURL ://-1002 不支持的url
                return @"服务器报错了,不支持的url。";
                break;
            default:
                return @"网络链接失败。";
                break;
        }
    }
    else{
        return @"数据解析失败。";
    }
}


@end
