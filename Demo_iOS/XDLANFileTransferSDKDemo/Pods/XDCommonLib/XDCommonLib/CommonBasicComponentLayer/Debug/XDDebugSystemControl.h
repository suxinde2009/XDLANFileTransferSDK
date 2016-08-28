//
//  XDDebugSystemControl.h
//  XDCommonLib
//
//  Created by su xinde on 15/11/26.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  系统信息工具类
 */
@interface XDDebugSystemControl : NSObject

/**
 *  获取平台信息
 */
+ (NSString *)platform;

/**
 *  获取平台信息
 */
+ (NSUInteger)getSysInfo:(uint)typeSpecifier;

/**
 *  获取CPU频率
 */
+ (NSUInteger)getCpuFrequency;

/**
 *  获取总线频率
 */
+ (NSUInteger)getBusFrequency;

/**
 *  获取总的内存大小
 */
+ (NSUInteger)getTotalMemory;

/**
 *  获取用户内存
 */
+ (NSUInteger)getUserMemory;

/**
 *  获取socketBufferSize
 */
+ (NSUInteger)maxSocketBufferSize;

/**
 *  iphone下获取可用的内存大小
 */
+ (NSUInteger)getAvailableMemory;

/**
 *  获取CPU使用率
 */
+(float)cpuUsage;

@end
