//
//  ZLPickerView.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLPickerView ;

@protocol ZLPickerViewDataSource <NSObject>

@required

- (NSInteger)numberOfComponentsInPickerView:(ZLPickerView *)pickerView;

- (NSInteger)pickerView:(ZLPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end

@protocol ZLPickerViewDelegate <NSObject>

- (NSString *)pickerView:(ZLPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

- (void)pickView:(ZLPickerView *)pickerView confirmButtonClick:(UIButton *)button;

@optional
- (NSAttributedString *)pickerView:(ZLPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)componen;

- (void)pickerView:(ZLPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface ZLPickerView : UIView

@property (nonatomic, weak) id<ZLPickerViewDelegate> delegate;
@property (nonatomic, weak) id<ZLPickerViewDataSource> dataSource;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)show;
- (void)dismiss;
// 选中某一行
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
// 获取当前选中的row
- (NSInteger)selectedRowInComponent:(NSInteger)component;

//刷新某列数据
-(void)pickReloadComponent:(NSInteger)component;
//刷新数据
-(void)reloadData;

@end
