//
//  ZLAlertBaseComponent.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertBaseComponent.h"

@interface ZLAlertBaseComponent () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIViewController *rootViewController;

@property (nonatomic) CGFloat backgroundOpacity;

@property (nonatomic) BOOL restoreInteractivePopGestureEnabled;

@property (weak, nonatomic) id<UIGestureRecognizerDelegate> restoreInteractivePopGestureDelegate;

@end

@implementation ZLAlertBaseComponent

#pragma mark - LiftCycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _shouldHideOnTouchOutside = NO;
        [self createViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self placeViews];
    
    const CGSize sz = kMainBounds.size;
    CGRect r;
    if (self.view.superview != nil) {
        r = CGRectMake((sz.width - _windowWidth) * 0.5, (sz.height - _windowHeight) * 0.5, _windowWidth, _windowHeight);
    }
    else {
        r = CGRectMake((sz.width - _windowWidth) * 0.5, -_windowHeight, _windowWidth, _windowHeight);
    }
    self.view.frame = r;
    _contentView.frame = self.view.bounds;
    
}

- (void)dealloc {
    NSLog(@"ZLAlertView dealloc!!!");
    [self ableInteractivePopGestureRecognizer];
}


#pragma mark - Setter
- (void)setShouldHideOnTouchOutside:(BOOL)shouldHideOnTouchOutside {
    _shouldHideOnTouchOutside = shouldHideOnTouchOutside;
    
    if (_shouldHideOnTouchOutside) {
        _shouldHideOnTouchOutside = [self.backgroundView isUserInteractionEnabled];
    }
    
}

#pragma mark - Private
// 禁用侧滑
- (void)disableInteractivePopGestureRecognizer {
    UINavigationController *navigationController;
    
    if ([_rootViewController isKindOfClass:UINavigationController.class]) {
        navigationController = (UINavigationController *)_rootViewController;
    }
    else {
        navigationController = _rootViewController.navigationController;
    }
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        _restoreInteractivePopGestureEnabled = navigationController.interactivePopGestureRecognizer.enabled;
        _restoreInteractivePopGestureDelegate = navigationController.interactivePopGestureRecognizer.delegate;
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
}

// 开启侧滑
- (void)ableInteractivePopGestureRecognizer {
    UINavigationController *navigationController;
    
    if ([_rootViewController isKindOfClass:UINavigationController.class]) {
        navigationController = (UINavigationController *)_rootViewController;
    }
    else {
        navigationController = _rootViewController.navigationController;
    }
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = _restoreInteractivePopGestureEnabled;
        navigationController.interactivePopGestureRecognizer.delegate = _restoreInteractivePopGestureDelegate;
    }
}

#pragma mark - APIs

- (void)alertWith:(UIViewController *)vc {
    
    if (vc) {
        _rootViewController = vc;
        
        [self disableInteractivePopGestureRecognizer];
        
        self.backgroundView.frame = _rootViewController.view.bounds;
        [_rootViewController.view addSubview:self.backgroundView];
        
        [_rootViewController addChildViewController:self];
        [_rootViewController.view addSubview:self.view];
    }
    else {
        UIWindow *keyWindow = [[UIApplication sharedApplication].delegate window];
        
        self.backgroundView.frame = keyWindow.rootViewController.view.bounds;
        [keyWindow.rootViewController.view addSubview:self.backgroundView];
        
        [keyWindow.rootViewController addChildViewController:self];
        [keyWindow.rootViewController.view addSubview:self.view];
    }
    
    [self showView];
    
}


- (void)createViews {
    _windowWidth = [UIScreen mainScreen].bounds.size.width * (1 - 60.0 / 375.0);    // 弹窗默认宽度
    _windowHeight = 178.0f;                                                         // 弹窗默认高度
    
    _contentView = [[UIView alloc] init];
    _contentView.layer.cornerRadius = 4.0f;
    _contentView.layer.masksToBounds = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
}

- (void)placeViews { }


- (void)hideView {
    [self fadeOutWithDuration:0.2f];
}

- (void)fadeOutWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.backgroundView.alpha = 0.0f;
        self.view.alpha = 0.0f;
    } completion:^(BOOL completed) {
        [self.backgroundView removeFromSuperview];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)showView {
    [self fadeIn];
}

- (void)bgClicked:(UITapGestureRecognizer *)ges {
    
    if (_shouldHideOnTouchOutside) {
        [self hideView];
    }
    
}

#pragma mark - Show Animations

- (void)fadeIn {
    self.backgroundView.alpha = 0.0f;
    self.view.alpha = 0.0f;
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
         usingSpringWithDamping:0.8f
          initialSpringVelocity:1.f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.backgroundView.alpha = self.backgroundOpacity;
                         self.view.alpha = 1.0f;
                     } completion:nil];
}

#pragma mark - Lazy load
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:kMainBounds];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.7f;
        _backgroundOpacity = 0.7f;
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgClicked:)]];
    }
    return _backgroundView;
}


@end
