//
//  ZLAlertView.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertView.h"

@implementation ZLAlertView

+ (instancetype)alertWithTitle:(nullable NSString *)title
                       content:(nullable NSArray<NSString *> *)contents
                     headImage:(nullable UIImage *)headImage
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable NSString *)otherButtonTitles
                         block:(nullable ZLAlertBaseBlock)alertBlock {

    return [self alertWithTitle:title subTitle:nil headImage:headImage content:contents cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles block:alertBlock];
}

+ (instancetype)alertWithTitle:(nullable NSString *)title
                      subTitle:(nullable NSString *)subTitle
                     headImage:(nullable UIImage *)headImage
                       content:(nullable NSArray<NSString *> *)contents
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable NSString *)otherButtonTitles
                         block:(nullable ZLAlertBaseBlock)alertBlock {
    UIViewController *ctrl = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    ZLAlertButtonView *alertController = [ZLAlertButtonView alertWithCtrl:ctrl title:title subTitle:subTitle headImage:headImage content:contents cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles block:alertBlock];
    alertController.shouldHideOnTouchOutside = YES;
    
    return nil;
}

+ (instancetype)alertWithTitle:(nullable NSString *)title
                       content:(nullable id)contents {
    UIViewController *ctrl = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    ZLAlertInfoView *alertController = nil;
    if (contents && [contents isKindOfClass:NSString.class]) {
        alertController = [ZLAlertInfoView alertWithCtrl:ctrl title:title content:contents image:[UIImage imageNamed:@"ZLAlertButtonView_Look"]];
    }
    else if (contents && [contents isKindOfClass:NSArray.class]) {
        alertController = [ZLAlertInfoView alertWithCtrl:ctrl title:title contents:contents image:[UIImage imageNamed:@"ZLAlertButtonView_Look"]];
    }
    else {
        alertController = [ZLAlertInfoView alertWithCtrl:ctrl title:title content:nil image:[UIImage imageNamed:@"ZLAlertButtonView_Look"]];
    }
    
    alertController.shouldHideOnTouchOutside = YES;
    
    return nil;
}



@end
