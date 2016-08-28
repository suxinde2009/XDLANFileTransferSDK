//
//  NSObject+Abstract.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/17.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Abstract)

/**
 Message sent when an implementation wants to explicitly require a subclass to implement a method.
 Blatantly copied from NSObject+GNUstepBase.
 */
- (id)subclassResponsibility:(SEL)aSel;

@end
