//
//  ZLAlertButtonView.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLAlertButtonView.h"

static CGFloat const kCellMargin = 9.f;                 // 每条内容的垂直间隔

@interface ZLInfoAlertContentCell : UITableViewCell
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIView *redPot;

@property (nonatomic) BOOL redPotHidden;

@end

static CGFloat const kRedPotSize = 6;
#define kRedPotMaxX (kRedPotSize + 6)

@implementation ZLInfoAlertContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *redPot = [UIView new];
        redPot.backgroundColor = UIColorHex(FF6F26);
        self.redPot = redPot;
        redPot.frame = CGRectMake(0, 6, kRedPotSize, kRedPotSize);
        redPot.layer.cornerRadius = redPot.frame.size.height * 0.5;
        redPot.layer.masksToBounds = YES;
        [self.contentView addSubview:redPot];
        
        
        UILabel *content = [UILabel new];
        self.content = content;
        content.textColor = UIColorHex(333333);
        content.font = [UIFont systemFontOfSize:15.f];
        content.numberOfLines = 0;
        content.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:content];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(_redPotHidden){
        self.redPot.hidden=_redPotHidden;
        self.content.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - kCellMargin); 
        
    }
    else{
        self.content.frame = CGRectMake(kRedPotMaxX, 0, self.contentView.bounds.size.width - kRedPotMaxX, self.contentView.bounds.size.height - kCellMargin);
    }
    
}

- (void)setRedPotHidden:(BOOL)redPotHidden{
    _redPotHidden=redPotHidden;
    [self layoutSubviews];
}

@end




@interface ZLAlertButtonView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel                       *titleLab;

@property (nonatomic, strong) UITableView                   *contentList;
@property (nonatomic) CGFloat                               contentListWidth;

@property (strong, nonatomic) UIImageView                   *circleViewBackground;
//@property (strong, nonatomic) UIImageView                   *headImg;

@property (nonatomic, strong) UILabel                       *subTitleLab;

@property (nonatomic, strong) NSMutableArray<NSNumber *>    *rowHeights;
@property (nonatomic, strong) NSArray<NSString *>           *contents;

@property (nonatomic, strong) UIButton                      *cancleButton;
@property (nonatomic, strong) UIButton                      *sureButton;

@property (nonatomic, copy  ) ZLAlertBaseBlock              alertCallback;

@end

static CGFloat const kCircleHeightBackground = 102.0f;   // 圆形图片
static CGFloat const kButtonIndex = 9999900;

@implementation ZLAlertButtonView

#pragma mark - Override

/**
 UIView 默认没有背景颜色 = 透明背景颜色
 */
- (void)createViews {
    [super createViews];
    
    _rowHeights = @[].mutableCopy;
    _contents = @[];
    
    // 图片
    _circleViewBackground = [[UIImageView alloc] init];
    _circleViewBackground.hidden = YES;
    _circleViewBackground.contentMode = UIViewContentModeCenter;
    [self.view insertSubview:_circleViewBackground atIndex:0];
    
    //    _headImg = [[UIImageView alloc] init];
    //    _headImg.backgroundColor = [UIColor redColor];
    //    [_circleViewBackground addSubview:_headImg];
    
    // 标题
    _titleLab = [[UILabel alloc] init];
    _titleLab.numberOfLines = 1;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.numberOfLines = 0;
    _titleLab.font = [UIFont fontWithName:kDefaultFont size:15.0f];
    _titleLab.textColor = UIColorHex(333333);
    _titleLab.hidden = YES;
    [_contentView addSubview:_titleLab];
    
    // 内容
    _contentList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_contentList registerClass:ZLInfoAlertContentCell.class forCellReuseIdentifier:NSStringFromClass(ZLInfoAlertContentCell.class)];
    _contentList.dataSource = self;
    _contentList.delegate = self;
    _contentList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentList.showsHorizontalScrollIndicator = NO;
    //    _contentList.showsVerticalScrollIndicator = NO;
    _contentList.scrollEnabled = NO;
    _contentList.hidden = YES;
    [_contentView addSubview:_contentList];
    
    // 子标题
    _subTitleLab = [[UILabel alloc] init];
    _subTitleLab.textAlignment = NSTextAlignmentCenter;
    _subTitleLab.font = [UIFont fontWithName:kDefaultFont size:15.0f];
    _subTitleLab.textColor = [UIColor lightGrayColor];
    _subTitleLab.hidden = YES;
    [_contentView addSubview:_subTitleLab];
    
    // 按钮
    _cancleButton = [self createButton];
    //   _cancleButton.backgroundColor = [UIColor whiteColor];
    [_cancleButton setBackgroundImage:[UIImage imageNamed:@"ZLAlertButtonView_Cancel_Normal"] forState:UIControlStateNormal];
    [_cancleButton setBackgroundImage:[UIImage imageNamed:@"ZLAlertButtonView_Cancel_Highlight"] forState:UIControlStateHighlighted];
    [_cancleButton setTitleColor:UIColorHex(333333) forState:0];
    _cancleButton.layer.borderColor = UIColorHex(cccccc).CGColor;
    _cancleButton.layer.borderWidth = 0.5;
    _cancleButton.tag = kButtonIndex;
    [_contentView addSubview:_cancleButton];
    
    //确定按钮
    _sureButton = [self createButton];
    //_sureButton.backgroundColor = [UIColor orangeColor];
    [_sureButton setBackgroundImage:[UIImage imageNamed:@"ZLAlertButtonView_Sure_Normal"] forState:UIControlStateNormal];
    [_sureButton setBackgroundImage:[UIImage imageNamed:@"ZLAlertButtonView_Sure_Highlight"] forState:UIControlStateHighlighted];
    [_sureButton setTitleColor:[UIColor whiteColor] forState:0];
    _sureButton.tag = 1 + kButtonIndex;
    [_contentView addSubview:_sureButton];
}

// 按钮
- (UIButton *)createButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.hidden = YES;
    [button addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 22.5f;
    button.clipsToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:15.f];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    return button;
    
}

- (void)placeViews {
    [super placeViews];
    
    // Set frames
    _circleViewBackground.frame = CGRectMake(_windowWidth * 0.5 - kCircleHeightBackground * 0.5, -kCircleHeightBackground * 0.6, kCircleHeightBackground, kCircleHeightBackground);
    //    _circleViewBackground.layer.cornerRadius = _circleViewBackground.frame.size.height / 2;
    
    UIView *preView = [[UIView alloc] initWithFrame:CGRectZero];
    // 标题
    CGRect titleLabF = CGRectZero;
    if (!_titleLab.hidden) {
        CGSize titleLabSize = [_titleLab sizeThatFits:CGSizeMake(_windowWidth - 19 * 2, CGFLOAT_MAX)];
        if (titleLabSize.width > _windowWidth - 19 * 2) {
            titleLabSize.width = _windowWidth - 19 * 2;
        }
        titleLabF = (CGRect) {
            .origin.x = (_windowWidth - titleLabSize.width) * 0.5,
            .origin.y = CGRectGetMaxY(preView.frame) + 30.f,
            .size = titleLabSize
        };
        
        preView = _titleLab;
    }
    _titleLab.frame = titleLabF;
    
    // 内容
    CGRect conentListF = CGRectZero;
    
    if (!_contentList.hidden) {
        
        const CGFloat w = _contentListWidth;
        CGFloat h = 0;
        for (NSInteger i = 0; i < self.rowHeights.count; ++i) {
            h += [[self.rowHeights objectAtIndex:i] floatValue];
        }
        
        if (h > kContentMaxHeight) {
            h = kContentMaxHeight;
            _contentList.scrollEnabled = YES;
        }
        
        conentListF = (CGRect) {
            .origin.x = (_windowWidth - w) * 0.5,
            .origin.y = CGRectGetMaxY(preView.frame) + 19.f,
            .size.width = w,
            .size.height = h,
        };
        
        preView = _contentList;
    }
    _contentList.frame = conentListF;
    [_contentList reloadData];
    
    // 子标题
    CGRect subTitleLabF = CGRectZero;
    
    if (!_subTitleLab.hidden) {
        CGSize titleLabSize = [_subTitleLab sizeThatFits:CGSizeZero];
        if (titleLabSize.width > _windowWidth - 19 * 2) {
            titleLabSize.width = _windowWidth - 19 * 2;
        }
        subTitleLabF = (CGRect) {
            .origin.x = (_windowWidth - titleLabSize.width) * 0.5,
            .origin.y = CGRectGetMaxY(preView.frame) + 8.f,
            .size = titleLabSize
        };
        preView = _subTitleLab;
    }
    
    _subTitleLab.frame = subTitleLabF;
    
    // 按钮
    CGRect leftBtnF = CGRectZero;
    CGRect rightBtnF = CGRectZero;
    
    const CGFloat margin = 10;
    const CGFloat kBtnW = (_windowWidth - 20 * 2 - margin) * 0.5;
    if (!_cancleButton.hidden && !_sureButton.hidden) {
        
        leftBtnF = (CGRect) {
            .origin.x = 20,
            .origin.y = CGRectGetMaxY(preView.frame) + 12.f,
            .size = CGSizeMake(kBtnW, 45)
        };
        
        rightBtnF = (CGRect) {
            .origin.x = CGRectGetMaxX(leftBtnF) + margin,
            .origin.y = CGRectGetMinY(leftBtnF),
            .size = leftBtnF.size
        };
    }
    else if (!_sureButton.hidden && _cancleButton.hidden) { // 显示 确定
        rightBtnF = (CGRect) {
            .origin.x = (_windowWidth - kBtnW) * 0.5,
            .origin.y = CGRectGetMaxY(preView.frame) + 12.f,
            .size = CGSizeMake(kBtnW, 45)
        };
    }
    else { // 显示 取消
        
        leftBtnF = (CGRect) {
            .origin.x = (_windowWidth - kBtnW ) * 0.5,
            .origin.y = CGRectGetMaxY(preView.frame) + 12.f,
            .size = CGSizeMake(kBtnW, 45)
        };
    }
    
    _cancleButton.frame = leftBtnF;
    _sureButton.frame = rightBtnF;
    
    const CGRect validRect = CGRectEqualToRect(leftBtnF, CGRectZero) ? rightBtnF : leftBtnF ;
    // Alert 总高度
    _windowHeight = CGRectGetMaxY(validRect) + 30.f;
    
}

#pragma mark - Event
//点击事件
- (void)actionButtonClick:(UIButton *)button {
    
    [self hideView];
    
    if (self.alertCallback) {
        self.alertCallback(button.tag - kButtonIndex);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLInfoAlertContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ZLInfoAlertContentCell.class) forIndexPath:indexPath];
    cell.content.text = [self.contents objectAtIndex:indexPath.row];
    if(self.contents.count==1){
        cell.redPotHidden=YES;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *rowh = [self.rowHeights objectAtIndex:indexPath.row];
    return [rowh floatValue];
}

- (instancetype)initWithCtrl:(UIViewController *)viewController
                       title:(nullable NSString *)title
                    subTitle:(nullable NSString *)subTitle
                   headImage:(nullable UIImage *)headImage
                     content:(nullable NSArray<NSString *> *)contents
           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
           otherButtonTitles:(nullable NSString *)otherButtonTitles
                       block:(nullable ZLAlertBaseBlock)alertBlock {
    self = [super init];
    if (self) {
        self.alertCallback = alertBlock;
        
        if (headImage) {
            _circleViewBackground.hidden = NO;
            _circleViewBackground.image = headImage;
        }
        else {
            _circleViewBackground.hidden = YES;
        }
        
        // 标题
        if (!title || title.length <= 0) {
            _titleLab.hidden = YES;
        }
        else {
            _titleLab.hidden = NO;
            _titleLab.text = title;
        }
        
        // 内容
        
        if (!contents || contents.count <= 0) {
            _contentList.hidden = YES;
        }
        else {
            _contentList.hidden = NO;
            _contents = contents;
            
            CGFloat w = _windowWidth * 0.7;
            for (NSInteger i = 0; i < _contents.count; ++i) {
                NSString *content = _contents[i];
                /**
                 需求： 每条内容 居左对齐，， 总体内容居中
                 
                 解决方案思路：
                 1.判断不换行的前提下，每条内容的长度是否大于最大宽度。如果大于最大宽度走2，不大于走3
                 2.内容的宽度就等于最大宽度，计算最大宽度前提下内容的高度，
                 3.内容的宽度就等于 最宽的一条提示的宽度。 高度计算可得到。
                 */
                // 计算宽度
                CGSize size = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.f]} context:nil].size;
                if (size.width >= w - kRedPotMaxX) {
                    CGFloat height = [content boundingRectWithSize:CGSizeMake(w - kRedPotMaxX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.f]} context:nil].size.height;
                    // 计算出来的 height 是精准的是 CGFloat 类型，但是设置UIlabel高度时会存在四舍五入等，最后存在的一点点误差使得 UILabel 显示不全，可能出现缺少一行，上下空白太多等情况；
                    // 解决方案：为了确保布局按照我们计算的数据来，可以使用ceil函数对计算的 Size 取整，再加1，确保 UILabel按照计算的高度完好的显示出来； 或者使用方法CGRectIntegral(CGRect rect) 对计算的 Rect 取整，在加1;
                    [self.rowHeights addObject:@(ceil(height) + 1.f + kCellMargin)];
                    
                    _contentListWidth = ceil(w) + 1.f;
                }
                else {
                    [self.rowHeights addObject:@(ceil(size.height) + 1.f + kCellMargin)];
                    
                    _contentListWidth = ceil(MAX(_contentListWidth, size.width + kRedPotMaxX)) + 1.f;
                }
                
            }
        }
        
        // 子标题
        if (!subTitle || subTitle.length <= 0) {
            _subTitleLab.hidden = YES;
        }
        else {
            _subTitleLab.hidden = NO;
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:subTitle attributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
            _subTitleLab.attributedText = attribtStr;
        }
        
        // 按钮
        if ((cancelButtonTitle && cancelButtonTitle.length > 0) && (otherButtonTitles && otherButtonTitles.length > 0)) {
            _cancleButton.hidden = NO;
            _sureButton.hidden = NO;
            
            [_cancleButton setTitle:cancelButtonTitle forState:0];
            [_sureButton setTitle:otherButtonTitles forState:0];
        }
        else if ((otherButtonTitles && otherButtonTitles.length > 0)) { // 显示 确定
            _cancleButton.hidden = YES;
            _sureButton.hidden = NO;
            
            [_sureButton setTitle:otherButtonTitles forState:0];
        }
        else { // 显示 取消
            _sureButton.hidden = YES;
            _cancleButton.hidden = NO;
            
            [_cancleButton setTitle:cancelButtonTitle forState:0];
        }
        
        [self alertWith:viewController];
    }
    return self;
}

#pragma mark - APIs
+ (instancetype)alertWithCtrl:(UIViewController *)viewController
                        title:(nullable NSString *)title
                     subTitle:(nullable NSString *)subTitle
                    headImage:(nullable UIImage *)headImage
                      content:(nullable NSArray<NSString *> *)contents
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
            otherButtonTitles:(nullable NSString *)otherButtonTitles
                        block:(nullable ZLAlertBaseBlock)alertBlock {
    
    return [[self alloc] initWithCtrl:viewController title:title subTitle:subTitle headImage:headImage content:contents cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles block:alertBlock];
}

@end
