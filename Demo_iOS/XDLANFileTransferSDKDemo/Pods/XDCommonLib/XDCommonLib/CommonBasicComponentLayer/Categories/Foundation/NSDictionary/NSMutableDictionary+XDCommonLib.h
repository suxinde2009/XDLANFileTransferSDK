//
//  NSMutableDictionary+XDCommonLib.h
//  XDCommonLib
//
//  Created by suxinde on 16/4/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (XDCommonLib)

/**
 *  Set the object for a given key in safe mode (if not nil)
 *
 *  @param anObject The object
 *  @param aKey     The key
 *
 *  @return Returns YES if has been setted, otherwise NO
 */
- (BOOL)safeSetObject:(id _Nonnull)anObject
               forKey:(id<NSCopying> _Nonnull)aKey;


@end
