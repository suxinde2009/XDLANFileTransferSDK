//
//  XDMulticastDelegateBase.h
//  XDCommonLib
//
//  Created by suxinde on 16/4/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDMulticastDelegateBase : NSObject {
   @package
    id _multicastDelegate;
    dispatch_queue_t _moduleQueue;
    void *_moduleQueueTag;
}
@property (nonatomic, readonly) id multicastDelegate;

- (id)init;

- (id)initWithDispatchQueue:(dispatch_queue_t)queue;

@property (readonly) dispatch_queue_t moduleQueue;
@property (readonly) void *moduleQueueTag;

- (void)addDelegate:(id)delegate;

- (void)addDelegate:(id)delegate
      delegateQueue:(dispatch_queue_t)delegateQueue;

- (void)removeDelegate:(id)delegate
         delegateQueue:(dispatch_queue_t)delegateQueue;

- (void)removeDelegate:(id)delegate;

@end
