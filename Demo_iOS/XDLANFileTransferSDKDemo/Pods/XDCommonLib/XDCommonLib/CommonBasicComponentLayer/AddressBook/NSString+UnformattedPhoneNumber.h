//
//  NSString+UnformattedPhoneNumber.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/10.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UnformattedPhoneNumber)

/**
 *  去除手机号中 “/.,()-+ ”等字符
 */
- (NSString *)unformattedPhoneNumber;

@end
