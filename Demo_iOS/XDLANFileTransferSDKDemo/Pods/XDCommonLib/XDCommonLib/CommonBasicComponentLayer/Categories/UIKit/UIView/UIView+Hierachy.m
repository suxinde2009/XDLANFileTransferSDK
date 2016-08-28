//
//  UIView+Hierachy.m
//  XDCommonLib
//
//  Created by su xinde on 15/11/27.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import "UIView+Hierachy.h"

@implementation UIView (Hierachy)

// Recursively travel down the view tree, increasing the indentation level for children
- (void)dumpView:(UIView *)aView
        atIndent:(int)indent
            into:(NSMutableString *)outstring
{
    for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
    [outstring appendFormat:@"[%2d] %@\n", indent, [[aView class] description]];
    for (UIView *view in [aView subviews]) {
        [self dumpView:view atIndent:indent + 1 into:outstring];
    }
}

// Start the tree recursion at level 0 with the root view
- (NSString *)displayViews: (UIView *) aView
{
    NSMutableString *outstring = [[NSMutableString alloc] init];
    [self dumpView: aView atIndent:0 into:outstring];
    return outstring;
}

- (void)showViewHierarchy
{
    CFShow((__bridge CFTypeRef)([self displayViews: self]));
}

@end
