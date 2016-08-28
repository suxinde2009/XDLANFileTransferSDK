//
//  NSString+XD_EncryptBase64.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/23.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XD_EncryptBase64)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

@end
