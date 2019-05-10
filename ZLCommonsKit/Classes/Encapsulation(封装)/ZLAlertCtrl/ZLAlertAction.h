//
//  ZLAlertAction.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLAlertAction : NSObject

+ (instancetype)zl_actionWithTitle:(NSString *)titleName withTitleSize:(UIFont *)titleFont withTitleColor:(UIColor *)btnTitleColor withBgColor:(UIColor *)bgColor handler:(void(^)(ZLAlertAction *action))handler;

@property (nullable, nonatomic, readonly)NSString *titleName;

@property (nonatomic, readonly)UIAlertActionStyle style;

@property (nonatomic, readonly)UIColor * _Nullable bgColor;

@property (nonatomic, readonly)UIFont * _Nullable titleFont;

@property (nonatomic, readonly)UIColor * _Nullable btnTitleColor;

@end
