//
//  NSObject+XDCommonLib.h
//  XDCommonLib
//
//  Created by suxinde on 16/4/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 获取App信息工具类
 */

@interface NSObject (AppInfo)

- (NSString *)xd_appVersion;
- (NSString *)xd_appBuildId;
- (NSString *)xd_bundleIdentifier;
- (NSString *)xd_currentLanguage;
- (NSString *)xd_deviceModel;

@end
