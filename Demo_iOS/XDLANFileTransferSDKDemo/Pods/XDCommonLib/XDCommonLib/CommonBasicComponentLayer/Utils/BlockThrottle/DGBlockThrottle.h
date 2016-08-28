//
//  DGBlockThrottle.h
//  DGBlockThrottle
//
//  Created by Daniel Cohen Gindi on 10/20/14.
//  Copyright (c) 2014 danielgindi@gmail.com. All rights reserved.
//
//  https://github.com/danielgindi/DGBlockThrottle
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Daniel Cohen Gindi (danielgindi@gmail.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import <Foundation/Foundation.h>


/*
 Arguments:
 
 `throttledBlock` is obviously the block that you want to throttle. The only kind of block accepted is a void returning, no-arguments block.
 
 `wait` is the amount of time (in seconds) to wait between calls to your block.
 `leading` means whether you want the first call to the throttle block to execute your block or not. This allows
 `trailing` means whether you want to have another call to your block issued after you have stopped calling the throttled block.

 */

/*
 A little utility to throttle calls to a block in ObjC. This is great for many uses, one of the most common is handling progress of a NSURLConnection request. Because you may receive many calls for new bytes, and may want to make sure you only call the progress delegate/block once every 150ms or so.
 
 Simply call it like this:
 
 void (^myThrottledBlock) = [DGBlockThrottle throttledBlock: myCodeBlock
                                                    onQueue: dispatch_get_main_queue()
                                                       wait: 0.3
                                                    leading: NO
                                                   trailing: YES];
 
 // Now we can call `myThrottledBlock()` many times, and `myCodeBlock` will only be called once every 300 ms!
 
 
 */

@interface DGBlockThrottle : NSObject

+ (void(^)())throttledBlock:(void (^)())block
                    onQueue:(dispatch_queue_t)queue
                       wait:(CFTimeInterval)wait;

+ (void(^)())throttledBlock:(void (^)())block
                    onQueue:(dispatch_queue_t)queue
                       wait:(CFTimeInterval)wait
                    leading:(BOOL)hasLeadingCall;

+ (void(^)())throttledBlock:(void (^)())block
                    onQueue:(dispatch_queue_t)queue
                       wait:(CFTimeInterval)wait
                   trailing:(BOOL)hasTrailingCall;

+ (void(^)())throttledBlock:(void (^)())block
                    onQueue:(dispatch_queue_t)queue
                       wait:(CFTimeInterval)wait
                    leading:(BOOL)hasLeadingCall
                   trailing:(BOOL)hasTrailingCall;

@end
