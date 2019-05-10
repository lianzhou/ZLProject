//
//  NSString+Size.h
//  Project_OC
//
//  用于计算NSString在界面中所占宽度和高度。 
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

+ (CGFloat)getTextWidth:(NSString *)text font:(UIFont *)font;
/**
 *  获取一段文字在屏幕中显示的宽和高
 *
 *  @param text 文字内容
 *  @param font 文字字体
 *
 *  @return 文字显示尺寸
 */
+(CGSize)getTextSize:(NSString *)text font:(UIFont *)font;

/**
 *  获取一段文字在屏幕中显示的宽和高
 *
 *  @param text 文字内容
 *  @param font 文字字体
 *  @param maxWidth 文字最大宽度
 *  @param maxHeight 文字最大高度
 *
 *  @return 文字显示尺寸
 */
+ (CGSize)getTextSize:(NSString *)text font:(UIFont *)font maxWidth:(float)maxWidth maxHeight:(float)maxHeight;


/**
 获取一段文字在屏幕中显示的宽和高

 @param font 文字字体
 @return 文字显示尺寸
 */
- (CGSize)getTextSizeWithFont:(UIFont *)font;

/**
 *  获取一段文字在屏幕中显示的宽和高
 *
 *  @param font 文字字体
 *  @param maxWidth 文字最大宽度
 *  @param maxHeight 文字最大高度
 *
 *  @return 文字显示尺寸
 */
- (CGSize)getTextSizeWithFont:(UIFont *)font andMaxWidth:(float)maxWidth andMaxHeight:(float)maxHeight;

@end
