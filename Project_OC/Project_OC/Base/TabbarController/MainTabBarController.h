//
//  MainTabBarController.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 底部 TabBar 控制器
 */
@interface MainTabBarController : UITabBarController

/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
