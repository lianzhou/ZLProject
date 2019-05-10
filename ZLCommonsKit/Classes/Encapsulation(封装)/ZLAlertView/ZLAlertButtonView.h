//
//  ZLAlertButtonView.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertBaseComponent.h"

typedef void(^ZLAlertBaseBlock)(NSInteger buttonIndex);

@interface ZLAlertButtonView : ZLAlertBaseComponent

+ (instancetype _Nullable )alertWithCtrl:(UIViewController *)viewController
                        title:(nullable NSString *)title
                     subTitle:(nullable NSString *)subTitle
                    headImage:(nullable UIImage *)headImage
                      content:(nullable NSArray<NSString *> *)contents
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
            otherButtonTitles:(nullable NSString *)otherButtonTitles
                        block:(nullable ZLAlertBaseBlock)alertBlock;

@end
