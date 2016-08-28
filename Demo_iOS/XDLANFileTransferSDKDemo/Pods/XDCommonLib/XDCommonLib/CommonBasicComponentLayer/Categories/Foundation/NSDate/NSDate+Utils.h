//
//  NSDate+Utils.h
//  CoreFramework
//
//  Created by Su XinDE on 14-3-10.
//  Copyright (c) 2014年 Su XinDE. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
	@brief 日期工具类。该类为NSDate类Category，提供一些时间日期操作的工具方法。
 */
@interface NSDate (Utils)

/**
	获取当前时间，以固定格式字符串返回
	@returns 返回当前手机时间的字符串
 */
+ (NSString*)getCurrentTime;


// 按给定格式获取当前时间
// format 格式形如：@"yyyyMMdd hh:mm:ss:SSS"
/**
	获取当前时间，按给定格式返回时间字符串信息
	@param format 日期字符串的格式
	@returns 返回当前手机时间的字符串
 */
+ (NSString*)getCurrentTimeByFormat:(NSString *)format;

// 比较跟另一个Date是否是同一天
/**
	比较跟另一个Date是否是同一天
	@param anotherDate 要进行比较的NSDate对象
    @returns 
             FALSE	跟比较日期不是同一天
             TRUE	跟比较日期是同一天
 */
- (BOOL)isSameDay:(NSDate*)anotherDate;

/**
	判断该Date是否是今天
	@returns 
             FALSE	该日期不是今天
             TRUE	该日期是今天
 */
- (BOOL)isToday;


/**
	通过两个Date对象拼凑出新的Date
	@param aDate 提供日期部分的NSDate对象
	@param aTime 提供时间部分的NSDate对象
	@returns 返回两个对象拼接出的新的NSDate对象
 */
+ (NSDate *)dateWithDatePart:(NSDate *)aDate
                 andTimePart:(NSDate *)aTime;

/**
	获取月份部分
	@returns 返回日期月份部分的字符串
 */
- (NSString*)monthString;


/**
	获取年份部分
	@returns 返回日期年份部分的字符串
 */
- (NSString*)yearString;


/**
	将日期数字字符串转换为目标格式日期字符串
	@param originStr 待转换的日期字符串
	@param originDateFormat 待转换的日期字符串的日期格式
	@param destinationFormat 目标日期字符串的日期格式
	@returns 返回转换后的日期字符串
 */
+ (NSString *)dateString:(NSString *)originStr
        originDateFormat:(NSString *)originDateFormat
       destinationFormat:(NSString *)destinationFormat;


/**
	将日期字符串转换为指定格式的NSDate对象
	@param dateStr 待转换的日期字符串
	@param dateFormat 日期格式
	@returns 返回日期对象
 */
+ (NSDate *)dateString:(NSString *)dateStr
            withFormat:(NSString *)dateFormat;

// 根据 年份月份 获取当月天数
+ (int)getDayCountForMonth:(int)year
                     month:(int)month;

@end
