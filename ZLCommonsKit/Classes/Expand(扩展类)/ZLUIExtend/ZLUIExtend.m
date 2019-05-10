//
//  ZLUIExtend.m
//  Tines
//
//  Created by Schaffer on 2018/11/9.
//  Copyright © 2018年 RD. All rights reserved.
//

#import "ZLUIExtend.h"


@implementation ZLUIExtend


/**
 主UILabel
 
 @param font 字体
 @param color UIColor
 @return UILabel
 */
+(UILabel*)LabelExtend:(UIFont *) font color:(UIColor *)color{
    
    UILabel *Label=[[UILabel alloc]initWithFrame:CGRectZero] ;
    Label.font=font ;
    Label.textColor=color;
    return  Label;
}


+(UITextField*)TextExtend:(UIFont *)font color:(UIColor *)color{
    
    UITextField *txtfield=[[UITextField alloc]initWithFrame:CGRectZero] ;
    txtfield.font=font ;
    txtfield.textColor=color;
    txtfield.borderStyle = UITextBorderStyleNone;
    
    txtfield.clearButtonMode=UITextFieldViewModeWhileEditing;
  
    txtfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtfield.frame.size.width)];
    // 设置UITextField的左边距
   
    txtfield.leftViewMode =UITextFieldViewModeAlways;  //左边距为10pix
 
    txtfield.keyboardType=UIKeyboardTypeDefault;
    
    return  txtfield;
}


+(UIButton*)NextButton:(NSString *)title font:(UIFont *) font
       backgroundColor:(UIColor *)backgroundColor
            titleColor:(UIColor *)titleColor{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = backgroundColor;
    btn.titleLabel.font=font;
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.layer.cornerRadius=2.0f;
    btn.layer.masksToBounds=YES;
    
    return  btn;
    
}

@end
