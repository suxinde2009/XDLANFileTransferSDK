//
//  XDMulticastDelegateBase.m
//  XDCommonLib
//
//  Created by suxinde on 16/4/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDMulticastDelegateBase.h"
#import "XDMulticastDelegate.h"

@implementation XDMulticastDelegateBase

- (id)init {
    return [self initWithDispatchQueue:NULL];
}

- (id)initWithDispatchQueue:(dispatch_queue_t)queue
{
    if ((self = [super init])) {
        if (queue) {
            _moduleQueue = queue;
        } else {
            const char *moduleQueueName = [NSStringFromClass([self class]) UTF8String];
            _moduleQueue = dispatch_queue_create(moduleQueueName, NULL);
        }
        
        _moduleQueueTag = &_moduleQueueTag;
        dispatch_queue_set_specific(_moduleQueue,
                                    _moduleQueueTag,
                                    _moduleQueueTag,
                                    NULL);
        
        _multicastDelegate = [[XDMulticastDelegate alloc] init];
    }
    return self;
}

- (dispatch_queue_t)moduleQueue
{
    return _moduleQueue;
}

- (void *)moduleQueueTag
{
    return _moduleQueueTag;
}

- (void)addDelegate:(id)delegate
{
    return [self addDelegate:delegate
               delegateQueue:dispatch_get_main_queue()];
}

- (void)addDelegate:(id)delegate
      delegateQueue:(dispatch_queue_t)delegateQueue
{
    dispatch_block_t block = ^{
        [_multicastDelegate addDelegate:delegate
                          delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(_moduleQueueTag)) {
        block();
    }else {
        dispatch_async(_moduleQueue, block);
    }
}

- (void)removeDelegate:(id)delegate
         delegateQueue:(dispatch_queue_t)delegateQueue
         synchronously:(BOOL)synchronously
{
    dispatch_block_t block = ^{
        [_multicastDelegate removeDelegate:delegate
                             delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(_moduleQueueTag)) {
        block();
    }else if (synchronously) {
        dispatch_sync(_moduleQueue, block);
    }else {
        dispatch_async(_moduleQueue, block);
    }
}

- (void)removeDelegate:(id)delegate
         delegateQueue:(dispatch_queue_t)delegateQueue
{
    [self removeDelegate:delegate
           delegateQueue:delegateQueue
           synchronously:YES];
}

- (void)removeDelegate:(id)delegate
{
    [self removeDelegate:delegate
           delegateQueue:NULL
           synchronously:YES];
}


@end
