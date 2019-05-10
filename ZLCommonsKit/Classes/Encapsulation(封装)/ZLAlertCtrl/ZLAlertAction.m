//
//  ZLAlertAction.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertAction.h"

@interface ZLAlertAction ()


@end

@implementation ZLAlertAction

+ (instancetype)zl_actionWithTitle:(NSString *)titleName withTitleSize:(UIFont *)titleFont withTitleColor:(UIColor *)btnTitleColor withBgColor:(UIColor *)bgColor handler:(void(^)(ZLAlertAction *action))handler {
    
    ZLAlertAction *action = [[self alloc] init];
    [action setTitleName:titleName];
    [action setBgColor:bgColor];
    [action setBtnTitleColor:btnTitleColor];
    [action setTitleFont:titleFont];
    return action;
}
- (instancetype)init {

    self =[super init];
    if (self) {
        
    }
    return self;
}
- (void)setTitleName:(NSString * _Nullable)titleName
{
    _titleName = titleName;
}
- (void)setBgColor:(UIColor * _Nullable)bgColor {
    _bgColor = bgColor;
}
//- (void)setBgImage:(UIImage * _Nullable)bgImage {
//
//    _bgImage = bgImage;
//}
- (void)setTitleFont:(UIFont *)titleFont {
    
    _titleFont = titleFont;
}
- (void)setBtnTitleColor:(UIColor *)btnTitleColor {
    
    _btnTitleColor = btnTitleColor;
}
@end
