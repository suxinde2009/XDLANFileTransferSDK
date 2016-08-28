//
//  NSString+URLUtilities.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface NSString (URLUtilities)

- (NSDictionary *)parseURLParams;

//linux时间戳
+ (NSString *)timestampForTransfer;

//服务端指定的加密使用时区时间
+ (NSString *)hourStringForSecret;

//服务端指定的生成secret的算法
+ (NSString *)generateSecret:(NSString *)token hour:(NSString *)hourStr;

// 计算文本高度
- (CGSize)calculateHeightWithWidth:(CGFloat)width
                              font:(UIFont *)font
                      numberOfLine:(NSInteger)lines;

@end
