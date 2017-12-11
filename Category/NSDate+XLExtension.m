//
//  NSDate+Extension.m
//  修罗微博
//
//  Created by xiuluo on 15/11/11.
//  Copyright © 2015年 chengde. All rights reserved.
//

#import "NSDate+XLExtension.h"

@implementation NSDate (XLExtension)

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year = nowCmps.year;
}

- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;

}

- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

//生成当前时间戳
+ (NSInteger)getNowTimestamp
{
    NSDate *datenow = [NSDate date];//现在时间
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    
//    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    
    return timeSp;
}

//时间戳转时间
+ (NSDate *)timestampToDate:(NSString *)timestamp
{
    NSTimeInterval interval = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    return date;
}

//时间戳转时间,带格式
+ (NSString *)timestampToDate:(NSString *)timestamp formatter:(NSString *)fmt
{
    NSTimeInterval interval = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = fmt;

    return [formatter stringFromDate:date];

}

@end
