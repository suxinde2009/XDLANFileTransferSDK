//
//  NSString+XD_Encrypt_MD5.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/23.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XD_Encrypt_MD5)

+ (NSString *)MD5:(NSString *)source;

@end

@interface NSString (XD_Encrypt_StringToHexData)

- (NSData *)stringToHexData;

@end

@interface NSData (XD_Encrypt_DataToHexString)

- (NSString *)dataToHexString;

@end
