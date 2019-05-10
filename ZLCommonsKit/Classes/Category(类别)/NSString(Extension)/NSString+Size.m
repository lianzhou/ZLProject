//
//  NSString+Size.m
//  用于计算NSString在界面中所占宽度和高度。
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

#pragma mark -计算字符串大小

+ (CGFloat )getTextWidth:(NSString *)text font:(UIFont *)font{
    return [NSString getTextSize:text font:font maxWidth:0 maxHeight:0].width;
}

+ (CGSize)getTextSize:(NSString *)text font:(UIFont *)font{
    return [NSString getTextSize:text font:font maxWidth:0 maxHeight:0];
}

+ (CGSize)getTextSize:(NSString *)text font:(UIFont *)font maxWidth:(float)maxWidth maxHeight:(float)maxHeight{
    CGSize maxSize = CGSizeMake(maxWidth == 0 ? MAXFLOAT : maxWidth,maxHeight == 0 ? MAXFLOAT : maxHeight);
    CGSize singleLineSize = CGSizeZero;
    //如果当前版本高于或等于7.0，则NSString有(boundingRectWithSize:options:attributes:context:)方法，直接使用此方法计算文字尺寸
    if ([@"" respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        NSDictionary *attributes = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
        CGRect singleLineRect = [text boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
        singleLineSize = singleLineRect.size;
    }else{
        //如果没有则说明版本低于7.0，则使用(sizeWithFont:constrainedToSize:lineBreakMode:)方法计算文字尺寸
        if ([@"" respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)]) {
            singleLineSize =[text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        }
    }
    singleLineSize.width+=1;
    singleLineSize.height+=1;
    return singleLineSize;
}

- (CGSize)getTextSizeWithFont:(UIFont *)font{
    return [NSString getTextSize:self font:font maxWidth:0 maxHeight:0];
}

- (CGSize)getTextSizeWithFont:(UIFont *)font andMaxWidth:(float)maxWidth andMaxHeight:(float)maxHeight{
    return [NSString getTextSize:self font:font maxWidth:maxWidth maxHeight:maxHeight];
}

@end
