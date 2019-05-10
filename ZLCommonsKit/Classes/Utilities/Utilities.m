//
//  Utilities.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

#pragma mark  手机号格式分隔符添加
+(NSString*) stringFormatMobile:(NSString* )inputString{
    if(inputString.length==0)
        return @"";
    
    int index = 3;
    NSString *_res = @"";
    while([inputString length] > 0) {
        if ([inputString length] <=index) {
            _res=[NSString stringWithFormat:@"%@-%@",_res,inputString];
            break;
        }
        NSString *subStr = [inputString substringToIndex:index];
        inputString = [inputString substringFromIndex:index];
        index=4;
        _res=[NSString stringWithFormat:@"%@-%@",_res,subStr];
    }
    return  [_res substringWithRange:NSMakeRange(1, [_res length] - 1)];
    
    //去掉两头空格
    //   return [_res stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 判断是否是BOOl
 
 @param key @"true" "false" 1 /0
 @return true / false
 */
+ (BOOL)securityBOOLWithKey:(id)key {
    if ([key isKindOfClass:[NSNumber class]]) {
        return [key boolValue];
    } else if ([key isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)key;
        if ([str isEqualToString:@"true"]) {
            return true;
        }
        else  if ([str isEqualToString:@"1"]) {
            return true;
        }
    }
    return false;
}

/**
 UIButton 文字左移 图片右移
 
 @param btn <#btn description#>
 */
+(void) setImageRightEdgeInsets:(UIButton*)btn{
    // 还可增设间距
    CGFloat spacing = 3.0;
    
    // 图片右移
    CGSize imageSize = btn.imageView.frame.size;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width * 2 - spacing, 0.0, 0.0);
    
    // 文字左移
    CGSize titleSize = btn.titleLabel.frame.size;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - titleSize.width * 2 - spacing);
    
    CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
    btn.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
}

//用户密码6-16位数字和字母组合
+ (BOOL)stringIsValidatePassword:(NSString *) string{
    
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

+ (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

#pragma mark判断是否是 emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    return returnValue;
}


/**
 NSString 转化成 JSON 字符串
 @param aString <#aString description#>
 @return <#return value description#>
 */
+(NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

#pragma mark  添加左边返回按钮
+(void) createLeftBarButton:(UIViewController *)view  clichEvent:(SEL)clichEvent{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_nav_btn_back.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn addTarget:view action:clichEvent forControlEvents:UIControlEventTouchUpInside];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    view.navigationItem.leftBarButtonItem = item;
}


-(UIButton*)NextButton:(CGRect)setframe
                 title: (NSString *)title {
    
    UIImageView *imvDisabled=[[UIImageView alloc]init];
    imvDisabled.frame= setframe;
    imvDisabled.image= [UIImage imageWithColor:UIColorFromRGB(0xE8E8E8)];
    
    UIImageView *imv=[[UIImageView alloc]init];
    imv.frame= setframe;
    imv.image= [UIImage getGradientImageFromColors:@[UIColorFromRGB(0xFF62A5),UIColorFromRGB(0xFF8960)] gradientType:GradientTypeLeftToRight imgSize:setframe.size];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundImage:imv.image forState:0];
    [btn setBackgroundImage:imvDisabled.image forState:UIControlStateDisabled];
    btn.titleLabel.font=KDEFAULTFONT(17);
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:KWhiteColor forState:0];
    
    [btn setTitleColor:KGrayColor forState:UIControlStateDisabled];
    //    btn.layer.cornerRadius=2.0f;
    //    btn.layer.masksToBounds=YES;
    return  btn;
}


@end
