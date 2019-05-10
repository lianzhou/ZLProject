//
//  AdPageView.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 启动广告页面
 */

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

typedef void(^TapBlock)();

@interface AdPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTapBlock:(TapBlock)tapBlock;

/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

@end

NS_ASSUME_NONNULL_END
