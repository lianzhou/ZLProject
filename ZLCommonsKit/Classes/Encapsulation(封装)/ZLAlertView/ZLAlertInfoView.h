//
//  ZLAlertInfoView.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertBaseComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLAlertInfoView : ZLAlertBaseComponent

@property (nonatomic) NSTextAlignment textAlignment;    // default is NSLeftTextAlignment

+ (instancetype)alertWithCtrl:(nullable UIViewController *)viewController
                        title:(nullable NSString *)title
                     contents:(nullable NSArray<NSString *> *)contents
                        image:(nullable UIImage *)image;

+ (instancetype)alertWithCtrl:(nullable UIViewController *)viewController
                        title:(nullable NSString *)title
                      content:(nullable NSString *)content
                        image:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
