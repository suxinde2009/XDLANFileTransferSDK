//
//  XDLogger.m
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

#import "XDLogger.h"

#define __XD_DEVELOPMENT__ (1)

#pragma mark -

#undef	MAX_BACKLOG
#define MAX_BACKLOG	(50)

#pragma mark -


@implementation XDBacklog

@synthesize module = _module;
@synthesize level = _level;
@dynamic levelString;
@synthesize file = _file;
@synthesize line = _line;
@synthesize func = _func;
@synthesize time = _time;
@synthesize text = _text;

- (id)init
{
    self = [super init];
    if ( self )
    {
        self.level = XDLogLevelNone;
        self.time = [NSDate date];
    }
    return self;
}

- (void)dealloc
{
    self.module = nil;
    self.file = nil;
    self.func = nil;
    self.time = nil;
    self.text = nil;
}

- (NSString *)levelString
{
    if ( XDLogLevelInfo == self.level )
    {
        return @"INFO";
    }
    else if ( XDLogLevelPerf == self.level )
    {
        return @"PERF";
    }
    else if ( XDLogLevelWarn == self.level )
    {
        return @"WARN";
    }
    else if ( XDLogLevelError == self.level )
    {
        return @"ERROR";
    }
    
    return @"SYSTEM";
}

@end

#pragma mark -

@interface XDLogger() {
@private
    BOOL				_showLevel;
    BOOL				_showModule;
    
    BOOL				_enabled;
    NSMutableArray *	_backlogs;
    NSUInteger			_indentTabs;
}
@end

#pragma mark -

@implementation XDLogger

//DEF_SINGLETON( XDLogger );

+ (instancetype)sharedInstance
{
    static dispatch_once_t oneToken;
    static XDLogger *__sharedInstace;
    dispatch_once(&oneToken, ^{
        __sharedInstace = [[XDLogger alloc] init];
    });
    return __sharedInstace;
}

@synthesize showLevel = _showLevel;
@synthesize showModule = _showModule;

@synthesize enabled = _enabled;
@synthesize backlogs = _backlogs;
@synthesize indentTabs = _indentTabs;



- (id)init
{
    self = [super init];
    if ( self )
    {
#if __XD_DEVELOPMENT__
        self.showLevel = YES;
        self.showModule = NO;
#else	// #if __XD_DEVELOPMENT__
        self.showLevel = YES;
        self.showModule = NO;
#endif	// #if __XD_DEVELOPMENT__
        
        self.enabled = YES;
        self.backlogs = [NSMutableArray array];
        self.indentTabs = 0;
    }
    return self;
}

- (void)dealloc
{
    self.backlogs = nil;
}


- (void)toggle
{
    _enabled = _enabled ? NO : YES;
}

- (void)enable
{
    _enabled = YES;
}

- (void)disable
{
    _enabled = NO;
}

- (void)indent
{
    _indentTabs += 1;
}

- (void)indent:(NSUInteger)tabs
{
    _indentTabs += tabs;
}

- (void)unindent
{
    if ( _indentTabs > 0 )
    {
        _indentTabs -= 1;
    }
}

- (void)unindent:(NSUInteger)tabs
{
    if ( _indentTabs < tabs )
    {
        _indentTabs = 0;
    }
    else
    {
        _indentTabs -= tabs;
    }
}

#if __XD_DEVELOPMENT__
- (void)file:(NSString *)file line:(NSUInteger)line function:(NSString *)function level:(XDLogLevel)level format:(NSString *)format, ...
#else	// #if __XD_DEVELOPMENT__
- (void)level:(XDLogLevel)level format:(NSString *)format, ...
#endif	// #if __XD_DEVELOPMENT__
{
#if (__ON__ == __XD_LOG__)
    
    if ( nil == format || NO == [format isKindOfClass:[NSString class]] )
        return;
    
    va_list args;
    va_start( args, format );
    
#if __XD_DEVELOPMENT__
    [self file:file line:line function:function level:level format:format args:args];
#else	// #if __XD_DEVELOPMENT__
    [self level:level format:format args:args];
#endif	// #if __XD_DEVELOPMENT__
    
    va_end( args );
    
#endif	// #if (__ON__ == __XD_LOG__)
}

#if __XD_DEVELOPMENT__
- (void)file:(NSString *)file line:(NSUInteger)line function:(NSString *)function level:(XDLogLevel)level format:(NSString *)format args:(va_list)args
#else	// #if __XD_DEVELOPMENT__
- (void)level:(XDLogLevel)level format:(NSString *)format args:(va_list)args
#endif	// #if __XD_DEVELOPMENT__
{
#if (__ON__ == __XD_LOG__)
    
    if ( NO == _enabled )
        return;
    
    // formatting
    
    NSMutableString * text = [NSMutableString string];
    NSMutableString * tabs = nil;
    
    if ( _indentTabs > 0 )
    {
        tabs = [NSMutableString string];
        
        for ( int i = 0; i < _indentTabs; ++i )
        {
            [tabs appendString:@"\t"];
        }
    }
    
    NSString * module = nil;
    
#if __XD_DEVELOPMENT__
    module = [[file lastPathComponent] stringByDeletingPathExtension];
    if ( [module hasPrefix:@"XD_"] )
    {
        module = [module substringFromIndex:@"XD_".length];
    }
#endif	// #if __XD_DEVELOPMENT__
    
    if ( self.showLevel || self.showModule )
    {
        NSMutableString * temp = [NSMutableString string];
        
        if ( self.showLevel )
        {
            if ( XDLogLevelInfo == level )
            {
                [temp appendString:@"[INFO]"];
            }
            else if ( XDLogLevelPerf == level )
            {
                [temp appendString:@"[PERF]"];
            }
            else if ( XDLogLevelWarn == level )
            {
                [temp appendString:@"[WARN]"];
            }
            else if ( XDLogLevelError == level )
            {
                [temp appendString:@"[ERROR]"];
            }
        }
        
        if ( self.showModule )
        {
            if ( module && module.length )
            {
                [temp appendFormat:@" [%@]", module];
            }
        }
        
        if ( temp.length )
        {
            NSString * temp2 = [temp stringByPaddingToLength:((temp.length / 8) + 1) * 8 withString:@" " startingAtIndex:0];
            [text appendString:temp2];
        }
    }
    
    if ( tabs && tabs.length )
    {
        [text appendString:tabs];
    }
    
//#if __XD_DEVELOPMENT__
//	if ( file )
//	{
//		[text appendFormat:@"%@(#%d) ", [file lastPathComponent], line];
//	}
//#endif	// #if __XD_DEVELOPMENT__
    
    NSString * content = [[NSString alloc] initWithFormat:(NSString *)format arguments:args];
    if ( content && content.length )
    {
        [text appendString:content];
    }
    
    if ( [text rangeOfString:@"\n"].length )
    {
        [text replaceOccurrencesOfString:@"\n"
                              withString:[NSString stringWithFormat:@"\n%@", tabs ? tabs : @"\t\t"]
                                 options:NSCaseInsensitiveSearch
                                   range:NSMakeRange( 0, text.length )];
    }
    
    if ( [text rangeOfString:@"%"].length )
    {
        [text replaceOccurrencesOfString:@"%"
                              withString:@"%%"
                                 options:NSCaseInsensitiveSearch
                                   range:NSMakeRange( 0, text.length )];
    }
    
    // print to console
    
    fprintf( stderr, [text UTF8String], NULL );
    fprintf( stderr, "\n", NULL );
    
    // back log
    
#if __XD_DEVELOPMENT__
    if ( XDLogLevelError == level || XDLogLevelWarn == level )
    {
        XDBacklog * log = [[XDBacklog alloc] init];
        if ( log )
        {
            log.level = level;
            log.text = text;
            log.module = module;
            log.file = file;
            log.line = line;
            log.func = function;
            
            [_backlogs pushTail:log];
            [_backlogs keepTail:MAX_BACKLOG];
        }
    }
#endif	// #if __XD_DEVELOPMENT__
#endif	// #if (__ON__ == __XD_LOG__)
}

@end

#if __cplusplus
extern "C"
#endif	// #if __cplusplus
void XDLog( NSString * format, ... )
{
#if (__ON__ == __XD_LOG__)
    
    if ( nil == format || NO == [format isKindOfClass:[NSString class]] )
        return;
    
    va_list args;
    va_start( args, format );
    
#if __XD_DEVELOPMENT__
    [[XDLogger sharedInstance] file:nil line:0 function:nil level:XDLogLevelInfo format:format args:args];
#else	// #if __XD_DEVELOPMENT__
    [[XDLogger sharedInstance] level:XDLogLevelInfo format:format args:args];
#endif	// #if __XD_DEVELOPMENT__
    
    va_end( args );
    
#endif	// #if (__ON__ == __XD_LOG__)
}

@implementation NSMutableArray (XDLoggerUtis)

- (NSMutableArray *)pushTail:(NSObject *)obj
{
    if ( obj )
    {
        [self addObject:obj];
    }
    
    return self;
}

- (NSMutableArray *)keepTail:(NSUInteger)n
{
    if ( [self count] > n )
    {
        NSRange range;
        range.location = 0;
        range.length = [self count] - n;
        
        [self removeObjectsInRange:range];
    }
    
    return self;
}

@end
