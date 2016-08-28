//
//  XDLogUtils.h
//  XDCommonLib
//
//  Created by su xinde on 15/11/27.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __Log_Enabled__ (1)

/**
 *  日志文件
 */
extern NSString *const kXDLogFile;

/**
 *  日志文件工具，用于记录一些调试信息的日志文件
 */
@interface XDLogUtils : NSObject

+ (void)writeToLogFile:(NSString *)log;

@end
