//
//  ZLUIExtend.h
//  Tines
//
//  Created by Schaffer on 2018/11/9.
//  Copyright © 2018年 RD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLUIExtend : NSObject

 
/**
 主UILabel
 @param font 字体
 @param color UIColor
 @return UILabel
 */
+(UILabel*)LabelExtend:(UIFont *)font color:(UIColor *)color;


+(UITextField*)TextExtend:(UIFont *)font color:(UIColor *)color;

/**
 提交Button

 @param title 文字
 @param font 字体
 @param backgroundColor 背景颜色
 @param titleColor 字体颜色
 @return UIButton
 */
+(UIButton*)NextButton:(NSString *)title  font:(UIFont *) font
       backgroundColor:(UIColor *)backgroundColor
            titleColor:(UIColor *)titleColor;


@end
