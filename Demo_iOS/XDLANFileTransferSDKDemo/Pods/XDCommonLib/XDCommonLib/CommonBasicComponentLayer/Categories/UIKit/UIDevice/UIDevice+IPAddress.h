//
//  UIDevice+IPAddress.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/20.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (IPAddress)

+ (NSString *)getIPAddress:(BOOL)isIPv4;

@end
