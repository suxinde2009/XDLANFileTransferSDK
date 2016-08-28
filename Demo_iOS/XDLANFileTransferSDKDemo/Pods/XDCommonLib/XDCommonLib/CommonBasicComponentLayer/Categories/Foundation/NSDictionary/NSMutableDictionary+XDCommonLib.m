//
//  NSMutableDictionary+XDCommonLib.m
//  XDCommonLib
//
//  Created by suxinde on 16/4/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSMutableDictionary+XDCommonLib.h"

@implementation NSMutableDictionary (XDCommonLib)

- (BOOL)safeSetObject:(id _Nonnull)anObject forKey:(id<NSCopying> _Nonnull)aKey {
    if (anObject == nil) {
        return NO;
    }
    
    [self setObject:anObject forKey:aKey];
    
    return YES;
}


@end
