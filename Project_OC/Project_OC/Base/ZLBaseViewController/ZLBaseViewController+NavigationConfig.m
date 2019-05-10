//
//  ZLBaseViewController+NavigationConfig.m
//  ZLCommonsKit
//
//         我有一壶酒,足以慰风尘
//         倾倒江海里,共饮天下人
//
//  Created by zhoulian on 17/7/10.
//  Copyright © 2017年 zhoulian. All rights reserved.
//

#import "ZLBaseViewController+NavigationConfig.h"
#import "ZLSystemMacrocDefine.h"
#import "NSString+Extension.h"
#import <objc/runtime.h>

@implementation ZLBaseViewController (NavigationConfig)

- (void)setNavigationBarLeftItemTitle:(NSString *)title{
    [self setNavigationBarLeftItemTitle:title image:nil stateHighlightedImage:nil stateDisabledImage:nil];
}
- (void)setNavigationBarLeftItemimage:(NSString *)iconName{
    [self setNavigationBarLeftItemTitle:nil image:iconName stateHighlightedImage:nil stateDisabledImage:nil];
}
- (void)setNavigationBarLeftItemTitle:(NSString *)title image:(NSString *)iconName{
    [self setNavigationBarLeftItemTitle:title image:iconName stateHighlightedImage:nil stateDisabledImage:nil];
}
- (void)setNavigationBarLeftItemTitle:(NSString *)title image:(NSString *)iconName stateHighlightedImage:(NSString *)highlightIconName{
    [self setNavigationBarLeftItemTitle:title image:iconName stateHighlightedImage:highlightIconName stateDisabledImage:nil];
}

- (void)setNavigationBarLeftItemTitle:(NSString *)title image:(NSString *)iconName stateHighlightedImage:(NSString *)highlightIconName stateDisabledImage:(NSString *)disableIconName{
    
    UIButton *tmpLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpLeftButton.exclusiveTouch = YES;
    if (title) {
        [tmpLeftButton setTitle:title forState:UIControlStateNormal];
        [tmpLeftButton setTitleColor:UIColorFromRGB(333333) forState:UIControlStateNormal];
        tmpLeftButton.titleLabel.font = [UIFont systemFontOfSize:15.0];

    }
     
    if (iconName) {
        [tmpLeftButton setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
    if (highlightIconName) {
        [tmpLeftButton setImage:[UIImage imageNamed:highlightIconName] forState:UIControlStateHighlighted];
    }
    if (disableIconName) {
        [tmpLeftButton setImage:[UIImage imageNamed:disableIconName] forState:UIControlStateDisabled];
    }
    [tmpLeftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpLeftButton];

    if (ZL_IOS11) {
        if (@available(iOS 11.0, *)) {
            [tmpLeftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [tmpLeftButton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            [self.navigationItem setLeftBarButtonItem:leftButtonItem];
            return;
        }
    }
    
    tmpLeftButton.frame = CGRectMake(10, 0, 44, 44);
    [tmpLeftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10;
    [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, leftButtonItem]]; 
}

- (void)leftButtonPressed:(UIButton *)sender{
    if (self.popCompletion) {
        self.popCompletion();
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonPressed:(UIButton *)sender{
    
}

- (void)setNavigationBarRightItemTitle:(NSString *)title{
    [self setNavigationBarRightItemTitle:title image:nil stateHighlightedImage:nil stateDisabledImage:nil];
}
- (void)setNavigationBarRightItemimage:(NSString *)iconName{
    [self setNavigationBarRightItemTitle:nil image:iconName stateHighlightedImage:nil stateDisabledImage:nil];
}
- (void)setNavigationBarRightItemTitle:(NSString *)title image:(NSString *)iconName{
    [self setNavigationBarRightItemTitle:title image:iconName stateHighlightedImage:nil stateDisabledImage:nil];
}
- (void)setNavigationBarRightItemTitle:(NSString *)title image:(NSString *)iconName stateHighlightedImage:(NSString *)highlightIconName{
    [self setNavigationBarRightItemTitle:title image:iconName stateHighlightedImage:highlightIconName stateDisabledImage:nil];
}
- (UIColor *)tmpRightButtonTitleColor{
    return UIColorFromRGB(666666);
}
- (UIButton *)tmpRightButton{
//    if (self.zl_navigationBarRightButton) {
//        return self.zl_navigationBarRightButton;
//    }
    UIButton *tmpRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.zl_navigationBarRightButton =tmpRightButton;
    return tmpRightButton;
}
- (void)setNavigationBarRightItemTitle:(NSString *)title image:(NSString *)iconName stateHighlightedImage:(NSString *)highlightIconName stateDisabledImage:(NSString *)disableIconName{
    UIButton *tmpLeftButton = [self tmpRightButton];
    tmpLeftButton.exclusiveTouch = YES;
    if (title) {
        [tmpLeftButton setTitle:title forState:UIControlStateNormal];
        [tmpLeftButton setTitleColor:[self tmpRightButtonTitleColor] forState:UIControlStateNormal];
        tmpLeftButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    if (iconName) {
        [tmpLeftButton setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
    if (highlightIconName) {
        [tmpLeftButton setImage:[UIImage imageNamed:highlightIconName] forState:UIControlStateHighlighted];
    }
    if (disableIconName) {
        [tmpLeftButton setImage:[UIImage imageNamed:disableIconName] forState:UIControlStateDisabled];
    }
    [tmpLeftButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpLeftButton];

    if (ZL_IOS11) {
        if (@available(iOS 11.0, *)) {
            [tmpLeftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [tmpLeftButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
            [self.navigationItem setRightBarButtonItem:leftButtonItem];
            return;
        }
    }

    //iOS11系统之前计算宽度
    CGFloat buttonWidth = 44.f;
    
    if (title) {
        
        CGFloat titleWidth = [title textSizeIn:CGSizeMake(kScreenW, MAXFLOAT) font:[UIFont systemFontOfSize:15.f]].width;
        
        if (titleWidth > buttonWidth) {
            
            buttonWidth = titleWidth;
        }
    }
    
    if (iconName) {
        
        CGFloat imageWidth = [UIImage imageNamed:iconName].size.width;
        if (imageWidth > buttonWidth) {
            
            buttonWidth = imageWidth;
        }
    }

    tmpLeftButton.frame = CGRectMake(10, 0, buttonWidth, 44);
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -5;
    [self.navigationItem setRightBarButtonItems:@[negativeSeperator, leftButtonItem]];


}

#pragma mark -- 在左边或者右边增加UIBarButtonItem
- (void)appendRightBarItemWithCustomButton:(UIButton *)button atIndex:(NSUInteger)index
{
    [self appendBarItemWithCustomButton:button atIndex:index isLeft:NO];
}
- (void)appendLeftBarItemWithCustomButton:(UIButton *)button atIndex:(NSUInteger)index
{
    [self appendBarItemWithCustomButton:button atIndex:index isLeft:YES];
}

- (void)appendBarItemWithCustomButton:(UIButton *)button atIndex:(NSUInteger)index isLeft:(BOOL)isLeft
{
    NSMutableArray *oldRightBarItems = [NSMutableArray arrayWithArray:isLeft?self.navigationItem.leftBarButtonItems:self.navigationItem.rightBarButtonItems];
    UIBarButtonItem *rightNewItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [oldRightBarItems insertObject:rightNewItem atIndex:index];
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = oldRightBarItems;
    }else{
        self.navigationItem.rightBarButtonItems = oldRightBarItems;
    }
}
static const char *zl_navigationBarRightButtonKey = "zl_navigationBarRightButtonKey";


- (void)setZl_navigationBarRightButton:(UIButton *)zl_navigationBarRightButton{
    objc_setAssociatedObject(self, &zl_navigationBarRightButtonKey, zl_navigationBarRightButton, OBJC_ASSOCIATION_ASSIGN);
}
- (UIButton *)zl_navigationBarRightButton{
    return objc_getAssociatedObject(self, &zl_navigationBarRightButtonKey);
}

@end
