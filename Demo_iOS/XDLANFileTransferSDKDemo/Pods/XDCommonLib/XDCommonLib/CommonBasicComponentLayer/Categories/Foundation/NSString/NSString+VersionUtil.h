//
//  NSString+VersionUtil.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef XD_SYS_VERSION
#define XD_SYS_VERSION         [[UIDevice currentDevice] systemVersion]
#endif

#ifndef XD_APP_VERSION
#define XD_APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#endif

@interface NSString (VersionUtil)

- (NSComparisonResult)compareVersion:(NSString *)version;

- (BOOL)isEqualTo:(NSString *)v;
- (BOOL)isGreaterThan:(NSString *)v;
- (BOOL)isGreaterThanOrEqualTo:(NSString *)v;
- (BOOL)isLessThan:(NSString *)v;
- (BOOL)isLessThanOrEqualTo:(NSString *)v;

- (BOOL)isEqualToAppVersion;
- (BOOL)isGreaterThanAppVersion;
- (BOOL)isGreaterThanOrEqualToAppVersion;
- (BOOL)isLessThanAppVersion;
- (BOOL)isLessThanOrEqualToAppVersion;

+ (BOOL)appVersionEqualTo:(NSString *)version;
+ (BOOL)appVersionGreaterThan:(NSString *)version;
+ (BOOL)appVersionGreaterThanOrEqualTo:(NSString *)version;
+ (BOOL)appVersionLessThan:(NSString *)version;
+ (BOOL)appVersionLessThanOrEqualTo:(NSString *)version;

+ (BOOL)systemVersionEqualTo:(NSString *)version;
+ (BOOL)systemVersionGreaterThan:(NSString *)version;
+ (BOOL)systemVersionGreaterThanOrEqualTo:(NSString *)version;
+ (BOOL)systemVersionLessThan:(NSString *)version;
+ (BOOL)systemVersionLessThanOrEqualTo:(NSString *)version;

@end
