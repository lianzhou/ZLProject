//
//  RootWebViewController.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/7.
//  Copyright © 2019 zhoulian. All rights reserved.
//  webview 基类

#import "XLWebViewController.h"

@interface RootWebViewController : XLWebViewController

//在多级跳转后，是否在返回按钮右侧展示关闭按钮
@property(nonatomic,assign) BOOL isShowCloseBtn;
@end

