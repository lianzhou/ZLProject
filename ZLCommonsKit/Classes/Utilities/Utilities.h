//
//  Utilities.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject

/**
 判断是否是BOOl
 
 @param key @"true" "false" 1 /0
 @return true / false
 */
+ (BOOL)securityBOOLWithKey:(id)key ;

/**
 UIButton 文字左移 图片右移
 
 @param btn btn description
 */
+(void) setImageRightEdgeInsets:(UIButton*)btn; 

+ (NSString *)disable_emoji:(NSString *)text;

#pragma mark判断是否是 emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string; 

#pragma mark  手机号格式分隔符添加
+(NSString*) stringFormatMobile:(NSString* )inputString;

//用户密码6-16位数字和字母组合
+ (BOOL)stringIsValidatePassword:(NSString *) string;

#pragma mark  添加左边返回按钮
+(void) createLeftBarButton:(UIViewController *)view  clichEvent:(SEL)clichEvent;


/**
 下一步
 @param setframe CGRect
 @param title 名称
 @return 渐变色按钮
 */
- (UIButton*)NextButton:(CGRect)setframe
                  title: (NSString *)title;

@end

NS_ASSUME_NONNULL_END
