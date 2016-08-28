//
//  XDLogger.h
//  XDLogger
//
//  Created by Su XinDe on 16/1/25.
//  Copyright © 2016年 com.su. All rights reserved.
//

//
//	 ______    ______    ______
//	/\  __ \  /\  ___\  /\  ___\
//	\ \  __<  \ \  __\_ \ \  __\_
//	 \ \_____\ \ \_____\ \ \_____\
//	  \/_____/  \/_____/  \/_____/
//
//
//	Copyright (c) 2014-2015, Geek Zoo Studio
//	http://www.bee-framework.com
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

typedef enum
{
    XDLogLevelNone		= 0,
    XDLogLevelInfo		= 100,
    XDLogLevelPerf		= 200,
    XDLogLevelWarn		= 300,
    XDLogLevelError	= 400
} XDLogLevel;


#if __XD_LOG__

#if __XD_DEVELOPMENT__

#undef	CC
#define CC( ... )		[[XDLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:XDLogLevelNone format:__VA_ARGS__];

#undef	INFO
#define INFO( ... )		[[XDLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:XDLogLevelInfo format:__VA_ARGS__];

#undef	PERF
#define PERF( ... )		[[XDLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:XDLogLevelPerf format:__VA_ARGS__];

#undef	WARN
#define WARN( ... )		[[XDLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:XDLogLevelWarn format:__VA_ARGS__];

#undef	ERROR
#define ERROR( ... )	[[XDLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:XDLogLevelError format:__VA_ARGS__];

#undef	PRINT
#define PRINT( ... )	[[XDLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:XDLogLevelNone format:__VA_ARGS__];

#else	// #if __XD_DEVELOPMENT__

#undef	CC
#define CC( ... )		[[XDLogger sharedInstance] level:XDLogLevelNone format:__VA_ARGS__];

#undef	INFO
#define INFO( ... )		[[XDLogger sharedInstance] level:XDLogLevelInfo format:__VA_ARGS__];

#undef	PERF
#define PERF( ... )		[[XDLogger sharedInstance] level:XDLogLevelPerf format:__VA_ARGS__];

#undef	WARN
#define WARN( ... )		[[XDLogger sharedInstance] level:XDLogLevelWarn format:__VA_ARGS__];

#undef	ERROR
#define ERROR( ... )	[[XDLogger sharedInstance] level:XDLogLevelError format:__VA_ARGS__];

#undef	PRINT
#define PRINT( ... )	[[XDLogger sharedInstance] level:XDLogLevelNone format:__VA_ARGS__];

#endif	// #if __XD_DEVELOPMENT__

#undef	VAR_DUMP
#define VAR_DUMP( __obj )	PRINT( [__obj description] );

#undef	OBJ_DUMP
#define OBJ_DUMP( __obj )	PRINT( [__obj objectToDictionary] );

#else	// #if __XD_LOG__

#undef	CC
#define CC( ... )

#undef	INFO
#define INFO( ... )

#undef	PERF
#define PERF( ... )

#undef	WARN
#define WARN( ... )

#undef	ERROR
#define ERROR( ... )

#undef	PRINT
#define PRINT( ... )

#undef	VAR_DUMP
#define VAR_DUMP( __obj )

#undef	OBJ_DUMP
#define OBJ_DUMP( __obj )

#endif	// #if __XD_LOG__

#undef	TODO
#define TODO( desc, ... )

#pragma mark -

@interface XDBacklog : NSObject
@property (nonatomic, retain) NSString *		module;
@property (nonatomic, assign) XDLogLevel		level;
@property (nonatomic, readonly) NSString *		levelString;
@property (nonatomic, retain) NSString *		file;
@property (nonatomic, assign) NSUInteger		line;
@property (nonatomic, retain) NSString *		func;
@property (nonatomic, retain) NSDate *			time;
@property (nonatomic, retain) NSString *		text;
@end

@interface XDLogger : NSObject

@property (nonatomic, assign) BOOL				showLevel;
@property (nonatomic, assign) BOOL				showModule;
@property (nonatomic, assign) BOOL				enabled;
@property (nonatomic, retain) NSMutableArray *	backlogs;
@property (nonatomic, assign) NSUInteger		indentTabs;

+ (instancetype)sharedInstance;

- (void)toggle;
- (void)enable;
- (void)disable;

- (void)indent;
- (void)indent:(NSUInteger)tabs;
- (void)unindent;
- (void)unindent:(NSUInteger)tabs;

#if __XD_DEVELOPMENT__

- (void)file:(NSString *)file
        line:(NSUInteger)line
    function:(NSString *)function
       level:(XDLogLevel)level
      format:(NSString *)format, ...;

- (void)file:(NSString *)file
        line:(NSUInteger)line
    function:(NSString *)function
       level:(XDLogLevel)level
      format:(NSString *)format
        args:(va_list)args;

#else	// #if __XD_DEVELOPMENT__

- (void)level:(XDLogLevel)level
       format:(NSString *)format, ...;

- (void)level:(XDLogLevel)level
       format:(NSString *)format
         args:(va_list)args;

#endif	// #if __XD_DEVELOPMENT__


@end

#pragma mark -

#if __cplusplus
extern "C" {
#endif
    
    void XDLog( NSString * format, ... );
    
#if __cplusplus
};
#endif

@interface NSMutableArray (XDLoggerUtis)

- (NSMutableArray *)pushTail:(NSObject *)obj;
- (NSMutableArray *)keepTail:(NSUInteger)n;

@end
