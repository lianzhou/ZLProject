//
//  IMJIETagView.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMJIETagFrame.h"
 

@protocol IMJIETagViewDelegate <NSObject>

-(void)IMJIETagView:(NSArray *)tagArray MultiControlTag:(NSInteger)MultiControlTag;

@end

@interface IMJIETagView : UIView{
    //储存选中按钮的tag
    NSMutableArray *selectedBtnList;
}
/**
 *  取消多选选择的标签
 */
-(void)CancelClick;
@property (weak, nonatomic) id<IMJIETagViewDelegate>delegate;

/** 是否能选中 需要在 IMJIETagFrame 前调用  default is YES*/
@property (assign, nonatomic) BOOL clickbool;

/** 是否能边框 需要在 IMJIETagFrame 前调用  default is YES*/
@property (assign, nonatomic) BOOL radius;

/** 未选中边框大小 需要在 IMJIETagFrame 前调用 default is 0.5*/
@property (assign, nonatomic) CGFloat borderSize;

@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) CGFloat borderColor;

/** IMJIETagFrame */
@property (nonatomic, strong) IMJIETagFrame *tagsFrame;

/** 选中背景颜色 default is whiteColor */
@property (strong, nonatomic) UIColor *clickBackgroundColor;

/** 选中字体颜色 default is TextColor */
@property (strong, nonatomic) UIColor *clickTitleColor;

/** 多选选中 default is 未选中*/
@property (strong, nonatomic) NSArray *clickArray;

/** 单选选中 default is 未选中*/
@property (strong, nonatomic) NSString *clickString;

/** 选中边框大小 default is 0.5*/
@property (assign, nonatomic) CGFloat clickborderSize;

/** 1-多选 0-单选 default is 0-单选*/
@property (assign, nonatomic) NSInteger clickStart;
/**
 *  多个控件标识
 */
@property (assign, nonatomic) NSInteger MultiControlTag;

/**
 之前选中的
 */
@property (strong, nonatomic) NSArray *selectArray;

@end
