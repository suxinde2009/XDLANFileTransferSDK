//
//  UIStoryboard+LoadViewControllerFromStoryBoard.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/8.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (LoadViewControllerFromStoryBoard)

+ (UIViewController *)loadViewControllerFromStoryBoard:(NSString *)storyBoardName
                            viewControllerStoryboardID:(NSString *)viewControllerStoryboardID;
@end
