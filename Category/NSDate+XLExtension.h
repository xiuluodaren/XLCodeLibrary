//
//  NSDate+Extension.h
//  修罗微博
//
//  Created by xiuluo on 15/11/11.
//  Copyright © 2015年 chengde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XLExtension)

- (BOOL)isThisYear;

- (BOOL)isYesterday;

- (BOOL)isToday;

//生成当前时间戳
+ (NSInteger)getNowTimestamp;

//时间戳转时间
+ (NSDate *)timestampToDate:(NSString *)timestamp;

//时间戳转时间,带格式
+ (NSString *)timestampToDate:(NSString *)timestamp formatter:(NSString *)fmt;

@end
