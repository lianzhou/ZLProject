//
//  ZLEncrypt.m
//  YBProject_JW
//
//  Created by ios on 2018/3/20.
//  Copyright © 2018年 zhoulian. All rights reserved.
//

#import "ZLEncrypt.h"
#import "ZLEncryptManager.h"

@implementation ZLEncrypt

//密匙 key
#define gkey            @"clx"

//加密
+ (NSString *)zlEncryUseDES:(NSString *)string{
    
    return [self TripleDES:string isEncrypt:YES];
    
}

// 解密
+ (NSString *)zlDecryUseDES:(NSString *)string{
    
    return [self TripleDES:string isEncrypt:NO];
    
}

+(NSString*)TripleDES:(NSString*)plainText isEncrypt:(BOOL)isEncrypt{
    
    NSData *resultData;
    NSString *resultString;
    if (isEncrypt) {
        NSData *encryptData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        resultData = [ZLEncryptManager excute3DESWithData:encryptData secureKey:[gkey dataUsingEncoding:NSUTF8StringEncoding] operation:kCCEncrypt];
        resultString = [ZLEncryptManager encodeBase64WithData:resultData];
    }else{
        resultData = [ZLEncryptManager excute3DESWithData:[ZLEncryptManager decodeBase64WithString:plainText] secureKey:[gkey dataUsingEncoding:NSUTF8StringEncoding] operation:kCCDecrypt];
        resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    return  resultString;
    
}

//url编码
+ (NSString *)UrlValueEncode:(NSString *)str{
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)str,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input{
    
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
