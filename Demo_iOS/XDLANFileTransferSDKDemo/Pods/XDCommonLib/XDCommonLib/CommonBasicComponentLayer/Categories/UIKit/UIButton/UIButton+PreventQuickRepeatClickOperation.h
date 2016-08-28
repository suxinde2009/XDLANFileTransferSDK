//
//  UIButton+PreventQuickRepeatClickOperation.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/14.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (PreventQuickRepeatClickOperation)

/**
 *  保证按钮在一定的时间段内只处理一次点击事件
 *
 *  @param operation 点击事件执行操作
 *  @param delay     避免重复点击的延时
 */
- (void)executeOperation:(void(^)())operation withDelayForRepeatClick:(NSTimeInterval)delay;

@end
