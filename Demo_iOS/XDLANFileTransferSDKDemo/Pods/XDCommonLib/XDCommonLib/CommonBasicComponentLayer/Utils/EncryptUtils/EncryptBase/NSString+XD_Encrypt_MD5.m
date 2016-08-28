//
//  NSString+XD_Encrypt_MD5.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/23.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSString+XD_Encrypt_MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (XD_Encrypt_MD5)

+ (NSString *)MD5:(NSString *)source
{
    const char *ptr = [source UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x",md5Buffer[i]];
    
    return [output lowercaseString];
}

@end


@implementation NSString (XD_Encrypt_StringToHexData)

//
// Decodes an NSString containing hex encoded bytes into an NSData object
//
- (NSData *)stringToHexData {
    
    NSInteger len = [self length] / 2; // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}

@end

@implementation NSData (XD_Encrypt_DataToHexString)

- (NSString *)dataToHexString {
    
    NSUInteger len = [self length];
    char * chars = (char *)[self bytes];
    NSMutableString * hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
    
    return hexString;
}

@end