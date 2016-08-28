//
//  NSObject+SuperClasses.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/23.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSObject+SuperClasses.h"

@implementation NSObject (SuperClasses)

+ (NSArray *)superClasses {
    if ([self isEqual:[NSObject class]]) return @[[self class]];
    
    Class theClass = self;
    NSMutableArray *results = [@[theClass] mutableCopy];
    
    do {
        theClass = [theClass superclass];
        if (theClass) {
            [results addObject:theClass];
        }
    }while (![theClass isEqual:[NSObject class]]) ;
    
    return results;
}

- (NSArray *)superClasses {
    return [[self class] superClasses];
}

@end
