//
//  UIView+DebugUtils.m
//  XDCommonLib
//
//  Created by su xinde on 15/11/26.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import "UIView+DebugUtils.h"

@implementation UIView (DebugUtils)

- (void)drawBorderRecursive:(BOOL)b
{
#ifdef DEBUG
    [self drawBorder:self];
    if (b) {
        [self drawBorderRec:self];
    }
#endif
}

- (void)drawBorderRec:(UIView *)view
{
    for (UIView *v in [view subviews]) {
        [self drawBorderRec:v];
        [self drawBorder:v];
    }
}

- (void)drawBorder:(UIView *)view
{
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor colorWithRed:(arc4random()%10/10.0)
                                             green:(arc4random()%10/10.0)
                                              blue:(arc4random()%10/10.0)
                                             alpha:1].CGColor;
}


@end
