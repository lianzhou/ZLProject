//
//  PGDatePickerHelper.m
//  Teacher
//
//  Created by ios on 2018/1/10.
//  Copyright © 2018年 zhoulian. All rights reserved.
//

#import "PGDatePickerHelper.h"
#import "NSDate+Extension.h"
@interface PGDatePickerHelper()<PGDatePickerDelegate>

@property (nonatomic, assign) int tag;

@property (nonatomic, weak) UIViewController *superViewController;

@end

@implementation PGDatePickerHelper

- (void)showPGDatePicker:(UIViewController *)superController
              titleLabel:(NSString *)titleLabel
          datePickerMode:(PGDatePickerMode)datePickerMode
                     tag:(int)tag{
    
    self.superViewController=superController;
    self.tag=tag;
    
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePickManager.titleLabel.text = titleLabel;
    
    datePickManager.titleLabel.textColor=UIColorHex(333333);
    //设置线条的颜色
    datePicker.lineBackgroundColor = UIColorHex(999999);
    //设置选中行的字体颜色
    datePicker.textColorOfSelectedRow = UIColorHex(333333);
    //设置未选中行的字体颜色
    datePicker.textColorOfOtherRow = UIColorHex(666666);
    //设置取消按钮的字体颜色
    datePickManager.cancelButtonTextColor = UIColorHex(0x36AEF6);
    //设置取消按钮的字
    datePickManager.cancelButtonText = @"取消";
    //设置取消按钮的字体大小
    datePickManager.cancelButtonFont = KDEFAULTFONT(16);
    
    //设置确定按钮的字体颜色
    datePickManager.confirmButtonTextColor = UIColorHex(0x36AEF6);
    //设置确定按钮的字
    datePickManager.confirmButtonText = @"完成";
    //设置确定按钮的字体大小
    datePickManager.confirmButtonFont =KDEFAULTFONT(16);
    
    datePicker.delegate = self;
    datePicker.datePickerMode = datePickerMode;
    
    if( self.minimumDate)
        datePicker.minimumDate = self.minimumDate;
    
    if( self.maximumDate)
        datePicker.maximumDate = self.maximumDate;
    
    if(self.nowDate)
        [datePicker setDate:_nowDate animated:false];    
    
    [datePicker setDate: [NSDate NSStringToNSDate:[NSDate DateTimeNow:kDEFAULT_DATE_FORMAT] format:kDEFAULT_DATE_FORMAT] animated:false];
    
    [self.superViewController presentViewController:datePickManager animated:false completion:nil];
}

- (void)showPGDatePicker:(UIViewController *)superController
          datePickerMode:(PGDatePickerMode)datePickerMode
                     tag:(int)tag{
    return [self showPGDatePicker:superController
                       titleLabel:@""
                   datePickerMode:datePickerMode
                              tag:tag];
}

- (void)datePicker:(PGDatePicker *)datePicker
     didSelectDate:(NSDateComponents *)dateComponents {
    self.finish(self.tag,dateComponents);
}

@end
