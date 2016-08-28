//
//  NSObject+XD_KVO.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/9.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

// 参考: http://tech.glowing.com/cn/implement-kvo/

typedef void(^XDObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (XD_KVO)

- (void)XD_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(XDObservingBlock)block;

- (void)XD_removeObserver:(NSObject *)observer
                   forKey:(NSString *)key;

@end
