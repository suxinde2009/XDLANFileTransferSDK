//
//  UIStoryboard+LoadViewControllerFromStoryBoard.m
//  XDCommonLib
//
//  Created by suxinde on 16/6/8.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "UIStoryboard+LoadViewControllerFromStoryBoard.h"

@implementation UIStoryboard (LoadViewControllerFromStoryBoard)

+ (UIViewController *)loadViewControllerFromStoryBoard:(NSString *)storyBoardName
                            viewControllerStoryboardID:(NSString *)viewControllerStoryboardID
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerStoryboardID];
    return viewController;
}

@end
