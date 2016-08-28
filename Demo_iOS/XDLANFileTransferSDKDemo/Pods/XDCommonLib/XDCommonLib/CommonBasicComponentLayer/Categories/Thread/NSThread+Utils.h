//
//  NSThread+Utils.h
//  XDCommonLib
//
//  Created by su xinde on 15/11/18.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

// The dispatch_cancel_block_t takes as parameter the "cancel" directive to suspend the block execution or not whenever the block to execute is dispatched.
// The return value is a boolean indicating if the block has already been executed or not.
typedef BOOL (^dispatch_cancel_block_t)(BOOL cancelBlock);

/**
 *  Runs a block in the main thread
 *
 *  @param ^block Block to be executed
 */
NS_INLINE void XDRunOnMainThread(void  (^ _Nonnull block)(void)) {
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

NS_INLINE void xd_dispatch_async_cancelLable(_Nonnull dispatch_queue_t queue,  BOOL * _Nullable cancel, _Nonnull dispatch_block_t block) {
    
    if ((*cancel) == YES) {
        return;
    }
    dispatch_async(queue, ^{
        if ((*cancel) == YES) {
            return;
        }
        if (block) {
            block();
        }
    });
}


@interface NSThread (Utils)

@end
