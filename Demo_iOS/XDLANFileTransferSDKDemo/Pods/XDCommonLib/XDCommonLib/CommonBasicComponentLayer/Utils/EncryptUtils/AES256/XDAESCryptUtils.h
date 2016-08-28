//
//  XDAESCryptUtils.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/23.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDAESCryptUtils : NSObject

+ (NSString *)encrypt:(NSString *)message
             password:(NSString *)password;

+ (NSString *)decrypt:(NSString *)base64EncodedString
             password:(NSString *)password;

+ (NSString *)encrypt:(NSString *)message
             password:(NSString *)password
                   iv:(NSData *)iv;

+ (NSString *)decrypt:(NSString *)base64EncodedString
             password:(NSString *)password
                   iv:(NSData *)iv;

@end
