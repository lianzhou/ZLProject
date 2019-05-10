//
//  ZLCouponAlertView.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "ZLCouponAlertView.h"

@interface ZLCouponAlertView()

@property(nonatomic ,strong) UIImageView *bkImageView;

@property(nonatomic ,strong) UILabel *titleLabel;

@property(nonatomic ,strong) UILabel *descLabel;

@property(nonatomic ,strong) UIButton *goNextBtn;

@end


@implementation ZLCouponAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)createViews {
    self.bkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xhp_coupon_bkimage"]];
    [self addSubview:self.bkImageView];
    [self.bkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = UIColorHex(0xffffff);
    self.titleLabel.font = KDEFAULTFONT(16);
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(25);
        make.top.mas_equalTo(self.mas_top).mas_offset(19);
        make.size.mas_equalTo(CGSizeMake(130, 16));
    }];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.textColor = UIColorHex(0xffffff);
    self.descLabel.font = KDEFAULTFONT(12);
    [self addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(130, 12));
    }];

    self.goNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goNextBtn.backgroundColor = UIColorHex(0xffffff);
    [self.goNextBtn setTitleColor:UIColorHex(0xFF6036) forState:UIControlStateNormal];
    self.goNextBtn.layer.cornerRadius = 12;
    self.goNextBtn.titleLabel.font = KDEFAULTFONT(11);
    [self.goNextBtn addTarget:self action:@selector(goNextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.goNextBtn];
    [self.goNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(63, 24));
    }];
}
- (void)goNextBtnClick {
    if (self.customViewClick) {
        self.customViewClick(self, 0);
    }
}

//设置标题
- (void)couponTitle:(NSString *)couponTitle {
    self.titleLabel.text = ZLIFISNULL(couponTitle);
}

- (void)couponDesc:(NSString *)couponDesc {
    self.descLabel.text = ZLIFISNULL(couponDesc);
}

- (void)couponBtnTitle:(NSString *)couponBtnTitle {
    [self.goNextBtn setTitle:ZLIFISNULL(couponBtnTitle) forState:UIControlStateNormal];
}
@end
