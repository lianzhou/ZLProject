//
//  ZLCustomAlertView.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLCustomAlertView;

typedef void(^CustomViewClick)(ZLCustomAlertView *alertView, NSInteger selectIndex);

@interface ZLCustomAlertView : UIView

@property(nonatomic ,copy) CustomViewClick customViewClick;

@end
