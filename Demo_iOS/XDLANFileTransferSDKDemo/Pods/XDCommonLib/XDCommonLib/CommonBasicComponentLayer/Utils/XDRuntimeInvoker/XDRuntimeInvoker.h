//
//  XDRuntimeInvoker.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XDRuntimeInvoker)

/**
 *  Invoke a selector with name
 *
 *  @param selector Selector name
 *
 *  @return Return value
 */
- (id)invoke:(NSString *)selector;

/**
 *  Invoke a selector with name and args
 *
 *  @param selector Selector name
 *  @param arg      Arguments list (end with nil)
 *
 *  @return Return value
 */
- (id)invoke:(NSString *)selector args:(id)arg, ... ;

/**
 *  Invoke a selector with name and args
 *
 *  @param selector  Selector name
 *  @param arguments Arguments list
 *
 *  @return Return value
 */
- (id)invoke:(NSString *)selector arguments:(NSArray *)arguments;

/**
 *  Invoke a selector with name (Class Method)
 *
 *  @param selector Selector name
 *
 *  @return Return value
 */
+ (id)invoke:(NSString *)selector;

/**
 *  Invoke a selector with name and args (Class Method)
 *
 *  @param selector Selector name
 *  @param arg      Arguments list (end with nil)
 *
 *  @return Return value
 */
+ (id)invoke:(NSString *)selector args:(id)arg, ... ;

/**
 *  Invoke a selector with name and args (Class Method)
 *
 *  @param selector  Selector name
 *  @param arguments Arguments list
 *
 *  @return Return value
 */
+ (id)invoke:(NSString *)selector arguments:(NSArray *)arguments;

@end
