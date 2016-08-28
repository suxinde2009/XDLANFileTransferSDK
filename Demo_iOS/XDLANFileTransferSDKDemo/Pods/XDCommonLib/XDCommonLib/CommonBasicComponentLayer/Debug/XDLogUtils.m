//
//  XDLogUtils.m
//  XDCommonLib
//
//  Created by su xinde on 15/11/27.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import "XDLogUtils.h"

NSString *const kXDLogFile =  @"Log_File.txt";

@interface XDLogUtils (Private)

+ (NSString *)logFilePath:(NSString *)logFile;
+ (NSString *)logTimeStringFromDate:(NSDate *)date;

+ (void)writeLogToFile:(NSString *)filePath
                   log:(NSString *)log;

@end

@implementation XDLogUtils (Private)

+ (void)writeLogToFile:(NSString *)filePath
                   log:(NSString *)log
{
    
#if __Log_Enabled__
    
    @synchronized(self) {
        NSString *tmpStr = [[NSString alloc] initWithContentsOfFile:filePath
                                                           encoding:NSUTF8StringEncoding
                                                              error:nil];
        if (tmpStr == nil) {
            tmpStr = [[NSString alloc] initWithFormat:@""];
        }
        // 日志时间
        NSString *logDate = [XDLogUtils logTimeStringFromDate:[NSDate date]];
        //
        NSString *logContent = [NSString stringWithFormat:@"\n%@: %@\n", logDate, log];
        
        NSString *logFileContent = [tmpStr stringByAppendingString:logContent];
        
        NSData *data = [logFileContent dataUsingEncoding:NSUTF8StringEncoding];
        
        BOOL logWritten = [data writeToFile:filePath atomically:YES];
        
        if (logWritten == NO) {
            
            NSLog(@"写入日志信息至%@日志文件失败", filePath);
        }
    }
    
#endif
    
}

+ (NSString *)logFilePath:(NSString *)logFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:logFile];
    return filePath;
}

+ (NSString *)logTimeStringFromDate:(NSDate *)date
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    });
    
    return [formatter stringFromDate:date];
}

@end

@implementation XDLogUtils

+ (void)writeToLogFile:(NSString *)log
{
    NSString *logFilePath = [XDLogUtils logFilePath:kXDLogFile];
    [XDLogUtils writeLogToFile:logFilePath
                           log:log];
}

@end
