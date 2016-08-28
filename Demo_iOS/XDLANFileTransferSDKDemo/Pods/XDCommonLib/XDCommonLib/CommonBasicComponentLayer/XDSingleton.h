//
//  XDSingleton.h
//  XDCommonLib
//
//  Created by su xinde on 15/11/26.
//  Copyright © 2015年 su xinde. All rights reserved.
//


#ifndef XDSingleton_h
#define XDSingleton_h

#define DEF_SINGLETON + (instancetype)sharedInstance;

#if __has_feature(objc_arc)

    #define IMP_SINGLETON \
    + (instancetype)sharedInstance { \
        static id sharedObject = nil; \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            sharedObject = [[self alloc] init]; \
        }); \
        return sharedObject; \
    }\
    - (id)copyWithZone:(NSZone*)zone{\
        return self;\
    }

#else

#define IMP_SINGLETON \
    + (instancetype)sharedInstance { \
        static id sharedObject = nil; \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            sharedObject = [[self alloc] init]; \
        }); \
        return sharedObject; \
    }\
    - (id)copyWithZone:(NSZone*)zone{\
        return self;\
    }\
    - (id)retain{\
        return self;\
    }\
    - (NSUInteger)retainCount{\
        return NSUIntegerMax;\
    }\
    - (oneway void)release{\
    }\
    - (id)autorelease{\
        return self;\
    }

#endif

#endif /* XDSingleton_h */
