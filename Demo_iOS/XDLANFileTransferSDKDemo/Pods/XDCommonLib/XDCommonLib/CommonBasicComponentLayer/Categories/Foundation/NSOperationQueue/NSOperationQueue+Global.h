//
//  NSOperationQueue+Global.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/18.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 获取一个全局共用的NSOperationQueue
 */

@interface NSOperationQueue (Global)

/**
 *  全局共享的NSOperationQueue
 */
+ (instancetype)globalQueue;

@end
