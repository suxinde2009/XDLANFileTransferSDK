//
//  NSLayoutConstraint+XDCommonLib.m
//  XDCommonLib
//
//  Created by suxinde on 16/6/8.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSLayoutConstraint+XDCommonLib.h"

@implementation NSLayoutConstraint (XDCommonLib)

- (BOOL)constraintRefersToView:(UIView *)view
{
    if (self == nil) {
        return NO;
    }
    
    if (!view)
        return NO;
    if (!self.firstItem) // shouldn't happen. Illegal
        return NO;
    if (self.firstItem == view)
        return YES;
    if (!self.secondItem)
        return NO;
    if (self.secondItem == view)
        return YES;
    return NO;
}

@end
