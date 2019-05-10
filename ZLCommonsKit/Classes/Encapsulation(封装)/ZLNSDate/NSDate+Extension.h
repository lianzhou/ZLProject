//
//  NSDate+Extension.h
//  CoreCategory
//
//  Created by 周连 on 15/4/6.
//  Copyright (c) 2015年 周连. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (Extension)

#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm:ss")
#define kDEFAULT_DATE_TIME_FORMAT2 (@"yyyyMMddHHmmss")   //时间格式2
#define kDEFAULT_DATE_TIME_FORMAT3 (@"yyyy-MM-dd HH:mm")   //时间格式3

#define kDEFAULT_DATE_TIME_FORMAT33 (@"yyyy-MM-dd HH")   //时间格式3
#define kDEFAULT_DATE_TIME_FORMAT4 (@"MM-dd")   //时间格式6
#define kDEFAULT_DATE_TIME_FORMAT5 (@"MM-dd HH:mm")   //时间格式4
#define kDEFAULT_DATE_TIME_FORMAT6 (@"HH:mm")   //时间格式10
#define kDEFAULT_DATE_TIME_FORMAT7 (@"yyyy年MM月")   //时间格式5
#define kDEFAULT_DATE_TIME_FORMAT8 (@"yyyy年MM月dd日")   //时间格式8
#define kDEFAULT_DATE_TIME_FORMAT9 (@"MM月dd日HH时mm分")   //时间格式9
#define kDEFAULT_DATE_TIME_FORMAT10 (@"HH时mm分")   //时间格式10
#define kDEFAULT_DATE_TIME_FORMAT11 (@"MM月dd日")   //时间格式11

#define kDEFAULT_DATE_FORMAT (@"yyyy-MM-dd")
#define kDEFAULT_DATE_FORMAT1 (@"yyyy/MM/dd")
#define kDEFAULT_DATE_FORMAT2 (@"yyyyMMdd")
#define kDEFAULT_DATE_VALUE  @"1900-01-01 00:00:00"  //系统最初时间
#define kOnly_Year_Format (@"yyyy")
#define kOnly_Month_Format (@"MM")
#define kOnly_Day_Format (@"dd")
#define kOnly_Time_Format (@"HH:mm")
#define kLocaleIdentifier @"en_US"
/*
 *  时间戳
 */
@property (nonatomic,copy,readonly) NSString *timestamp;

/*
 *  时间成分
 */
@property (nonatomic,strong,readonly) NSDateComponents *components;

/*
 *  是否是今年
 */
@property (nonatomic,assign,readonly) BOOL isThisYear;

/*
 *  是否是今天
 */
@property (nonatomic,assign,readonly) BOOL isToday;

/*
 *  是否是昨天
 */
@property (nonatomic,assign,readonly) BOOL isYesToday;

/**
 根据日期判断星期几
 @param inputDate @"yyyy-MM-dd"
 @return 周日
 */
+ (NSString*)StringFromDateWeekday:(NSString*)inputDate;

/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit
                           fromDate:(NSDate *)fromDate
                             toDate:(NSDate *)toDate;


/**
 NSDate计算年龄
 */

+ (NSInteger)ageWithDateOfBirth:(NSDate *)date;

/**
 时间戳  转成
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 
 @param dateString <#dateString description#>
 @return <#return value description#>
 */
+ (NSString *)NSTimeSpToformateDate:(NSString *)dateString;


/**
 和当前时间比较
 /////  和当前时间比较
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 **/

+ (NSString *)formateDate:(NSString *)dateString
              withFormate:(NSString *) formate;

/**
 时间转时间戳的方法
 
 @param timeStr <#timeStr description#>
 @param format <#format description#>
 
 */
+(NSString *)NSDateStringTotimeSp:(NSString *)timeStr
                           format:(NSString*)format;

/**
 时间戳转时间的方法:
 
 @param timeSp <#timeSp description#>
 @param format <#format description#>
 
 */
+(NSString *)NSTimeSpToNSDateString:(NSString *)timeSp
                             format:(NSString*)format;


/**
 比较发布时间是否大于当前时间几天
 
 @param Times <#Times description#>
 @param days <#days description#>
 
 */
+ (BOOL)checkTwoDateForDays:(NSString *)Times
                       days:(int)days;

/**
 比较两个时间差几天
 
 @param Times <#Times description#>
 @param date <#date description#>
 @param days <#days description#>
 @param format <#format description#>
 
 */
+ (NSString *)checkTwoDateForDays:(id)Times
                          oldTmes:(id)date
                             days:(int)days
                       withFormat:(NSString *)format;

/**发布时间 yyyy/MM/ddHH:mm */
+  (NSString *)newsTime:(NSString *)newsTimes;

/**信息时间  yyyy/MM/ddHH:mm*/
+ (NSString *)NSNewsTimeToString:(NSString *)newsString;

/** NSString time字符串转换成NSDate */
+ (NSDate *)NSStringToNSDate:(NSString *)string;


/**  string time字符串转换成NSDate  format */
+ (NSDate *)NSStringToNSDate:(NSString *)string
                      format:(NSString*)format;

/** 时间字符转换成指定格式的字符串 datetime "yyyy-MM-dd"*/
+ (NSString *)NSDateStringToFormatString:(NSString *)datetime
                                  format:(NSString*)format;
/** 时间字符串格式化为标准格式 */
+ (NSString *)NSDateTimeFormatString:(NSString *)datetime;

/** NSDate转换成date time字符串 */
+ (NSString *)NSDateToNSString:(NSDate *)date
                        format:(NSString*)format;

/**时间字符串转日期*/
+ (NSString *)NSDateTimeToDateString:(NSString *)datetime;

/** NSDate转换成date字符串 */
+ (NSString *)NSDateToDateString:(NSDate *)date;

/**
 date字符串转换成NSDate  */
+ (NSDate *)DateStringToNSDate:(NSString *)string;

/**
 时间字符去掉秒
 @param date <#date description#>
 
 */
+ (NSString *)NSDateToOnlyDayString:(NSDate *)date;

+ (NSString *)NSDateHourFormatString:(NSString *)datetime;

+ (NSString *)NSDateToTimeNSString:(NSDate *)date;

/**
 NSDate转换成指定格式的字符串
 
 @param date <#date description#>
 @param format <#format description#>
 
 */
+ (NSString *)NSDateToFormatString:(NSDate *)date
                            format:(NSString*)format;

/**
 NSString字符串转换成NSDate
 @param string <#string description#>
 @param format <#format description#>
 
 */
+ (NSDate *)DateStringToFormatDate:(NSString *)string
                            format:(NSString*)format;

/**
 当前日期时间  format */
+ (NSString *) DateTimeNow:(NSString*)format;


/** 获取系统当前的时间戳*/
+(NSString *) DateTimeNowTimeInterval;


#pragma mark 获取系统当前的 + 天数

+(NSString *) DateTimeNowAddDay:(NSString*)format day:(int)day;
/**
 结束时间戳到当前时间戳之间的差 时间戳
 @param sendstring 开始时间
 @param endstring 结束时间
 @param format   时间戳格式 2018-01-15 16:56:27
 @return 差值
 */
+(NSTimeInterval)NSTimeToInterval:(NSString *)sendstring
                       endstring :(NSString *)endstring
                           format:(NSString*)format;

/**
 @param starTimeSp 开始时间戳
 @param endTimeSp 结束时间戳
 @param format  时间戳格式
 @return <#return value description#>
 */
+(NSTimeInterval)NSTimeSpToInterval:(NSString *)starTimeSp
                         endTimeSp :(NSString *)endTimeSp
                             format:(NSString*)format;

+ (NSString *)NSDateStringToFormatString:(NSString *)datetime
                               oldformat:(NSString*)oldformat
                                  format:(NSString*)format;
/**当前日期时间从0点开始*/
+(NSString *) getCurrDateTimeNow;

/**是否时间*/
+(BOOL) iSDate:(NSString *)string;


/** 比较两个日期大小*/
+ (BOOL)checkTwoDate:(NSDate *)fromDate
              toDate:(NSDate*)toDate;

+ (BOOL)checkTwoDateIsEqual:(NSString *)fromDate
                     toDate:(NSString*)toDate;
/**
 获取月份开始到结束
 
 @param newTime "yyyy-MM-dd"
 @return @"beginString" @"endString";
 */
+ (NSMutableDictionary *)getMonthBeginAndEndWith:(NSString *)newTime;

/**
 近一周
 
 @return @"beginString" @"endString";
 */
+ (NSMutableDictionary * )getNearlyWeek;

//获取当前日期最近一周的时间.@"beginString" @"endString";
+ (NSMutableDictionary *)getWeekBeginAndEnd;



/**
 @param month 1 一月
 @param format @""
 @param isnow 是否包括今天
 @return @"beginString" @"endString";
 */
+ (NSMutableDictionary *)getMonthBeginAndEnd:(int)month
                                      format:(NSString *)format  isnow:(BOOL)isnow ;
/**
 计算天数后的新日期
 
 @param date yyyy-MM-dd
 @param days 1
 @return yyyy-MM-dd
 */
+ (NSString *)computeDateAddDays:(NSString*)date
                            days:(NSInteger) days;

// 判断是否是同一月
+ (BOOL)isSameMonth:(NSString *)time1
              date2:(NSString *)time2;

/**
 判断一个月有多少天
 @return 天数
 */
+(NSInteger)getMonthTeger:(NSString*)date;


/**
 -1 截止日期大于当天日期
 -2 起始日期大于截止日期
 1起始日期与截止日期间隔不能大于3个月
 0起始日期与截止日期间隔大于3个月
 
 @param beginDate NSDate
 @param endDate NSDate
 @return NSInteger
 */
+(NSInteger)checkDateBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate ;

/**金融不包括今天*/
+ (NSMutableArray *)getDatelist:(int)days format:(NSString *)format  row:(int)row;

+ (NSMutableDictionary *)getDayBeginAndEnd:(int)day
                                    format:(NSString *)format isnow:(BOOL)isnow
;
@end
