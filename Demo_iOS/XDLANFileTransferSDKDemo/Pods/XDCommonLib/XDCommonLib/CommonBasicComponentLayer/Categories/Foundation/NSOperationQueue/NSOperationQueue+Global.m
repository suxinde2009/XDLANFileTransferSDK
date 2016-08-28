//
//  NSOperationQueue+Global.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/18.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSOperationQueue+Global.h"

@implementation NSOperationQueue (Global)

+ (instancetype)globalQueue {
    static dispatch_once_t onceToken;
    static NSOperationQueue *globalQueue;
    dispatch_once(&onceToken, ^{
        globalQueue = [[NSOperationQueue alloc] init];
        [globalQueue setSuspended:NO];
    });
    return globalQueue;
}


@end
