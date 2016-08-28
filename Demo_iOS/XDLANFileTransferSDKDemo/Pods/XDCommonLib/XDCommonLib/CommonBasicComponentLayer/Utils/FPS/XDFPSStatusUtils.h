//
//  XDFPSStatus.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  FPS 调试工具
 */
@interface XDFPSStatusUtils : NSObject

@property (nonatomic,strong) UILabel *fpsLabel;

+ (instancetype)sharedInstance;

- (void)open;

- (void)openWithHandler:(void (^)(NSInteger fpsValue))handler;

- (void)close;

@end
