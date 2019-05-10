//
//  ZLAlertInfoView.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertInfoView.h"

// Font
static NSString *kInfoTitleFont = @"PingFangSC-Semibold";

@interface ZLAlertInfoView ()
@property (nonatomic, strong) UIImageView                   *leftDot;
@property (nonatomic, strong) UIImageView                   *rightDot;
@property (nonatomic, strong) UILabel                       *titleLab;
@property (nonatomic, strong) UITextView                    *textView;
@property (nonatomic, strong) UIImageView                   *showContent;
@end

@implementation ZLAlertInfoView

#pragma mark - Override
- (void)createViews {
    [super createViews];
    _windowWidth = [UIScreen mainScreen].bounds.size.width * (1 - 80.0 / 375.0);    // 弹窗默认宽度
    _textAlignment = NSTextAlignmentLeft;
    
    // 圆点
    _leftDot = [self createDot];
    
    // 标题
    _titleLab = [[UILabel alloc] init];
    _titleLab.numberOfLines = 1;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = [UIFont fontWithName:kInfoTitleFont size:17.0f];
    _titleLab.textColor = UIColorHex(333333);
    _titleLab.hidden = YES;
    [_contentView addSubview:_titleLab];
    
    // 圆点
    _rightDot = [self createDot];
    
    // 内容
    _textView = [[UITextView alloc] init];
    _textView.hidden = YES;
    _textView.textAlignment = _textAlignment;
    _textView.editable = NO;
    
//    _textView.textContainerInset = UIEdgeInsetsZero; // 文本容器在内嵌容器的边距设为0
    CGFloat padding = _textView.textContainer.lineFragmentPadding;
    _textView.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding);
    _textView.textColor = UIColorHex(666666);
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping; // 计算结果不准确是因为没有设置这一行
    paragraphStyle.lineSpacing = 10.f;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont fontWithName:kDefaultFont size:15.f],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _textView.typingAttributes = attributes;

    [_contentView addSubview:_textView];

    // 图片
    _showContent = [[UIImageView alloc] init];
    _textView.hidden = YES;
    [self.view addSubview:_showContent];
}

// 圆点
- (UIImageView *)createDot {
    
    UIImageView *button = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ZLAlertButtonView_Dot"]];
    [_contentView addSubview:button];
    return button;
    
}

- (void)placeViews {
    [super placeViews];
    
    // 圆点
    _leftDot.frame = CGRectMake(20, 20, _leftDot.image.size.width, _leftDot.image.size.height);
    
    _rightDot.frame = (CGRect) {
        .origin.x = _windowWidth - CGRectGetMinX(_leftDot.frame) - CGRectGetWidth(_leftDot.frame),
        .origin.y = CGRectGetMinY(_leftDot.frame),
        .size.width = CGRectGetWidth(_leftDot.frame),
        .size.height = CGRectGetHeight(_leftDot.frame)
    };
    
    UIView *preView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // 标题的最大宽度 = 内容的宽度
    const CGFloat maxW = _windowWidth * 0.65;
    // 标题
    CGRect titleLabF = CGRectZero;
    if (!_titleLab.hidden) {
        CGSize titleLabSize = [_titleLab sizeThatFits:CGSizeZero];
        
        if (titleLabSize.width > maxW) {
            titleLabSize.width = maxW;
        }
        titleLabF = (CGRect) {
            .origin.x = (_windowWidth - titleLabSize.width) * 0.5,
            .origin.y = 20.f,
            .size = titleLabSize
        };
        
        preView = _titleLab;
    }
    
    _titleLab.frame = titleLabF;
    
    
    // 内容
    CGRect conentListF = CGRectZero;
    
    if (!_textView.hidden) {
        CGFloat height = [_textView.text boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:_textView.typingAttributes context:nil].size.height;
        // 计算出来的 height 是精准的是 CGFloat 类型，但是设置UIlabel高度时会存在四舍五入等，最后存在的一点点误差使得 UILabel 显示不全，可能出现缺少一行，上下空白太多等情况；
        // 解决方案：为了确保布局按照我们计算的数据来，可以使用ceil函数对计算的 Size 取整，再加1，确保 UILabel按照计算的高度完好的显示出来； 或者使用方法CGRectIntegral(CGRect rect) 对计算的 Rect 取整，在加1;
        CGFloat h =  ceil(height) + 1.f;
        if (h > kContentMaxHeight + 66) {
            h = kContentMaxHeight + 66;
        }
        
        conentListF = (CGRect) {
            .origin.x = (_windowWidth - maxW) * 0.5,
            .origin.y = CGRectGetMaxY(preView.frame) + 10.f,
            .size.width = maxW,
            .size.height = h,
        };
        
        preView = _textView;
    }
    
    _textView.frame = conentListF;
    
    // 图片
    CGRect imageF = CGRectZero;
    
    if (!_showContent.hidden) {
        CGSize imgS = _showContent.image.size;
        // Alert 总高度
        _windowHeight = CGRectGetMaxY(preView.frame) + _showContent.image.size.height * 0.5;
        
        imageF = (CGRect) {
            .origin.x = -_showContent.image.size.width * 0.3,
            .origin.y = _windowHeight - _showContent.image.size.height,
            .size.width = imgS.width,
            .size.height = imgS.height,
        };
        
        if (imageF.origin.y < 0) {
            _showContent.hidden = YES;
            // Alert 总高度
            _windowHeight = CGRectGetMaxY(preView.frame) + 20.f;
        }
    }
    _showContent.frame = imageF;
    
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    _textView.textAlignment = _textAlignment;
}

- (instancetype)initWithCtrl:(nullable UIViewController *)viewController
                       title:(nullable NSString *)title
                    contents:(nullable NSString *)contents
                       image:(nullable UIImage *)image {
    
    self = [super init];
    if (self) {

        // 标题
        if (!title || title.length <= 0) {
            _titleLab.hidden = YES;
        }
        else {
            _titleLab.hidden = NO;
            _titleLab.text = title;
        }

        // 内容
        
        if (!contents || contents.length <= 0) {
            _textView.hidden = YES;
        }
        else {
            _textView.hidden = NO;
            _textView.text = contents;
            _textView.userInteractionEnabled = NO;
        }
        
        // 图片

        if (!image) {
            _showContent.hidden = YES;
        }
        else {
            _showContent.hidden = NO;
            _showContent.image = image;
        }
        
        [self alertWith:viewController];
    }
    return self;
    
}

#pragma mark - APIs
+ (instancetype)alertWithCtrl:(nullable UIViewController *)viewController
                        title:(nullable NSString *)title
                     contents:(nullable NSArray<NSString *> *)contents
                        image:(nullable UIImage *)image {
    
    if (contents && contents.count > 0) {
        
        NSString *contentStr = [contents componentsJoinedByString:@"\n"];
        
        ZLAlertInfoView *infoView = [self alertWithCtrl:viewController title:title content:contentStr image:image];
        infoView.textAlignment = NSTextAlignmentCenter;
        
        return infoView;
    }
    else {
        return [self alertWithCtrl:viewController title:title content:nil image:image];
    }
}

+ (instancetype)alertWithCtrl:(nullable UIViewController *)viewController
                        title:(nullable NSString *)title
                      content:(nullable NSString *)content
                        image:(nullable UIImage *)image {
    return [[ZLAlertInfoView alloc] initWithCtrl:viewController title:title contents:content image:image];
}

@end
