//
//  NSString+VersionUtil.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSString+VersionUtil.h"
#import <UIKit/UIKit.h>

@implementation NSString (VersionUtil)

- (NSComparisonResult)compareVersion:(NSString *)version
{
    return [self compare:version options:NSNumericSearch];
}

- (BOOL)isEqualTo:(NSString *)v
{
    return [self compare:v options:NSNumericSearch] == NSOrderedSame;
}

- (BOOL)isGreaterThan:(NSString *)v
{
    return [self compare:v options:NSNumericSearch] == NSOrderedDescending;
}

- (BOOL)isGreaterThanOrEqualTo:(NSString *)v
{
    return [self compare:v options:NSNumericSearch] != NSOrderedAscending;
}

- (BOOL)isLessThan:(NSString *)v
{
    return [self compare:v options:NSNumericSearch] == NSOrderedAscending;
}

- (BOOL)isLessThanOrEqualTo:(NSString *)v
{
    return [self compare:v options:NSNumericSearch] != NSOrderedDescending;
}

- (BOOL)isEqualToAppVersion
{
    return [self compare:XD_APP_VERSION options:NSNumericSearch] == NSOrderedSame;
}

- (BOOL)isGreaterThanAppVersion
{
    return [self compare:XD_APP_VERSION options:NSNumericSearch] == NSOrderedDescending;
}

- (BOOL)isGreaterThanOrEqualToAppVersion
{
    return [self compare:XD_APP_VERSION options:NSNumericSearch] != NSOrderedAscending;
}

- (BOOL)isLessThanAppVersion
{
    return [self compare:XD_APP_VERSION options:NSNumericSearch] == NSOrderedAscending;
}

- (BOOL)isLessThanOrEqualToAppVersion
{
    return [self compare:XD_APP_VERSION options:NSNumericSearch] != NSOrderedDescending;
}


+ (BOOL)appVersionEqualTo:(NSString *)version
{
    return [XD_APP_VERSION compare:version options:NSNumericSearch] == NSOrderedSame;
}

+ (BOOL)appVersionGreaterThan:(NSString *)version
{
    return [XD_APP_VERSION compare:version options:NSNumericSearch] == NSOrderedDescending;
}

+ (BOOL)appVersionGreaterThanOrEqualTo:(NSString *)version
{
    return [XD_APP_VERSION compare:version options:NSNumericSearch] != NSOrderedAscending;
}

+ (BOOL)appVersionLessThan:(NSString *)version
{
    return [XD_APP_VERSION compare:version options:NSNumericSearch] == NSOrderedAscending;
}

+ (BOOL)appVersionLessThanOrEqualTo:(NSString *)version
{
    return [XD_APP_VERSION compare:version options:NSNumericSearch] != NSOrderedDescending;
}

// 系统版本判断
+ (BOOL)systemVersionEqualTo:(NSString *)version
{
    return [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedSame;
}

+ (BOOL)systemVersionGreaterThan:(NSString *)version
{
    return [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedDescending;
}

+ (BOOL)systemVersionGreaterThanOrEqualTo:(NSString *)version
{
    return [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending;
}

+ (BOOL)systemVersionLessThan:(NSString *)version
{
    return [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending;
}

+ (BOOL)systemVersionLessThanOrEqualTo:(NSString *)version
{
    return [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedDescending;
}


@end
