//
//  UIImage+Extend.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//渐变色
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
};

@interface UIImage (Extend)

/**
 UIImage to base64
 
 @param image UIImage
 @return base64String
 */
+(NSString *)imagebase64String:(UIImage*)image;

/**
 图片自适应UIImageView
 @param image image description
 @param newSize <#newSize description#>
 @return <#return value description#>
 */
+ (UIImage*)scaleImageSimple:(UIImage*)image
                scaledToSize:(CGSize)newSize;

/**
 按比例缩放,size 是你要把图显示到 多大区域
 @param sourceImage <#sourceImage description#>
 @param size CGSizeMake(200, 140)
 @return <#return value description#>
 */
+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage
                             targetSize:(CGSize)size;


/**
 指定宽度按比例缩放
 
 @param sourceImage <#sourceImage description#>
 @param defineWidth <#defineWidth description#>
 @return <#return value description#>
 */
+(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage
                            targetWidth:(CGFloat)defineWidth;

/**
  判断照片大小再压缩
 
 @param image <#image description#>
 @return <#return value description#>
 */
+(UIImage *)scaleImage :(UIImage *)image;


/**
 *  截取当前View作为一张背景图返回, capture:捕获,刻画
 */
+ (UIImage *)imageWithCaptureView:(UIView *)view;

/**
 *  拉伸图片:自定义比例
 */
+(UIImage *)resizeWithImageName:(NSString *)name
                        leftCap:(CGFloat)leftCap
                         topCap:(CGFloat)topCap;

/**
 *  拉伸图片
 */
+(UIImage *)resizeWithImageName:(NSString *)name;

/**
 *  获取启动图片
 */
+(UIImage *)launchImage;

/**
 获取AppIcon 
 @return <#return value description#>
 */
+(UIImage *)iconImage;

/**
 渐变色 
 @param colors colors description
 @param gradientType GradientType
 @param imgSize imgSize description
 @return return value description
 */
+ (UIImage *)getGradientImageFromColors:(NSArray*)colors
                           gradientType:(GradientType)gradientType
                                imgSize:(CGSize)imgSize;
/**
 生成二维码图片
 @param uid 用户id
 @return 二维码图片
 */
+ (UIImage *)createQRCodeImage:(NSString *)uid;

+ (UIImage *)qrImageForString:(NSString *)string
                    imageSize:(CGFloat)Imagesize
                logoImageSize:(CGFloat)waterImagesize;

/**
 生成条形码图片
 @param content 条形码内容
 @param size 条形码图片大小
 @param red 红色比例
 @param green 绿色比例
 @param blue 蓝色比例
 @return 条形码图片
 */
+ (UIImage *)barcodeImageWithContent:(NSString *)content
                       codeImageSize:(CGSize)size red:(CGFloat)red
                               green:(CGFloat)green
                                blue:(NSInteger)blue;
/**
 生成二维码图片
 @param content 二维码内容
 @param size 二维码图片阿晓
 @param logo 二维码LOGO图片
 @param logoFrame 二维码LOGO图片大小
 @param red 红色比例
 @param green 绿色比例
 @param blue 蓝色比例
 @return 二维码图片
 */
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(NSInteger)blue;

/**
 来实现一道虚线的绘制
 */
+(UIImage *)imageWithLineWithImageView:(UIImageView *)imageView
                             lineColor:(UIColor *)lineColor;

@end

NS_ASSUME_NONNULL_END
