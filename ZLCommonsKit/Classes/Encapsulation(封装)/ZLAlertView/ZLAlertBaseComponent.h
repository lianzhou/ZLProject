//
//  ZLAlertBaseComponent.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMainBounds [UIScreen mainScreen].bounds
static NSString *kDefaultFont = @"PingFangSC-Regular";  // 内容的Font
static CGFloat kContentMaxHeight = 208.f;               // 内容的最大高度

@interface ZLAlertBaseComponent : UIViewController {
    @protected
    UIView *_backgroundView;
    UIView *_contentView;
    
    CGFloat _windowHeight;
    CGFloat _windowWidth;
}

@property (strong, nonatomic) UIView    *backgroundView;    // 遮罩View

@property (strong, nonatomic) UIView    *contentView;       // 弹窗容器View

@property (nonatomic) BOOL shouldHideOnTouchOutside;        // 默认是 NO
@property (nonatomic) CGFloat windowHeight;
@property (nonatomic) CGFloat windowWidth;

#pragma mark - 子类实现
- (void)createViews NS_REQUIRES_SUPER;
- (void)placeViews NS_REQUIRES_SUPER;

- (void)alertWith:(UIViewController *)vc;
- (void)hideView;

@end
