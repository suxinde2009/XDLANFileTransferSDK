//
//  XDPerformance.m
//  XDCommonLib
//
//  Created by suxinde on 15/5/5.
//  Copyright (c) 2015年 su xinde. All rights reserved.
//

#import "XDPerformance.h"

@interface XDPerformance ()

@property (nonatomic, strong) NSMutableDictionary *tags;

@end


@implementation XDPerformance

DEF_SINGLETON(XDPerformance)

- (instancetype)init
{
    if (self = [super init]) {
        _tags = [@{} mutableCopy];
    }
    return self;
}

- (void)enter:(NSString *)tag
{
    NSNumber *time = @(CACurrentMediaTime());
    NSString *name = [NSString stringWithFormat:@"%@ enter", tag];
    [_tags setObject:time forKey:name];
}


- (void)leave:(NSString *)tag
{
    @autoreleasepool {
        NSString *name1 = [NSString stringWithFormat:@"%@ enter", tag];
        NSString *name2 = [NSString stringWithFormat:@"%@ leave", tag];
        
        CFTimeInterval time1 = [_tags[name1] doubleValue];
        CFTimeInterval time2 = CACurrentMediaTime();
        
        [_tags removeObjectForKey:name1];
        [_tags removeObjectForKey:name2];
        
        [self recordTagName:tag costTime:fabs(time2-time1)];
    }
}

- (void)recordTagName:(NSString *)tagName costTime:(NSTimeInterval)costTime
{
    NSLog(@"Time '%@' = %.0f(ms)", tagName, costTime);
}

@end
