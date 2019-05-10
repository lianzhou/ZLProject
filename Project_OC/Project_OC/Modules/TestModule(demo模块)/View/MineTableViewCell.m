//
//  MineTableViewCell.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell()

//默认间距
#define KNormalSpace 12.0f

@property (nonatomic, strong) UIImageView *titleIcon;//标题图标
@property (nonatomic, strong) UILabel *titleLbl;//标题
@property (nonatomic, strong) UILabel *detaileLbl;//内容
@property (nonatomic, strong) UIImageView *arrowIcon;//右箭头图标

@end

@implementation MineTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setCellData:(NSDictionary *)cellData{
    _cellData = cellData;
    if (cellData) {
        if (cellData[@"title_icon"]) {
            [self.titleIcon setImage:ZL_ImageWithFile(cellData[@"title_icon"])];
            [_titleIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(KNormalSpace);
                make.centerY.mas_equalTo(self);
                make.width.height.mas_equalTo(17);
            }];
        }else{
            [self.titleIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.width.height.mas_equalTo(0);
            }];
        }
        
        if (cellData[@"titleText"]) {
            self.titleLbl.text = cellData[@"titleText"];
        }
        
        if (cellData[@"detailText"]) {
            self.detaileLbl.text = cellData[@"detailText"];
            [_detaileLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLbl.mas_right).offset(10);
                make.centerY.mas_equalTo(self);
                make.right.mas_equalTo(self.arrowIcon.mas_left).offset(- 10);
            }];
        }else{
            [_detaileLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLbl.mas_right).offset(0);
                make.centerY.mas_equalTo(self);
                make.right.mas_equalTo(self.arrowIcon.mas_left).offset(0);
            }];
        }
        if (cellData[@"arrow_icon"]) {
            [self.arrowIcon setImage:ZL_ImageWithFile(cellData[@"arrow_icon"])];
            [_arrowIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-KNormalSpace);
                make.top.mas_equalTo(KNormalSpace);
                make.width.height.mas_equalTo(22);
                make.centerY.mas_equalTo(self);
            }];
            
        }else{
            [_arrowIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(KNormalSpace);
                make.width.height.mas_equalTo(0);
                make.centerY.mas_equalTo(self);
            }];
        }
    }
}

-(UIImageView *)titleIcon{
    if (!_titleIcon) {
        _titleIcon = [UIImageView new];
        [self addSubview:_titleIcon];
        [_titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(KNormalSpace);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(0);
        }];
    }
    return _titleIcon;
}
-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.font = KDEFAULTFONT(15);
        _titleLbl.textColor = KBlackColor;
        [self addSubview:_titleLbl];
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleIcon.mas_right).offset(10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _titleLbl;
}

-(UILabel *)detaileLbl{
    if (!_detaileLbl) {
        _detaileLbl = [UILabel new];
        _detaileLbl.font = KDEFAULTFONT(12);
        _detaileLbl.textColor = KGrayColor;
        _detaileLbl.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detaileLbl];
        
        [_detaileLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->_titleLbl.mas_right).offset(10);
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.arrowIcon.mas_left).offset(- 10);
        }];
    }
    return _detaileLbl;
}

-(UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [UIImageView new];
        [self addSubview:_arrowIcon];
        
        [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-KNormalSpace);
            make.top.mas_equalTo(KNormalSpace);
            make.width.height.mas_equalTo(22);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _arrowIcon;
}

@end
