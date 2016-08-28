//
//  NSObject+XDCommonLib.h
//  XDCommonLib
//
//  Created by suxinde on 16/4/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XDCommonLib)

/**
 *  Check if the object is valid (not nil or null)
 *
 *  @return Returns if the object is valid
 */
- (BOOL)isValid;

/**
 *  Perform selector with unlimited objects
 *
 *  @param aSelector The selector
 *  @param object    The objects
 *
 *  @return An object that is the result of the message
 */
- (id _Nonnull)performSelector:(SEL _Nonnull)aSelector
                   withObjects:(id _Nullable)object, ... NS_REQUIRES_NIL_TERMINATION;


@end
