//
//  UIViewController+IB.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "UIViewController+IB.h"

@implementation UIViewController (IB)

+ (instancetype)instanceFromIB {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSString *name = NSStringFromClass(self);
    return [self instanceFromStoryBoard:sb name:name];
}

+ (instancetype)instanceFromStoryBoardName:(NSString*)storyBoardName {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    NSString *name = NSStringFromClass(self);
    return [self instanceFromStoryBoard:sb name:name];
}

+ (instancetype)instanceFromStoryBoard:(UIStoryboard*)sb {
    NSString *name = NSStringFromClass(self);
    return [self instanceFromStoryBoard:sb name:name];
}

+ (instancetype)instanceFromStoryBoard:(UIStoryboard*)sb name:(NSString*)name {
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:name];
    return vc;
}

@end
