//
//  TZImagePickerHelper.h
//
//  Created by ios on 2017/11/8.
//  Copyright © 2017年 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"

@interface TZImagePickerHelper : NSObject<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
TZImagePickerControllerDelegate>

/**
 完成后返回图片路径数组
 */
//@property (nonatomic, copy) void(^finish)(NSArray *array);


/**
 完成后返回图片路径数组
 */
@property (nonatomic, copy) void(^finish)(NSInteger tag, NSArray *array);

/**
 完成后返回视屏信息
 */
@property (nonatomic, copy) void(^finishVoide)(double time,UIImage *coverImage, NSData *video);

/**
 打开手机图片库
 
 @param maxCount 最大张数
 @param isCrop 是否需形裁剪框
 @param isTakeVideo 视频
 @param superController UIViewController
 @param tag 标签
 */
- (void)showImagePickerControllerWithMaxCount:(NSInteger )maxCount
                                       isCrop:(BOOL)isCrop
                                  isTakeVideo:(BOOL)isTakeVideo
                       initWithViewController: (UIViewController *)superController
                                    selectTag:(NSInteger)tag ;

 

@end
