//
//  ToolDemoViewController.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ToolDemoViewController.h"
#import "MineTableViewCell.h"
#import "ZLPickerView.h"
#import "BaseNavigationController.h"

#import "PGDatePickerHelper.h"


//IApRequestResultsDelegate
@interface ToolDemoViewController ()<UITableViewDelegate,UITableViewDataSource,ZLPickerViewDelegate,ZLPickerViewDataSource>
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) ZLPickerView *emitterPickView;
@property (nonatomic,copy) NSArray * emitterArray;
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) PGDatePickerHelper  *pickerHelper ;

@property(strong,nonatomic)TZImagePickerHelper *helperImage;


@end

@implementation ToolDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    self.emitterArray = @[@"彩带",@"下雪",@"下雨",@"烟花"];
    
    NSDictionary *tags = @{@"titleText":@"01 - 标签选择",@"clickSelector":@"tagsView"};
    NSDictionary *webView = @{@"titleText":@"02 - 网页 带进度条",@"clickSelector":@"openWebView"};
    NSDictionary *emitterView = @{@"titleText":@"03 - PickView选择器",@"clickSelector":@"emitter"};
    NSDictionary *IAPPay = @{@"titleText":@"04 - 日期选择",@"clickSelector":@"IAP"};
    NSDictionary *tabarBadge = @{@"titleText":@"05 - tabbr badges",@"clickSelector":@"tabarBadge"};
    NSDictionary *share = @{@"titleText":@"06 - 第三方分享",@"clickSelector":@"share"};
    NSDictionary *alert = @{@"titleText":@"07 - AlertView封装(多个方法)",@"clickSelector":@"alertView"};
    NSDictionary *action = @{@"titleText":@"08 - ActionSheet封装（兼容iOS 7+）",@"clickSelector":@"actionSheet"};
    NSDictionary *status = @{@"titleText":@"09 - 选择图片(支持视频)",@"clickSelector":@"TZImage"};
    NSDictionary *NavColor = @{@"titleText":@"10 - 改变导航栏颜色",@"clickSelector":@"changeNavBarColor"};
    NSDictionary *JSCore = @{@"titleText":@"11 - JS与Native交互",@"clickSelector":@"JSCallNative"};
    NSDictionary *scrollBanner = @{@"titleText":@"12 - 轮播图",@"clickSelector":@"scrollBanner"};
    
    self.dataArray =@[tags,webView,emitterView,IAPPay,tabarBadge,share,alert,action,status,NavColor,JSCore,scrollBanner].mutableCopy;
    
    [self initUI];
    
}


#pragma mark -  初始化页面
-(void)initUI{
   
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottomMargin);
    }];
    
    [self.tableView reloadData];
}

/**
 *  懒加载UITableView
 *
 *  @return UITableView
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.scrollsToTop = YES;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


#pragma mark ————— tableview 代理 —————
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
    cell.cellData = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = _dataArray[indexPath.row][@"titleText"];
    //    NSString *selector = _dataArray[indexPath.row][@"clickSelector"];
 //   [MBProgressHUD showTopTipMessage:title isWindow:YES];
    NSString *selectorStr = _dataArray[indexPath.row][@"clickSelector"];
    if (selectorStr && selectorStr.length>0) {
        SEL selector = NSSelectorFromString(_dataArray[indexPath.row][@"clickSelector"]);
        if (selector) {
            [self performSelector:selector withObject:nil];
        }
    }
    
}

 
#pragma mark -  ZLPickerView 代理
//列数
-(NSInteger)numberOfComponentsInPickerView:(ZLPickerView *)pickerView{
    return 1;
}

//行数
-(NSInteger)pickerView:(ZLPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.emitterArray.count;
}

//标题
-(NSString *)pickerView:(ZLPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.emitterArray[row];
}
//确认按钮点击
-(void)pickView:(ZLPickerView *)pickerView confirmButtonClick:(UIButton *)button{
//    NSInteger left = [pickerView selectedRowInComponent:0];
//    EmitterViewController *emitterVC = [[EmitterViewController alloc] init];
//    emitterVC.animation_type = left;
//    [self.navigationController pushViewController:emitterVC animated:YES];
    
}

//滑动选中
-(void)pickerView:(ZLPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

#pragma mark -  标签选择
-(void)tagsView{
 
    [self pushViewControllerName:@"TagsViewController"  withParams:nil];
}

#pragma mark -  网页测试
-(void)openWebView{
    RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:@"http://www.qinglanjiayuan.com:8088/get/appDetail/schoolArticle?id=57"];
    webView.isShowCloseBtn = YES;
    BaseNavigationController *loginNavi =[[BaseNavigationController alloc] initWithRootViewController:webView];
    [self presentViewController:loginNavi animated:YES completion:nil];
    
    //push
    //    RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:@"http://hao123.com"];
    //    [webView addNavigationItemWithTitles:@[@"测试"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1003]];
    //    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark -    选择器
-(void)emitter{
    [self.emitterPickView reloadData];
    //[self.userNumPickView selectRow:0 inComponent:0 animated:NO];
    [ZLAppWindow addSubview:self.emitterPickView];
    [self.emitterPickView show];
 
}

#pragma mark -  alertview
-(void)alertView{
 
    [ZLAlertView alertWithTitle:@"测试标题" content:@[@"测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容"] headImage:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定" block:^(NSInteger buttonIndex) {
        NSLog(@"点击了 %ld",buttonIndex);
    }];
    
    
//    [ZLAlertView alertWithTitle:@"测试标题" subTitle:@"测试副标题" headImage:[UIImage imageNamed:kplaceholderImage] content:@[@"测试内容"]  cancelButtonTitle:@"取消" otherButtonTitles:@"确定" block:^(NSInteger buttonIndex) {
//            NSLog(@"点击了 %ld",buttonIndex);
//    }];
    
//    [ZLAlertCtrl alertShowTitle:nil message:@"为了您更好地查看课件，建议使用第三方软件打开" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" block:^(NSInteger buttonIndex) {
//           NSLog(@"点击了 %ld",buttonIndex);
//        if (buttonIndex == 1) {
//
//        }
//        else {
//
//        }
//
//    }];
//    BSAlertView * alert = [BSAlertView.alloc initWithTitle:@"温馨提示" message:@"当前为4G网络，是否继续播放？" sureBtn:@"是"  cancleBtn:@"否"];
//    alert.resultIndex = ^(NSInteger index) {
//        if (index == 2) {
//
//        }
//    };
//    [alert show];
}

#pragma mark -  ActionSheet
-(void)actionSheet{
    [self ActionSheetWithTitle:@"测试" message:@"测试内容" destructive:nil destructiveAction:nil andOthers:@[@"1",@"2",@"3",@"4"] animated:YES action:^(NSInteger index) {
        NSLog(@"点了 %ld",index);
    }];
    
   
}

#pragma mark -  tabarBadge
-(void)tabarBadge{
    [ZLAppDelegate.mainTabBar setRedDotWithIndex:3 isShow:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -  IAPTest
-(void)IAP{
    [self.pickerHelper showPGDatePicker:self
                             titleLabel:@"日期选择"
                         datePickerMode:PGDatePickerModeDate
                                    tag:1];
 
}

-(PGDatePickerHelper *)pickerHelper{
    if(!_pickerHelper){
        _pickerHelper = [[PGDatePickerHelper alloc] init];
       // WS(weakSelf);
        _pickerHelper.finish = ^(int tag,NSDateComponents *dateComponents){
            dispatch_async(dispatch_get_main_queue(), ^{
              //  [weakSelf setTime:tag dateComponents:dateComponents];
            });
        };
        
        _pickerHelper.minimumDate = [NSDate NSStringToNSDate:@"2018-01-01" format:kDEFAULT_DATE_FORMAT];
        
        _pickerHelper.maximumDate = [NSDate NSStringToNSDate:[NSDate DateTimeNow:kDEFAULT_DATE_FORMAT] format:kDEFAULT_DATE_FORMAT];
        
        _pickerHelper.nowDate=[NSDate NSStringToNSDate:[NSDate DateTimeNow:kDEFAULT_DATE_FORMAT] format:kDEFAULT_DATE_FORMAT];
        
    }
    return  _pickerHelper;
}

-(void)TZImage{

[self.helperImage showImagePickerControllerWithMaxCount:1
                                                 isCrop:NO  isTakeVideo:NO
                                 initWithViewController:AppDelegate.shareAppDelegate.window.rootViewController
                                              selectTag:1];
}

-(TZImagePickerHelper *)helperImage{
    if(!_helperImage){
        _helperImage = [[TZImagePickerHelper alloc] init];
        WS(ws);
        _helperImage.finishVoide = ^(double time,UIImage *coverImage, NSData *video) {
           
        };
        _helperImage.finish = ^(NSInteger tag, NSArray *array) {
            
        };
    }
    return  _helperImage;
}

#pragma mark -  share
-(void)share{
 //   [[ShareManager sharedShareManager] showShareView];
}

#pragma mark -  修改状态栏样式
-(void)changeStatusStyle{
    self.StatusBarStyle = !self.StatusBarStyle;
}

#pragma mark -  修改导航栏颜色
-(void)changeNavBarColor{
//    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
//    [self.navigationController.navigationBar lt_setBackgroundColor:color];
}

#pragma mark -  JSCallNative
-(void)JSCallNative{
    //    NSString * fileUrl = [[NSBundle mainBundle]pathForResource:@"JSToOC" ofType:@"html"];
    //    NSURL * file = [NSURL fileURLWithPath:fileUrl];
    //
    //    NativeCallJSVC *webVC = [[NativeCallJSVC alloc] initWithUrl:file.absoluteString];
    //    webVC.isHidenNaviBar = YES;
    //    RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:webVC];
    //
    //    [self presentViewController:loginNavi animated:YES completion:nil];
}

#pragma mark -  scrollBanner
-(void)scrollBanner{
 
    [self pushViewControllerName:@"ScrollBannerVC"  withParams:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
}

-(ZLPickerView *)emitterPickView{
    if(!_emitterPickView){
        _emitterPickView = [[ZLPickerView alloc]initWithFrame:SCREEN_BOUNDS  title:@"请选择"];
        _emitterPickView.delegate = self;
        _emitterPickView.dataSource = self;
 
    }
    return _emitterPickView;
}



@end
