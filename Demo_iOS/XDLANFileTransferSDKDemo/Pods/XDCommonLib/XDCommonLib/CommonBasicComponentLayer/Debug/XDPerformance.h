//
//  XDPerformance.h
//  XDCommonLib
//
//  Created by suxinde on 15/5/5.
//  Copyright (c) 2015年 su xinde. All rights reserved.
//

// From XYQuickDevelop

#import <Foundation/Foundation.h>
#import "XDPreCompile.h"


#if (1 == __XD_PERFORMANCE__)

#define PERF_TIME( __block__ ) {}

#else

#define PERF_TIME( __block__ ) { __block__ }

#endif

@interface XDPerformance : NSObject

AS_SINGLETON(XDPerformance)

- (void)enter:(NSString *)tag;
- (void)leave:(NSString *)tag;

@end
