//
//  ZLAlertViewController.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertViewController.h"

#define kTagIndex 9999900
@interface ZLAlertViewController ()<UIScrollViewDelegate>

//背景View
@property (nonatomic, strong) UIView         *bgView;

//标题
@property (nonatomic, strong) UILabel        *titleLabel;

//UIScrollView
@property (nonatomic, strong) UIScrollView   *scrollView;

//内容视图
@property (nonatomic, strong) UIView         *containerView;

//图片
@property (nonatomic, strong) UIImageView    *markImageView;

//内容消息
@property (nonatomic, strong) UILabel        *messageLabel;

//取消按钮
@property (nonatomic, strong) UIButton       *cancleButton;

//确定按钮
@property (nonatomic, strong) UIButton       *sureButton;

//右上角取消按钮
@property (nonatomic, strong) UIButton      *deleteButton;

//所有的按钮数据
@property (nonatomic, strong) NSMutableArray *actionsArray;

//背景框的宽度
@property (nonatomic, assign) CGFloat        bgWidth;

//自定义View
@property (nonatomic, strong) ZLCustomAlertView *zl_customAlertView;

@end

@implementation ZLAlertViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.5];

}
+ (instancetype)zl_alertControllerWithTitle:(nullable NSString *)title withMessage:(nullable NSString *)message withIconImage:(nullable NSString *)iconImageName withCallBackBlock:(ZLAlertViewCallBackBlock _Nullable)callBackBlock {

    ZLAlertViewController *alertViewCtrl = [[ZLAlertViewController alloc] init];
    alertViewCtrl.alertCallBackBlock = callBackBlock;
    alertViewCtrl.titleName = title;
    alertViewCtrl.messageName = message;
    alertViewCtrl.iconImageName = iconImageName;
    return alertViewCtrl;
}
//自定义View
+ (instancetype _Nullable )zl_alertControllerWithTitle:(nullable NSString *)title withMessage:(nullable NSString *)message withCustomView:(ZLCustomAlertView *_Nullable)customView withCallBackBlock:(ZLAlertViewCallBackBlock _Nullable )callBackBlock{
    ZLAlertViewController *alertViewCtrl = [[ZLAlertViewController alloc] init];
    alertViewCtrl.titleName = title;
    alertViewCtrl.messageName = message;
    alertViewCtrl.alertCallBackBlock = callBackBlock;
    alertViewCtrl.zl_customAlertView = customView;
    return alertViewCtrl;
}

#pragma mark -Create UI
- (void)_willPresent {
    
     [self createSubViewsUI];
}
- (void)createSubViewsUI {
    
    //背景框的宽度
    _bgWidth = kScreenWidth * 170 / 210;
    
    //背景框
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5.0;
    _bgView.clipsToBounds = YES;
    [self.view addSubview:_bgView];
    
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = UIColorHex(0x666666);
    _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [_bgView addSubview:_titleLabel];
    
    //UIScrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    [_bgView addSubview:_scrollView];
    
    //子视图
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_containerView];
    
    //图片
    _markImageView = [[UIImageView alloc] init];
    _markImageView.clipsToBounds = YES;
    _markImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_containerView addSubview:_markImageView];
    
    //内容消息
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = [UIFont systemFontOfSize:17.0f];
    _messageLabel.textColor = UIColorHex(0x333333);
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.numberOfLines = 0;
    _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    if (self.zl_customAlertView) {
        [_bgView addSubview:_messageLabel];
    } else {
        [_containerView addSubview:_messageLabel];
    }
    
    
    //点击按钮
    //取消按钮
    _cancleButton = [self createButton];
    _cancleButton.tag = kTagIndex;
    [_bgView addSubview:_cancleButton];
    
    //确定按钮
    _sureButton = [self createButton];
    _sureButton.tag = 1 + kTagIndex;
    [_bgView addSubview:_sureButton];
    
    //右上角取消按钮
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
    _deleteButton.hidden = _isShow;
    _deleteButton.tag = 2 + kTagIndex;
    [_bgView addSubview:_deleteButton];
    @weakify(self)
    if (self.zl_customAlertView) {
        [_bgView addSubview:self.zl_customAlertView];
        self.zl_customAlertView.customViewClick = ^(ZLCustomAlertView *alertView, NSInteger selectIndex) {
            @strongify(self)
            [self dismissViewControllerAnimated];
            if (self.alertCallBackBlock) {
                self.alertCallBackBlock(selectIndex);
            }
        };
    }
    
    [self makeUIConstraints];
}
#pragma mark -Constraints
- (void)makeUIConstraints {
       WS(ws);
    //背景框
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).mas_offset(0);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(ws.bgWidth, 170));
    }];
    
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.bgView.mas_left).mas_offset(30);
        make.top.mas_equalTo(ws.bgView.mas_top).mas_offset(20);
        make.right.mas_equalTo(ws.bgView.mas_right).mas_offset(-30);
        make.height.mas_equalTo(0);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.bgView.mas_left).mas_offset(30);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(ws.bgView.mas_right).mas_offset(-30);
        make.height.mas_equalTo(0);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.scrollView).mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(ws.scrollView.mas_width);
        make.height.mas_equalTo(MAXFLOAT);
    }];
    
    //图片
    [_markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.containerView.mas_centerX).mas_offset(0);
        make.top.mas_equalTo(ws.containerView.mas_top).mas_offset(0);
        make.size.mas_equalTo(CGSizeZero);
    }];
    
    //内容消息
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.containerView.mas_left).mas_offset(0);
        make.top.mas_equalTo(ws.markImageView.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(ws.containerView.mas_right).mas_offset(-0);
        make.height.mas_equalTo(0);
    }];
    
    CGFloat width =  (_bgWidth - 20 - 20 ) / 2;
    
    //取消按钮
    [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.bgView.mas_left).mas_offset(20);
        make.top.mas_equalTo(ws.scrollView.mas_bottom).mas_offset(25);
        make.size.mas_equalTo(CGSizeMake(width, 45));
    }];
    
    //确定按钮
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.bgView.mas_right).mas_offset(-20);
        make.top.mas_equalTo(ws.scrollView.mas_bottom).mas_offset(25);
        make.size.mas_equalTo(CGSizeMake(width, 45));
    }];
    
    //右上角删除按钮
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.bgView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(ws.bgView.mas_top).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    if (self.zl_customAlertView) {
        [self.zl_customAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.messageLabel.mas_bottom).mas_offset(0);
            make.centerX.mas_equalTo(ws.bgView);
            make.size.mas_equalTo(CGSizeMake(self.zl_customAlertView.frame.size.width, self.zl_customAlertView.frame.size.height));
        }];
    }
}
//正在present
- (void)_onPresent {
    if (self.zl_customAlertView) {
        [self updataZLCustomView];
    } else {
        [self updateTitleLabelAndMessageLabel];
    }

}
//已经present
- (void)_didPresented {
    if (!self.zl_customAlertView) {
        [self showViewCtrl];
    }
}
//添加按钮
- (void)addAction:(ZLAlertAction *)action {
    
    if (!_actionsArray) {
        _actionsArray = [NSMutableArray array];
    }
    [_actionsArray addObject:action];

}
//展示视图
- (void)showViewCtrl {

    if (_actionsArray > 0) {
        [_actionsArray enumerateObjectsUsingBlock:^(ZLAlertAction *action, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self addMakeUIConstraints:idx withAction:action];
        }];
    }else{
        [self addMakeUIConstraints:0 withAction:nil];
    }
}
- (void)setIsShow:(BOOL)isShow {
    
    _isShow = isShow;
    
    _deleteButton.hidden = _isShow;
}
//添加按钮的约束
- (void)addMakeUIConstraints:(NSInteger)index withAction:(ZLAlertAction *)action {
    WS(ws);
    CGFloat width = 0;
    if (_actionsArray.count == 1 || _actionsArray.count == 0) {
        width = 135;
    }else{
        width = (_bgWidth - 30 - 30 * (_actionsArray.count - 1)) / (_actionsArray.count);
    }
    UIButton *button = [_bgView viewWithTag:index + kTagIndex];
    if (!ZLStringIsNull(action.titleName)) {
        [button setTitle:[NSString stringWithFormat:@"%@",action.titleName] forState:UIControlStateNormal];
    }
    if (_actionsArray.count == 0 || _actionsArray.count == 1) {
        if (_actionsArray.count == 1) {
            if (action.titleFont) {
                button.titleLabel.font = (UIFont *)action.titleFont;
            }else{
                button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
            }
            if (action.btnTitleColor) {
                [button setTitleColor:(UIColor *)action.btnTitleColor forState:UIControlStateNormal];
            }else{
                [button setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
            }
            if (action.bgColor) {
                button.backgroundColor = action.bgColor;
            }else{
                button.backgroundColor = [UIColor whiteColor];
            }
        }else{
            
        }
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.bgView.mas_left).mas_offset((ws.bgWidth - width) / 2.0);
            make.size.mas_equalTo(CGSizeMake(width, 45));
        }];
        [_sureButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
        }];
        
    }else{
        if (action.titleFont) {
            button.titleLabel.font = (UIFont *)action.titleFont;
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        }
        if (action.btnTitleColor) {
            [button setTitleColor:(UIColor *)action.btnTitleColor forState:UIControlStateNormal];
        }
        if (index == 0) {
            button.layer.cornerRadius = 22.5f;
            button.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
            button.layer.borderWidth = 1;
        }
        if (action.bgColor) {
            button.backgroundColor = action.bgColor;
        }else{
            button.backgroundColor = UIColorHex(0xffffff);
        }
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.bgView.mas_left).mas_offset(15 + index * (width + 30));
            make.size.mas_equalTo(CGSizeMake(width, 45));
        }];
    }
}
//更新头部的标题titleLabel和MessageLabel的高度
- (void)updateTitleLabelAndMessageLabel {
    
    //bgView的总的高度
    CGFloat viewHeight = 0;
    
    viewHeight += 20;
    if (!ZLStringIsNull(_iconImageName)) {
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = UIColorHex(0x333333);
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = UIColorHex(0x999999);
    }else{
        _titleLabel.textColor = UIColorHex(0x666666);
        _messageLabel.textColor = UIColorHex(0x333333);
    }
    //标题
    if (ZLStringIsNull(_titleName)) {
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        //标题的高度
        CGFloat titleHeight = [self calculateTheSizeOfTheContent:_titleName withSizeFont:_titleLabel.font.pointSize];
        
        viewHeight += titleHeight;
        
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(titleHeight);
        }];
        _titleLabel.text = ZLIFISNULL(_titleName);
    }
    
    //ScrollView的高度
    CGFloat contentHeight = 0;
        WS(ws);
    //图片
    if (ZLStringIsNull(_iconImageName) && ZLStringIsNull(_messageName)) {
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [_markImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
        }];
        [_messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        if (!ZLStringIsNull(_iconImageName)) {
            _markImageView.image = [UIImage imageNamed:ZLIFISNULL(_iconImageName)];
            [_markImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(ws.markImageView.image.size);
            }];
            contentHeight = _markImageView.image.size.height;
        }
        
        CGFloat messageHeight = [self calculateTheSizeOfTheContent:ZLIFISNULL(_messageName) withSizeFont:_messageLabel.font.pointSize];
        
        //ScrollView的高度
        CGFloat scrollHeight = (messageHeight > (kScreenHeight / 2) ? (kScreenHeight / 2) : messageHeight ) + contentHeight + 5;
        
        if (scrollHeight > messageHeight) {
            _scrollView.scrollEnabled = YES;
        }else{
            _scrollView.scrollEnabled = NO;
        }
        
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (!ZLStringIsNull(_iconImageName)) {
                make.top.mas_equalTo(ws.titleLabel.mas_bottom).mas_offset(10);
            }else{
                make.top.mas_equalTo(ws.titleLabel.mas_bottom).mas_offset(17);
            }
            make.height.mas_equalTo(scrollHeight);
        }];
        [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(messageHeight);
        }];
        
        [_messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(messageHeight);
        }];
        _messageLabel.text = _messageName;
        
        viewHeight += 30;
        
        viewHeight += scrollHeight;
    }
    if (!ZLStringIsNull(_iconImageName)) {
        viewHeight += 10;
    }else{
        viewHeight += 17;
    }
   
    viewHeight += 50;
    viewHeight += 20;
    
    if (viewHeight > 170) {
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(viewHeight);
        }];
    }
}

//更新自定义View
- (void)updataZLCustomView {

    _scrollView.hidden = YES;
    _cancleButton.hidden = YES;
    _sureButton.hidden = YES;
    
    //bgView的总的高度
    CGFloat viewHeight = 0;
    
    viewHeight += 20;
    
        WS(ws);
    
    //标题
    if (ZLStringIsNull(_titleName)) {
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        
        //标题的高度
        CGFloat titleHeight = [self calculateTheSizeOfTheContent:_titleName withSizeFont:_titleLabel.font.pointSize];
        
        viewHeight += titleHeight;
        
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(titleHeight);
        }];
        _titleLabel.text = ZLIFISNULL(_titleName);
    }
    
    CGFloat messageHeight = [self calculateTheSizeOfTheContent:ZLIFISNULL(_messageName) withSizeFont:_messageLabel.font.pointSize] + 30;

    [_messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.bgView.mas_left).mas_offset(0);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(ws.bgView.mas_right).mas_offset(-0);
        make.height.mas_equalTo(messageHeight);
    }];
    
    viewHeight += messageHeight;
    _messageLabel.text = _messageName;
    
    viewHeight += self.zl_customAlertView.frame.size.height;
    viewHeight += 50;
    
    if (viewHeight > 170) {
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(viewHeight);
        }];
    }
}
//计算内容的大小
- (CGFloat)calculateTheSizeOfTheContent:(NSString *)contentStr withSizeFont:(CGFloat)fontSize {
    
    CGSize contentSize = [contentStr boundingRectWithSize:CGSizeMake(_bgWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return contentSize.height + 5;
}
//将要dismiss
- (void)_willDismiss {

    [self dismissViewControllerAnimated];
}
//视图正在消失
- (void)_onDismiss {

    [self dismissViewControllerAnimated];
}
//视图已经消失
- (void)_didDismiss {

    [self dismissViewControllerAnimated];
}
//创建按钮
- (UIButton *)createButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.layer.cornerRadius = 22.5f;
    button.clipsToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitleColor:UIColorHex(0x000000) forState:UIControlStateNormal];
    return button;
    
}
//点击事件
- (void)actionButtonClick:(UIButton *)button {
    
    [self dismissViewControllerAnimated];
    if (self.alertCallBackBlock) {
        self.alertCallBackBlock(button.tag - kTagIndex);
    }
}
//取消事件
- (void)deleteButtonClick:(UIButton *)button {
    
   [self dismissViewControllerAnimated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
