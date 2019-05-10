//
//  ZLAlertViewController.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLBasePopViewController.h"
#import "ZLAlertAction.h"
#import "ZLCustomAlertView.h"
typedef void(^ZLAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface ZLAlertViewController : ZLBasePopViewController

@property (nullable, nonatomic, copy) NSString *titleName;

@property (nullable, nonatomic, copy) NSString *messageName;

@property (nonatomic, copy) ZLAlertViewCallBackBlock _Nullable alertCallBackBlock;

@property (nonatomic, readonly) NSArray<ZLAlertAction *> * _Nullable actionsArray;

@property (nonatomic, assign) BOOL isShow;

//图片名称
@property (nullable,nonatomic, copy) NSString *iconImageName;


+ (instancetype _Nullable )zl_alertControllerWithTitle:(nullable NSString *)title withMessage:(nullable NSString *)message withIconImage:(nullable NSString *)iconImageName withCallBackBlock:(ZLAlertViewCallBackBlock _Nullable )callBackBlock;

//自定义View
+ (instancetype _Nullable )zl_alertControllerWithTitle:(nullable NSString *)title withMessage:(nullable NSString *)message withCustomView:(ZLCustomAlertView *_Nullable)customView withCallBackBlock:(ZLAlertViewCallBackBlock _Nullable )callBackBlock;

//添加按钮
- (void)addAction:(ZLAlertAction *_Nullable)action;

@end
