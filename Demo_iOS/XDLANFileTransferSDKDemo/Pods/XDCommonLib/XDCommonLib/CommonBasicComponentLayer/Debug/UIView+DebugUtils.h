//
//  UIView+DebugUtils.h
//  XDCommonLib
//
//  Created by su xinde on 15/11/26.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @brief UIView调试工具分类1
 */
@interface UIView (DebugUtils)

/**
 *  递归绘制该视图及其所有子视图的边框
 *
 *  @param b 是否递归绘制子视图的边框， NO则只绘制本身的边框
 */
- (void)drawBorderRecursive:(BOOL)b;

@end
