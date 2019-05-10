//
//  ZLEncrypt.h
//  YBProject_JW
//
//  Created by ios on 2018/3/20.
//  Copyright © 2018年 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLEncrypt : NSObject
//加密
+ (NSString *)zlEncryUseDES:(NSString *)string;
//解密
+ (NSString *)zlDecryUseDES:(NSString *)string;
//url编码
+ (NSString *)UrlValueEncode:(NSString *)str;
//url解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

@end
