//
//  NSObject+SuperClasses.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/23.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 获取所有父类
 */

@interface NSObject (SuperClasses)

+ (NSArray *)superClasses;
- (NSArray *)superClasses;

@end
