//
//  UIViewController+IB.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (IB)

/*!
 用于创建来自Main storyboard 下storyboard id和本类的名字一样的的控制器
 */
+ (instancetype)instanceFromIB;

+ (instancetype)instanceFromStoryBoardName:(NSString*)storyBoardName;

+ (instancetype)instanceFromStoryBoard:(UIStoryboard*)sb;

+ (instancetype)instanceFromStoryBoard:(UIStoryboard*)sb name:(NSString*)name;

@end
