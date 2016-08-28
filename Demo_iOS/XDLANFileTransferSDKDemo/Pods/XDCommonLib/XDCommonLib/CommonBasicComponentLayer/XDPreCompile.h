//
//  XDPreDefine.h
//  
//
//  Created by suxinde on 15/5/4.
//  Copyright (c) 2015年 Su XinDe. All rights reserved.
//

#ifndef XDCommonLib_XDPreDefine_h
#define XDCommonLib_XDPreDefine_h

// ----------------------------------
// Global include headers
// ----------------------------------

#import <stdio.h>
#import <stdlib.h>
#import <stdint.h>
#import <string.h>
#import <assert.h>
#import <errno.h>

#import <sys/errno.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <sys/types.h>
#import <sys/socket.h>

#import <math.h>
#import <unistd.h>
#import <limits.h>
#import <execinfo.h>

#import <netdb.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <ifaddrs.h>

#import <mach/mach.h>
#import <malloc/malloc.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <execinfo.h>

#ifdef __OBJC__

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <TargetConditionals.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreImage/CoreImage.h>
#import <CoreLocation/CoreLocation.h>

#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVSpeechSynthesis.h>
#import <CoreMotion/CoreMotion.h>
#import <Social/Social.h>

#import <objc/runtime.h>
#import <objc/message.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#endif	// #ifdef __OBJC__




// ----------------------------------
#pragma mark  - 开发调试信息的开关宏定义 -
// ----------------------------------

// 测试用
#define __XD_DEBUG__  (1)

// 测试用
#define __XD_DEBUG_SHOWBORDER__  (0) // 点击视图所点视图显示红色边框动画，默认关闭

// 开启调试
#define  __XD_UNITTESTING__ (1)

// 开启性能测试
#define __XD_PERFORMANCE__  (1)



// ---------------------------------



// ----------------------------------
// Common use macros
// ----------------------------------

////////////////////////////////////////////////////////////////////////////////////////
#pragma mark  - TextAlignmentLeft & LineBreakMode Marcos -
////////////////////////////////////////////////////////////////////////////////////////

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000

#define UILineBreakMode					NSLineBreakMode
#define UILineBreakModeWordWrap			NSLineBreakByWordWrapping
#define UILineBreakModeCharacterWrap	NSLineBreakByCharWrapping
#define UILineBreakModeClip				NSLineBreakByClipping
#define UILineBreakModeHeadTruncation	NSLineBreakByTruncatingHead
#define UILineBreakModeTailTruncation	NSLineBreakByTruncatingTail
#define UILineBreakModeMiddleTruncation	NSLineBreakByTruncatingMiddle

#define UITextAlignmentLeft				NSTextAlignmentLeft
#define UITextAlignmentCenter			NSTextAlignmentCenter
#define UITextAlignmentRight			NSTextAlignmentRight
#define	UITextAlignment					NSTextAlignment

#endif	// #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000

////////////////////////////////////////////////////////////////////////////////////////
#pragma mark  - Deprecated -
////////////////////////////////////////////////////////////////////////////////////////

#ifndef __Class_Deprecated__
#define __Class_Deprecated__        __attribute__((deprecated))
#endif

#ifndef __Property_Deprecated__
#define __Property_Deprecated__     __attribute__((deprecated))
#endif

#ifndef __Method_Deprecated__
#define __Method_Deprecated__       __attribute__((deprecated))
#endif

////////////////////////////////////////////////////////////////////////////////////////




// ------------------------
// 单例模式
// ------------------------
#if __has_feature(objc_instancetype)

    #undef	AS_SINGLETON
    #define AS_SINGLETON( ... ) \
            - (instancetype)sharedInstance; \
            + (instancetype)sharedInstance;

    #undef	DEF_SINGLETON
    #define DEF_SINGLETON \
            - (instancetype)sharedInstance \
            { \
                return [[self class] sharedInstance]; \
            } \
            + (instancetype)sharedInstance \
            { \
                static dispatch_once_t once; \
                static id __singleton__; \
                dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
                return __singleton__; \
            }

    #undef	DEF_SINGLETON
    #define DEF_SINGLETON( ... ) \
            - (instancetype)sharedInstance \
            { \
                return [[self class] sharedInstance]; \
            } \
            + (instancetype)sharedInstance \
            { \
                static dispatch_once_t once; \
                static id __singleton__; \
                dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
                return __singleton__; \
            }

#else	// #if __has_feature(objc_instancetype)

    #undef	AS_SINGLETON
    #define AS_SINGLETON( __class ) \
            - (__class *)sharedInstance; \
            + (__class *)sharedInstance;

            #undef	DEF_SINGLETON
            #define DEF_SINGLETON( __class ) \
            - (__class *)sharedInstance \
            { \
                return [__class sharedInstance]; \
            } \
            + (__class *)sharedInstance \
            { \
                static dispatch_once_t once; \
                static __class * __singleton__; \
                dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
                return __singleton__; \
            }

#endif	// #if __has_feature(objc_instancetype)




// ------------------------
#pragma mark  - 执行一次 dispatch_once_t -
// ------------------------
#undef	XD_ONCE_BEGIN
#define XD_ONCE_BEGIN( __name ) \
static dispatch_once_t once_##__name; \
dispatch_once( &once_##__name , ^{

#undef	XD_ONCE_END
#define XD_ONCE_END		});

// ------------------------
#pragma mark  - NSUserDefaults -
// ------------------------
#define XDUserDefalutsSetObjctetForKey(__Obj__, __Key__) \
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults]; \
        [prefs setObject: __Obj__ forKey: __Key__]; \
        [prefs synchronize];

#define XDUserDefalutsSetIntegerForKey(__Integer__, __Key__) \
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults]; \
        [prefs setInteger: __Integer__ forKey: __Key__]; \
        [prefs synchronize];

#define XDUserDefalutsSetFloatForKey(__Float__, __Key__) \
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults]; \
        [prefs setFloat: __Float__ forKey: __Key__]; \
        [prefs synchronize];

#define XDUserDefalutsSetDoubleForKey(__Double__, __Key__) \
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults]; \
        [prefs setDouble: __Double__ forKey: __Key__]; \
        [prefs synchronize];

#define XDUserDefalutsSetBoolForKey(__Bool__, __Key__) \
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults]; \
        [prefs setBool: __Bool__ forKey: __Key__]; \
        [prefs synchronize];

//------------------------

#define XDUserDefaultsObjectForKey(__Key__) \
        [[NSUserDefaults standardUserDefaults] objectForKey: __Key__];

#define XDUserDefaultsIntegerForKey(__Key__) \
        [[NSUserDefaults standardUserDefaults] integerForKey: __Key__];

#define XDUserDefaultsFloatForKey(__Key__) \
        [[NSUserDefaults standardUserDefaults] floatForKey: __Key__];

#define XDUserDefaultsDoubleForKey(__Key__) \
        [[NSUserDefaults standardUserDefaults] doubleForKey: __Key__];

#define XDUserDefaultsBoolForKey(__Key__) \
        [[NSUserDefaults standardUserDefaults] boolForKey: __Key__];

//------------------------

#endif
