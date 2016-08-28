//
//  XDDebugUtils.h
//  XDCommonLib
//
//  Created by suxinde on 15/5/6.
//  Copyright (c) 2015年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  内存信息
 */
typedef struct {
    natural_t used;
    natural_t free;
} XDMemroyInfo;

/**
 *  调试工具类
 */
@interface XDDebugUtils : NSObject

/**
 *  获取内存信息Description
 */
+ (NSString *)memoryUsageDescription;

/**
 *  获取内存信息
 */
+ (XDMemroyInfo)memoryInfo;

/**
 *  系统信息状态栏背景是图
 */
+ (UIView *)sysStatusBarBgView;

/**
 *  系统信息状态栏
 */
+ (UIView *)sysStatusBar;

@end
