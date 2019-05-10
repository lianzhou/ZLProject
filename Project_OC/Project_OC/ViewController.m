//
//  ViewController.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/7.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ViewController.h"
#import "ZLEncryptManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[ZLEncryptManager encryptMD5WithString:
   
    
    WS(ws);
    YYLabel *skipBtn = [[YYLabel alloc] initWithFrame:CGRectMake(0, 200, 150, 60)];
    skipBtn.text = @"测试";
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
    
    NSDictionary *params = @{
                             @"deviceToken":@"111111",
                             @"loginPhone" : @"13912794967",
                             @"password" : [ZLEncryptManager encryptMD5WithString:@"123456"]
                             };
    [ZLAlertHUD showHUDTitle:@"发布中..." toView:self.view];
    [ZLNetworkHelper  POST:URL_user_login parameters:params completion:^(ZLNetworkRsponse * _Nonnull rsp) {
        [ZLAlertHUD hideHUD:self.view];
        if( rsp.success){
            [ZLAlertHUD showTipTitle:rsp.msg];
        }else{
            [ZLAlertHUD showTipTitle:rsp.msg];
        }
    }];
    
}
@end
