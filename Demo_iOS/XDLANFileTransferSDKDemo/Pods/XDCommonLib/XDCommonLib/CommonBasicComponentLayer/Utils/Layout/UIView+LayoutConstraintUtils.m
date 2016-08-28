//
//  UIView+LayoutConstraintUtils.m
//  XDCommonLib
//
//  Created by suxinde on 16/6/8.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "UIView+LayoutConstraintUtils.h"

@implementation UIView (LayoutConstraintUtils)

- (void)stretchToFullFillSuperView:(UIView*)view {
    NSDictionary *bindings = NSDictionaryOfVariableBindings(view);
    NSString *formatTemplate = @"%@:|[view]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [view.superview addConstraints:constraints];
    }
    
}

@end
