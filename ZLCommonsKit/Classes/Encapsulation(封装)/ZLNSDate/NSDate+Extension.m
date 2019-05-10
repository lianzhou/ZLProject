//
//  NSDate+Extension.h
//  CoreCategory
//
//  Created by 周连 on 15/4/6.
//  Copyright (c) 2015年 周连. All rights reserved.
//

#import "NSDate+Extension.h"

@interface NSDate ()
/*
 *  清空时分秒，保留年月日
 */
@property (nonatomic,strong,readonly) NSDate *ymdDate;
@end

@implementation NSDate (Extend)


/*
 *  时间戳
 */
-(NSString *)timestamp{
    
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeInterval];
    
    return [timeString copy];
}

/*
 *  时间成分
 */
-(NSDateComponents *)components{
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    //定义成分
    NSCalendarUnit unit=NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self];
}

/*
 *  是否是今年
 */
-(BOOL)isThisYear{
    //取出给定时间的components
    NSDateComponents *dateComponents=self.components;
    //取出当前时间的components
    NSDateComponents *nowComponents=[NSDate date].components;
    //直接对比年成分是否一致即可
    BOOL res = dateComponents.year==nowComponents.year;
    return res;
}

/*
 *  是否是今天
 */
-(BOOL)isToday{
    //差值为0天
    return [self calWithValue:0];
}

/*
 *  是否是昨天
 */
-(BOOL)isYesToday{
    //差值为1天
    return [self calWithValue:1];
}


-(BOOL)calWithValue:(NSInteger)value{
    //得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents=self.ymdDate.components;
    //得到当前时间的处理后的时间的components
    NSDateComponents *nowComponents=[NSDate date].ymdDate.components;
    //比较
    BOOL res=dateComponents.year==nowComponents.year && dateComponents.month==nowComponents.month && (dateComponents.day + value)==nowComponents.day;
    return res;
}

/*
 *  清空时分秒，保留年月日
 */
-(NSDate *)ymdDate{
    //定义fmt
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    //设置格式:去除时分秒
    fmt.dateFormat=@"yyyy-MM-dd";
    //得到字符串格式的时间
    NSString *dateString=[fmt stringFromDate:self];
    //再转为date
    NSDate *date=[fmt dateFromString:dateString];
    return date;
}
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
                           fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    //直接计算
    NSDateComponents *components = [calendar components:unit fromDate:fromDate toDate:toDate options:0];
    return components;
}

/**
 时间戳到毫秒 转成
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 @param dateString <#dateString description#>
 @return <#return value description#>
 */
+ (NSString *)NSTimeSpToformateDate:(NSString *)dateString  {
    return   [NSDate  formateDate:[NSDate  NSTimeSpToNSDateString: dateString  format:kDEFAULT_DATE_TIME_FORMAT] withFormate:kDEFAULT_DATE_TIME_FORMAT];
}

#pragma mark 和当前时间比较
/**
 和当前时间比较
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 @param dateString @"yyyy-MM-dd HH:mm:ss")
 @param formate (@"yyyy-MM-dd HH:mm:ss")
 @return <#return value description#>
 */
+ (NSString *)formateDate:(NSString *)dateString
              withFormate:(NSString *) formate{
    @try{
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        /////  取当前时间和转换时间两个日期对象的时间间隔
        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = @"";
        
        if (time<=60) {  //// 1分钟以内的
            dateStr = @"刚刚";
        }else if(time<=60*60){  ////  一个小时以内的
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        }
        else if(time<=60*60*24)
        {   //// 在两天内的
            [dateFormatter setDateFormat:kDEFAULT_DATE_FORMAT];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT6];
            if ([need_yMd isEqualToString:now_yMd])
            {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
            else
            {
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }
        else
        {
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear])
            {
                ////  在同一年
                [dateFormatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT5];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
            else
            {
                [dateFormatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT3];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
}

/**
 根据日期判断星期几
 @param inputDate @"yyyy-MM-dd"
 @return 周日
 */
+ (NSString*)StringFromDateWeekday:(NSString*)inputDate{
    NSDate *_date = [ self  NSStringToNSDate :inputDate format:@"yyyy-MM-dd"];
    //    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    //    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    //    [calendar setTimeZone: timeZone];
    //    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    //    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:_date];
    //    return [weekdays objectAtIndex:theComponents.weekday];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"UTC8"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:_date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}



#pragma mark时间转时间戳的方法
+(NSString *)NSDateStringTotimeSp:(NSString *)timeStr
                           format:(NSString*)format
{
    NSDate* date = [self NSStringToNSDate:timeStr format:format];
    //时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%0.lf",  [date timeIntervalSince1970]];
    //时间戳的值
    return timeSp;
}

#pragma mark时间戳转时间的方法:
+  (NSString *)NSTimeSpToNSDateString:(NSString *)timeSp  format:(NSString*)format{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:format];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeSp.intValue];
    return  [self NSDateToDateString:confromTimesp format:format];
}

#pragma mark 比较发布时间是否大于当前时间几天 kDEFAULT_DATE_TIME_FORMAT
+ (BOOL)checkTwoDateForDays:(NSString *)Times days:(int)days
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = kDEFAULT_DATE_TIME_FORMAT;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:kLocaleIdentifier];
    
    NSDate *date = [formatter dateFromString:Times];
    NSDate *now = [NSDate date];
    //
    NSTimeInterval interval = [date timeIntervalSinceDate: now] ;
    BOOL format;
    //3天
    if (interval <= 60*60*24*days)
    {
        format=NO;
    }
    else
    {
        format=YES;
    }
    return format;
}

+ (NSString *)checkTwoDateForDays:(id)Times oldTmes:(id)date days:(int)days withFormat:(NSString *)format{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:kLocaleIdentifier];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *newDate, *oldDate;
    if ([Times isKindOfClass:[NSString class]]) {
        newDate = [NSDate dateWithTimeIntervalSince1970:[Times intValue]];
    }else{
        newDate = Times;
    }
    if ([date isKindOfClass:[NSString class]]) {
        oldDate = [NSDate dateWithTimeIntervalSince1970:[date intValue]];;
    }else oldDate = date;
    oldDate = [oldDate dateByAddingTimeInterval:interval];
    newDate = [newDate dateByAddingTimeInterval:interval];
    NSTimeInterval t = [oldDate timeIntervalSinceDate:newDate];
    if (t <= 60*60*24*days){
        df.dateFormat = kOnly_Time_Format;
    }else{
        df.dateFormat = kDEFAULT_DATE_TIME_FORMAT4;
    }
    return [df stringFromDate:newDate];
}
#pragma mark  发布时间
+  (NSString *)newsTime:(NSString *)newsTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = kDEFAULT_DATE_TIME_FORMAT2;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:kLocaleIdentifier];
    
    NSDate *date = [formatter dateFromString:newsTimes];
    NSDate *now = [NSDate date];
    
    // 比较帖子发布时间和当前时间
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    //3天
    formatter.dateFormat = [self format:interval];
    return [formatter stringFromDate:date];
}

+(NSString *)format:( NSTimeInterval) interval
{
    NSString *format;
    if (interval <= 60) {
        format = @"刚刚";
    } else if(interval <= 60*60){
        format = [NSString stringWithFormat:@"发布于前%.f分钟", interval/60];
    } else if(interval <= 60*60*24){
        format = [NSString stringWithFormat:@"发布于前%.f小时", interval/3600];
    } else if (interval <= 60*60*24*7){
        format = [NSString stringWithFormat:@"发布于前%d天", (int)interval/(60*60*24)];
    } else if (interval > 60*60*24*7 & interval <= 60*60*24*30 ){
        format = [NSString stringWithFormat:@"发布于前%d周", (int)interval/(60*60*24*7)];
    }else if(interval > 60*60*24*30 ){
        format = [NSString stringWithFormat:@"发布于前%d月", (int)interval/(60*60*24*30)];
    }
    return format;
}


#pragma mark 信息时间
+ (NSString *)NSNewsTimeToString:(NSString *)newsString
{
    NSString*newsTimes=@"";
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[newsString floatValue]];
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSDate *nowDate = [NSDate date];
    NSDate *currentDate = [dateFormat dateFromString:[dateFormat stringFromDate:nowDate]];
    NSDate *senderDate = [dateFormat dateFromString:[dateFormat stringFromDate:date]];
    NSTimeInterval timesBetweenEndAndStart = [currentDate timeIntervalSinceDate:senderDate];
    if (timesBetweenEndAndStart==0) {
        NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm"];
        NSString *regStr = [dateFormat stringFromDate:date];
        newsTimes = regStr;
    }else if(timesBetweenEndAndStart/(3600*24) == 1){
        newsTimes = @"昨天";
    }else if (timesBetweenEndAndStart/(3600*24) == 2){
        newsTimes = @"前天";
    }else{
        NSString *regStr = [dateFormat stringFromDate:date];
        newsTimes = regStr;
    }
    return  newsTimes;
}

#pragma mark 比较两个日期大小 fromDate 选择的时间 旧 toDate 要比较的时间
+ (BOOL)checkTwoDate:(NSDate *)fromDate toDate:(NSDate*)toDate
{
    BOOL isFirstBig=YES;
    NSDate *r = [fromDate laterDate:toDate];
    if([fromDate isEqualToDate:toDate]) {
        isFirstBig=YES;
        NSLog(@"日期相同");
    }
    else
    {
        if([r isEqualToDate:toDate])
        {
            isFirstBig=NO; //toDate 大
        }
        else
        {
            isFirstBig=YES;
        }
    }
    return isFirstBig;
}

#pragma mark 比较两个日期大小,如果相等，返回yes
+ (BOOL)checkTwoDateIsEqual:(NSString *)fromDate toDate:(NSString*)toDate
{
    NSDate *fromTime = [self DateStringToNSDate:[self NSDateTimeToDateString:fromDate]];
    NSDate *toTime = [self DateStringToNSDate:[self NSDateTimeToDateString:toDate]];
    if([fromTime isEqualToDate:toTime]) {
        return YES;
    }
    return NO;
}

#pragma mark  是否时间
+(BOOL) iSDate:(NSString *)string
{  //String to Date
    @try
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
        [formatter setDateFormat:kDEFAULT_DATE_FORMAT];
        NSDate * date = [formatter dateFromString:string];
        
        if(date==nil)
            return NO;
        else
            return YES;
    }
    @catch(NSException *exception) {
        return NO;
    }
    @finally {
    }
}

#pragma mark date time字符串转换成NSDate
+ (NSDate *)NSStringToNSDate:(NSString *)string
{
    //Fomat
    string = [string stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

#pragma mark NSDate转换成date time字符串
+ (NSString *)NSDateToNSString:(NSDate *)date format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:format];
    NSString *string = [formatter stringFromDate:date];
    return string;
}
#pragma mark NSDate转换成date time字符串
+ (NSString *)NSDateToTimeNSString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:kOnly_Time_Format];
    NSString *string = [formatter stringFromDate:date];
    return string;
}


#pragma mark NSDate转换成date字符串
+ (NSString *)NSDateToDateString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:kDEFAULT_DATE_FORMAT];
    NSString *string = [formatter stringFromDate:date];
    
    return string;
}

+ (NSString *)NSDateToDateString:(NSDate *)date  format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:format];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

#pragma mark 时间字符串转日期
+ (NSString *)NSDateTimeToDateString:(NSString *)datetime
{
    if ([datetime length]>10)
    {
        NSDate *_date = [self NSStringToNSDate:datetime];
        return [self NSDateToDateString:_date];
    }
    else
        return datetime;
}

#pragma mark 时间字符串格式化为标准格式
+ (NSString *)NSDateTimeFormatString:(NSString *)datetime
{
    if ([datetime length]>10)
    {
        NSDate *_date = [self NSStringToNSDate:datetime];
        return [self NSDateToNSString:_date  format:kDEFAULT_DATE_TIME_FORMAT];
    }
    else
    {
        return [datetime stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    }
}

#pragma markNSDate计算年龄
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    return iAge;
}


#pragma mark 时间字符去掉秒
+ (NSString *)NSDateHourFormatString:(NSString *)datetime
{
    NSDate *_date = [self NSStringToNSDate:datetime];
    return [self NSDateToFormatString:_date format:kDEFAULT_DATE_TIME_FORMAT3];
}

#pragma mark NSDate转换成day字符串
+ (NSString *)NSDateToOnlyDayString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:kOnly_Day_Format];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

#pragma mark NSDate转换成指定格式的字符串
+ (NSString *)NSDateToFormatString:(NSDate *)date format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:format];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

#pragma mark 时间字符转换成指定格式的字符串
+ (NSString *)NSDateStringToFormatString:(NSString *)datetime  format:(NSString*)format {
    NSDate *_date = [self NSStringToNSDate:datetime format:@"yyyy-MM-dd" ];
    return [self NSDateToFormatString:_date format:format];
}

+ (NSString *)NSDateStringToFormatString:(NSString *)datetime
                               oldformat:(NSString*)oldformat
                                  format:(NSString*)format{
    NSDate *_date = [self NSStringToNSDate:datetime format:oldformat ];
    return [self NSDateToFormatString:_date format:format];
}



#pragma mark date字符串转换成NSDate
+ (NSDate *)DateStringToNSDate:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:kDEFAULT_DATE_FORMAT];
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

#pragma mark NSString字符串转换成NSDate
+ (NSDate *)DateStringToFormatDate:(NSString *)string format:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

#pragma mark  当前日期时间
+(NSString *) DateTimeNow:(NSString*)format{
    return [self NSDateToNSString:[NSDate date] format:format] ;
}

#pragma mark 获取系统当前的时间戳
+(NSString *) DateTimeNowTimeInterval{
    NSString *strdate=[self DateTimeNow:kDEFAULT_DATE_TIME_FORMAT];
    return [self NSDateStringTotimeSp:strdate  format:kDEFAULT_DATE_TIME_FORMAT];
}

#pragma mark 获取系统当前的 + 天数

+(NSString *) DateTimeNowAddDay:(NSString*)format day:(int)day{
    
    //1天时间
    NSTimeInterval tday = 60 * 60 * 24 ;
    
    NSDate *mydate = [NSDate dateWithTimeIntervalSinceNow:+tday*day];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:mydate];
    
    NSLog(@"---时间的字符串 =%@",currentDateStr);
    
    return currentDateStr;
}


#pragma mark  当前日期时间从0点开始  00:00:00
+(NSString *) getCurrDateTimeNow{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [formatter stringFromDate:[NSDate date]];
    return string;
}

/**
 开始时间到当前时间差
 
 @param string 2018-01-15 17:03:34
 @param format 格式
 @return <#return value description#>
 */
+(NSTimeInterval)NSTimeSpToInterval:(NSString *)string
                             format:(NSString*)format{
    NSTimeInterval timesBetweenEndAndStart = [self  NSTimeSpToInterval: [self NSDateStringTotimeSp: [self DateTimeNow:format] format:format] endTimeSp :string format:format];
    return timesBetweenEndAndStart;
}

#pragma mark   时间到计时 结束时间戳到当前时间戳之间的差 时间戳
/**
 <#Description#>
 
 @param sendstring 开始时间 2018-01-15 16:56:27
 @param endstring 结束时间  2018-01-15 17:56:27
 @param format   时间戳格式
 @return 差值
 */
+(NSTimeInterval)NSTimeToInterval:(NSString *)sendstring
                       endstring :(NSString *)endstring
                           format:(NSString*)format{
    return [self NSTimeSpToInterval:[self NSDateStringTotimeSp:sendstring format:format] endTimeSp:[self NSDateStringTotimeSp:endstring format:format] format:format];
}


/**
 @param starTimeSp 开始时间戳
 @param endTimeSp 结束时间戳
 @param format  时间戳格式
 @return <#return value description#>
 */
+(NSTimeInterval)NSTimeSpToInterval:(NSString *)starTimeSp
                         endTimeSp :(NSString *)endTimeSp
                             format:(NSString*)format{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [dateFormatter setDateFormat:format];
    
 
    NSDate *senderDate = [NSDate dateWithTimeIntervalSince1970: [self timeIntervalString:starTimeSp].floatValue];
    
    NSDate* enderDate = [NSDate dateWithTimeIntervalSince1970: [self timeIntervalString:endTimeSp].floatValue];
    
    NSDate* finanlDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:enderDate]];
    
    NSTimeInterval timesBetweenEndAndStart = [finanlDate timeIntervalSinceDate:senderDate];
    
    return timesBetweenEndAndStart;
}

//截取字符串.0
+ (NSString *)timeIntervalString:(NSString *)timeStr
{
    if (timeStr) {
        if (timeStr.length >= 13) {
            return [timeStr substringToIndex:10];
        }
        return timeStr;
    }else{
        return @"";
    }
}



#pragma mark date time字符串转换成NSDate
+ (NSDate *)NSStringToNSDate:(NSString *)string
                      format:(NSString*)format {
    //Fomat
    string = [string stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC8"]];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}


/**
 获取月份开始到结束
 
 @param newTime "yyyy-MM-dd"
 @return @"beginString" @"endString";
 */
+ (NSMutableDictionary *)getMonthBeginAndEndWith:(NSString *)newTime{
    NSDate * newDate  =[NSDate DateStringToNSDate:newTime];
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:kCFCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 kCFCalendarUnitDay NSWeekCalendarUnit kCFCalendarUnitYear
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:beginString forKey:@"beginString"];
    [dic setObject:endString forKey:@"endString"];
    
    return   dic;
}


/**
 近一周
 
 @return @"beginString" @"endString";
 */
+ (NSMutableDictionary * )getNearlyWeek {
    NSTimeInterval secondsPerDay = (60*60*24*7);
    NSDate * today = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //得到当前的时间
    NSString *endString = [myDateFormatter stringFromDate:[NSDate date]];
    // ZLLog(@"---当前的时间的字符串 =%@",endString);
    
    NSString *beginString = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:1- secondsPerDay]];
    // NSLog(@"---一周前的时间的字符串%@:",beginString);
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:beginString forKey:@"beginString"];
    [dic setObject:endString forKey:@"endString"];
    
    return   dic;
}

//获取当前日期最近一周的时间.@"beginString" @"endString";
+ (NSMutableDictionary *)getWeekBeginAndEnd {
    //获取当前周的开始和结束日期
    int currentWeek = 0;
    NSDate * newDate = [NSDate date];
    NSTimeInterval secondsPerDay1 = 24 * 60 * 60 * (abs(currentWeek)*7);
    if (currentWeek > 0){
        newDate = [newDate dateByAddingTimeInterval:+secondsPerDay1];//目标时间
    }else{
        newDate = [newDate dateByAddingTimeInterval:-secondsPerDay1];//目标时间
    }
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval - 1];
    }else {
        return  nil;
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:beginString forKey:@"beginString"];
    [dic setObject:endString forKey:@"endString"];
    
    return   dic;
}





/**
 @param month 1 一月
 @param format @""
 @param isnow 是否包括今天
 @return @"beginString" @"endString";
 */
+ (NSMutableDictionary *)getMonthBeginAndEnd:(int)month
                                      format:(NSString *)format  isnow:(BOOL)isnow {
    
    //得到当前的时间
    NSTimeInterval day = 60 * 60 * 24 ;
    if(isnow)  {
        day=0;
    }
    NSDate *mydate = [NSDate dateWithTimeIntervalSinceNow:-day];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:mydate ];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-month];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    
    NSLog(@"---beginString =%@",beforDate);
    NSLog(@"---endString   =%@",currentDateStr);
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:beforDate forKey:@"beginString"];
    [dic setObject:currentDateStr forKey:@"endString"];
    
    return   dic;
}

//计算天数后的新日期
+ (NSString *)computeDateAddDays:(NSString*)date  days:(NSInteger) days{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [dateFormatter dateFromString:date];
    
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * days];
    NSLog(@"计算天数后的新日期 %s %@", __FUNCTION__, [dateFormatter stringFromDate:newDate]);
    return [dateFormatter stringFromDate:newDate];
}

// 判断是否是同一月
+ (BOOL)isSameMonth:(NSString *)time1
              date2:(NSString *)time2{
    NSDate *date1=[NSDate NSStringToNSDate:time1 format:kDEFAULT_DATE_FORMAT];
    NSDate *date2=[NSDate NSStringToNSDate:time2 format:kDEFAULT_DATE_FORMAT];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    //   return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
    return (([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}


#pragma - mark - 6.判断一个月有多少天

/**
 判断一个月有多少天
 @return 天数
 */
+(NSInteger)getMonthTeger:(NSString*)date {
    //NSDateFormatter *dateFormatter = [NSDateFormatter new];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate *myDate = [dateFormatter dateFromString:date];
    
    //    if (myDate.month == 4 || myDate.month == 6 || myDate.month == 9 || myDate.month == 11 ){
    //        return 30;
    //    }
    //    else if (myDate.month == 2)
    //    {
    //        if(((myDate.year %4==0)&&(myDate.year %100!=0))||(myDate.year %400==0)){
    //            return 29;
    //        }
    //        else{
    //            return 28;
    //        }
    //    }
    //    else{
    //        return 31;
    //    }
    return 31;
}

/**
 -1 截止日期大于当天日期
 -2 起始日期大于截止日期
 1起始日期与截止日期间隔不能大于3个月
 0起始日期与截止日期间隔大于3个月
 
 @param beginDate NSDate
 @param endDate NSDate
 @return NSInteger
 */
+(NSInteger)checkDateBeginDate:(NSDate *)beginDate
                       endDate:(NSDate *)endDate {
    /**
     NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:beginDate];
     NSInteger days = timeInterval/(3600*24);
     NSLog(@"----days:----%ld",days);
     **/
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    
    //截止日期大于当天日期
    if ([endDate compare:currentDate] != NSOrderedAscending) {
        return -1;
    }
    
    //起始日期大于截止日期
    if ([beginDate compare:endDate] == NSOrderedDescending) {
        return -2;
    }
    
    //起始日期与截止日期间隔不能大于3个月
    if ([[beginDate dateByAddingTimeInterval:3*30*24*60*60] compare:endDate] == NSOrderedDescending) {
        return 1;
    }
    //起始日期与截止日期间隔大于3个月
    return 0;
}

/////////////////////////////不包括当天
+ (NSMutableArray *)getDatelist:(int)days
                         format:(NSString *)format
                            row:(int)row {
    //得到当前的时间
    NSDate * mydate = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"---当前的时间的字符串 =%@",currentDateStr);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    int drows=7;//默认显示几个
    
    if(row){
        drows=row;
    }
    
    int yday= 3;//时间间隔天数
    
    if(days) {
        
        yday=days/row;
    }
    
    NSMutableArray *list=[@[] mutableCopy];
    
    for(int i = 0; i <row; i ++ ) {
        
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        [adcomps setYear:0];
        [adcomps setMonth:0];
        [adcomps setDay:-yday*i-1];
        
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
        NSString *beforDate = [dateFormatter stringFromDate:newdate];
        NSLog(@"---日期  =%@",beforDate);
        [list addObject:beforDate];
    }
    
    [list sortUsingSelector:@selector(compare:)];
    return   list;
}

+ (NSMutableDictionary *)getDayBeginAndEnd:(int)day
                                    format:(NSString *)format
                                     isnow:(BOOL)isnow{
    //得到当前的时间
    NSTimeInterval tday = 60 * 60 * 24 ;
    if(isnow){
        tday=0;
    }
    
    NSDate *mydate = [NSDate dateWithTimeIntervalSinceNow:-tday];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:mydate];
    
    NSLog(@"---当前的时间的字符串 =%@",currentDateStr);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    if(isnow){
        [adcomps setDay:-day-1];
    }
    else {
        [adcomps setDay:-day-2];
    }
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    
    NSLog(@"---beginString 月 =%@",beforDate);
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:beforDate forKey:@"beginString"];
    [dic setObject:currentDateStr forKey:@"endString"];
    
    return   dic;
}

@end

