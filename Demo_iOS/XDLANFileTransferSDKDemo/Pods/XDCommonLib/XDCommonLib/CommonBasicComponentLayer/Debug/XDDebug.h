//
//  XDDebug.h
//  XDCommonLib
//
//  Created by su xinde on 15/5/5.
//  Copyright (c) 2015年 su xinde. All rights reserved.
//

#ifndef XDCommonLib_XDDebug_h
#define XDCommonLib_XDDebug_h


/*
 * 说明 仅在debug模式下才显示nslog
 */
#if (1 == __XDDEBUG__)

    #undef	NSLogD
    #undef	NSLogDD
    #define NSLogD(fmt, ...) {NSLog((@"%s [Line %d] DEBUG: \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
    #define NSLogDD NSLogD(@"%@", @"");
    #define NSLogDSelf NSLogD(@"Class: %@", NSStringFromClass([self class]));

#else

    #define NSLogD(format, ...)
    #define NSLogDD
    #define NSLogDSelf

#endif

// -----------------------------------------------------------
//
// TODO 宏定义
//
// http://blog.sunnyxx.com/2015/03/01/todo-macro/#rd
// https://github.com/sunnyxx/TodoMacro
//
// http://stackoverflow.com/questions/18252351/custom-preprocessor-macro-for-a-conditional-pragma-message-xxx
//
// -----------------------------------------------------------

// 转成字符串
#define STRINGIFY(S) #S
// 需要解两次才解开的宏
#define DEFER_STRINGIFY(S) STRINGIFY(S)

#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))

// 为warning增加更多信息
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)

// 使宏前面可以加@
#define KEYWORDIFY try {} @catch (...) {}

// 最终使用的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


// -----------------------------------------------------------
// pragma-message.c
// https://llvm.org/svn/llvm-project/cfe/trunk/test/Lexer/pragma-message.c
//
/* Test pragma message directive from
 http://msdn.microsoft.com/en-us/library/x7dkzch2.aspx */
/**
// message: Sends a string literal to the standard output without terminating
// the compilation.
// #pragma message(messagestring)
// OR
// #pragma message messagestring
//
// RUN: %clang_cc1 -fsyntax-only -verify -Werror %s
#define STRING2(x) #x
#define STRING(x) STRING2(x)
#pragma message(":O I'm a message! " STRING(__LINE__)) // expected-warning {{:O I'm a message! 13}}
#pragma message ":O gcc accepts this! " STRING(__LINE__) // expected-warning {{:O gcc accepts this! 14}}

#pragma message(invalid) // expected-error {{expected string literal in pragma message}}

// GCC supports a similar pragma, #pragma GCC warning (which generates a warning
// message) and #pragma GCC error (which generates an error message).

#pragma GCC warning(":O I'm a message! " STRING(__LINE__)) // expected-warning {{:O I'm a message! 21}}
#pragma GCC warning ":O gcc accepts this! " STRING(__LINE__) // expected-warning {{:O gcc accepts this! 22}}

#pragma GCC error(":O I'm a message! " STRING(__LINE__)) // expected-error {{:O I'm a message! 24}}
#pragma GCC error ":O gcc accepts this! " STRING(__LINE__) // expected-error {{:O gcc accepts this! 25}}

#define COMPILE_ERROR(x) _Pragma(STRING2(GCC error(x)))
COMPILE_ERROR("Compile error at line " STRING(__LINE__) "!"); // expected-error {{Compile error at line 28!}}

#pragma message // expected-error {{pragma message requires parenthesized string}}
#pragma GCC warning("" // expected-error {{pragma warning requires parenthesized string}}
#pragma GCC error(1) // expected-error {{expected string literal in pragma error}}
*/


#endif
