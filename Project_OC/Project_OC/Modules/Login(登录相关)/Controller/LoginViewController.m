//
//  LoginViewController.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"登录";
    WS(ws);
    YYLabel *skipBtn = [[YYLabel alloc] initWithFrame:CGRectMake(0, 200, 150, 60)];
    skipBtn.text = @"跳过登录";
    skipBtn.font = KDEFAULTFONT(20);
    skipBtn.textColor = KBlueColor;
    skipBtn.backgroundColor = KClearColor;
    skipBtn.textAlignment = NSTextAlignmentCenter;
    skipBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    skipBtn.centerX = kScreenW/2;
    
    skipBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
   
        
        [ws skipAction];
    };
    
    [self.view addSubview:skipBtn];
}

-(void)skipAction{
    ZLPostNotification(KNotificationLoginStateChange, @YES);
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
