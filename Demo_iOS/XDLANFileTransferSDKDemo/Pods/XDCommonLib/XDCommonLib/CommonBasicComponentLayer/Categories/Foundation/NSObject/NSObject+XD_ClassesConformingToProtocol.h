//
//  NSObject+XD_ClassesConformingToProtocol.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/13.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 获取实现某Protocol的一组类
 */

@interface NSObject (XD_ClassesConformingToProtocol)

/**
 *  获取实现某Protocol的一组类
 *
 *  @param protocol 指定的Protocol
 *
 *  @return 实现该Protocol的一组类
 */
+ (NSArray *)xd_ClassesConformingToProtocol:(Protocol *)protocol;

@end
