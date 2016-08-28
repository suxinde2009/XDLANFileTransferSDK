//
//  NSDate+StarSign.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSDate+StarSign.h"

@implementation NSDate (StarSign)

/**
 *  返回NSDate对应星座
 */
- (NSString *)starSign {
    
    NSString *starSignString = @"";
    if ([self isBetweenDate:@"12-22" andDate:@"12-31"])
        starSignString = NSLocalizedString(@"摩羯座", nil);
    else if ([self isBetweenDate:@"01-01" andDate:@"01-19"])
        starSignString = NSLocalizedString(@"摩羯座", nil);
    else if ([self isBetweenDate:@"01-20" andDate:@"02-18"])
        starSignString = NSLocalizedString(@"水瓶座", nil);
    else if ([self isBetweenDate:@"02-19" andDate:@"03-20"])
        starSignString = NSLocalizedString(@"双鱼座", nil);
    else if ([self isBetweenDate:@"03-21" andDate:@"04-19"])
        starSignString = NSLocalizedString(@"白羊座", nil);
    else if ([self isBetweenDate:@"04-20" andDate:@"05-20"])
        starSignString = NSLocalizedString(@"金牛座", nil);
    else if ([self isBetweenDate:@"05-21" andDate:@"06-21"])
        starSignString = NSLocalizedString(@"双子座", nil);
    else if ([self isBetweenDate:@"06-22" andDate:@"07-22"])
        starSignString = NSLocalizedString(@"巨蟹座", nil);
    else if ([self isBetweenDate:@"07-23" andDate:@"08-22"])
        starSignString = NSLocalizedString(@"狮子座", nil);
    else if ([self isBetweenDate:@"08-23" andDate:@"09-22"])
        starSignString = NSLocalizedString(@"处女座", nil);
    else if ([self isBetweenDate:@"09-23" andDate:@"10-23"])
        starSignString = NSLocalizedString(@"天秤座", nil);
    else if ([self isBetweenDate:@"10-24" andDate:@"11-22"])
        starSignString = NSLocalizedString(@"天蝎座", nil);
    else if ([self isBetweenDate:@"11-23" andDate:@"12-21"])
        starSignString = NSLocalizedString(@"射手座", nil);
    
    return starSignString;
}

- (BOOL)isBetweenDate:(NSString *)earlierDate andDate:(NSString *)laterDate {
    NSString *format = @"MM-dd";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:self];
    BOOL isB = ([dateString compare:earlierDate] >= 0) && ([dateString compare:laterDate] <= 0);
    return isB;
}


@end
