//
//  NSDate+Utils.m
//  CoreFramework
//
//  Created by Su XinDE on 14-3-10.
//  Copyright (c) 2014年 Su XinDE. All rights reserved.
//

#import "NSDate+Utils.h"


@implementation NSDate (Utils)

+ (NSString*)getCurrentTime
{
    return [NSDate getCurrentTimeByFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString*)getCurrentTimeByFormat:(NSString *)format
{
    // format 格式形如：@"yyyyMMdd hh:mm:ss:SSS"
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    NSString *str = [fmt stringFromDate:[NSDate date]];
#if !__has_feature(objc_arc)
    [fmt release];
#endif
    return str;
}


- (BOOL)isSameDay:(NSDate*)anotherDate
{
	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                fromDate:self];
	NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                fromDate:anotherDate];
	
    return ([components1 year] == [components2 year] &&
            [components1 month] == [components2 month] &&
            [components1 day] == [components2 day]);
}

- (BOOL)isToday
{
	return [self isSameDay:[NSDate date]];
}


+ (NSDate *)dateWithDatePart:(NSDate *)aDate
                 andTimePart:(NSDate *)aTime
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	NSString *datePortion = [dateFormatter stringFromDate:aDate];
    
	[dateFormatter setDateFormat:@"HH:mm"];
	NSString *timePortion = [dateFormatter stringFromDate:aTime];
	
	[dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
	NSString *dateTime = [NSString stringWithFormat:@"%@ %@",datePortion,timePortion];
    
    NSDate *date = [dateFormatter dateFromString:dateTime];
    
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
    
	return date;
}

- (NSString*)monthString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM"];
    NSString *month = [dateFormatter stringFromDate:self];
    
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
	return month;
}

- (NSString*)yearString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy"];
    NSString *year = [dateFormatter stringFromDate:self];
    
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
    
	return year;
}


+ (NSString *)dateString:(NSString *)originStr
        originDateFormat:(NSString *)originDateFormat
       destinationFormat:(NSString *)destinationFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:originDateFormat];
    NSDate *date = [dateFormatter dateFromString:originStr];
    [dateFormatter setDateFormat:destinationFormat];
    NSString *destStr = [dateFormatter stringFromDate:date];
    
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
    return destStr;
}


+ (NSDate *)dateString:(NSString *)dateStr
            withFormat:(NSString *)dateFormat
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:dateFormat];
    NSDate *date = [df dateFromString:dateStr];
    
#if !__has_feature(objc_arc)
    [df release];
    [date autorelease];
#endif
    
    return date;
}


//////
+ (int)getDayCountForMonth:(int)year month:(int)month
{
    bool isLeapYear=(year%100==0)?(year%400==0):(year%4==0);
    switch(month)
    {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:
            return 31;
        case 4:case 6:case 9:case 11:
            return 30;
        default:
            return isLeapYear?29:28;
    }
}

@end
