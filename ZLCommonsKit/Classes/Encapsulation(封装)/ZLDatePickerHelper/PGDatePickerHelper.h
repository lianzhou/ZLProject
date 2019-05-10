//
//  PGDatePickerHelper.h
//  Teacher
//
//  Created by ios on 2018/1/10.
//  Copyright © 2018年 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGDatePickManager.h"
/*

-(PGDatePickerHelper *)pickerHelper{
    if(!_pickerHelper){
        _pickerHelper = [[PGDatePickerHelper alloc] init];
        WS(weakSelf);
        _pickerHelper.finish = ^(int tag,NSDateComponents *dateComponents){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTime:tag dateComponents:dateComponents];
            });
        };
        
        _pickerHelper.minimumDate = [NSDate NSStringToNSDate:@"2018-01-01" format:kDEFAULT_DATE_FORMAT];
        
        _pickerHelper.maximumDate = [NSDate NSStringToNSDate:[NSDate DateTimeNow:kDEFAULT_DATE_FORMAT] format:kDEFAULT_DATE_FORMAT];
        
        _pickerHelper.nowDate=[NSDate NSStringToNSDate:[NSDate DateTimeNow:kDEFAULT_DATE_FORMAT] format:kDEFAULT_DATE_FORMAT];
        
    }
    return  _pickerHelper;
}

*/

@interface PGDatePickerHelper : NSObject

/** 完成后返回 时间 */
@property (nonatomic, copy) void(^finish)(int tag, NSDateComponents *dateComponents );

/** 最小时间 */
@property (nonatomic, strong) NSDate *minimumDate;

/**最大时间 */
@property (nonatomic, strong) NSDate *maximumDate;

/**当前时间 */

@property (nonatomic, strong) NSDate *nowDate;

- (void)showPGDatePicker:(UIViewController *)superController
              titleLabel:(NSString *)titleLabel
          datePickerMode:(PGDatePickerMode)datePickerMode
                     tag:(int)tag;

- (void)showPGDatePicker:(UIViewController *)superController
          datePickerMode:(PGDatePickerMode)datePickerMode
                     tag:(int)tag;

@end
