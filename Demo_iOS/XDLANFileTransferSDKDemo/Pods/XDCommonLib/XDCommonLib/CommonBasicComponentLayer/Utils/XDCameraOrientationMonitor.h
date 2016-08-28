//
//  XDCameraOrientationMonitor.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const kXDCameraOrientationMonitorDidChangeNotification;

/**
 *  摄像机朝向监听类
 */
@interface XDCameraOrientationMonitor : NSObject

@property (readonly, nonatomic) UIDeviceOrientation orientation;

+ (instancetype)monitor;

- (NSInteger)updateEmitterOrientationWithCamera:(BOOL)isFront
                                    frontMirror:(BOOL)isForntMirror;

- (NSString*)getOrientationString;

- (UIImageOrientation)getUIImageOrientationFromUIDeviceOrientation:(BOOL)isFront
                                                       frontMirror:(BOOL)isForntMirror;

@end
