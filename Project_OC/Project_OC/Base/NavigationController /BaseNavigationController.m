//
//  BaseNavigationController.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Utilities.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController


//APP生命周期中 只会执行一次
+ (void)initialize{
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setBarTintColor:KWhiteColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :KBlackColor, NSFontAttributeName : KDEFAULTBOLDFONT(18) } ];
    [navBar setShadowImage:[UIImage new]];//去掉阴影线
    //  [navBar setShadowImage:[UIImage imageWithColor:LineColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        [Utilities createLeftBarButton:viewController clichEvent:@selector(backBtnClicked)];
    }
    dispatch_async_on_main_queue(^{
        [super pushViewController:viewController animated:animated];
    });
}

-(void)backBtnClicked{
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
