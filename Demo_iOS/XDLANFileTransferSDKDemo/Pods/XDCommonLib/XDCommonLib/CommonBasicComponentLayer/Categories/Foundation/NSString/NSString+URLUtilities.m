//
//  NSString+URLUtilities.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSString+URLUtilities.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>


@implementation NSString (URLUtilities_Private)

+ (NSString *) md5:(NSString*)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end

@implementation NSString (URLUtilities)

- (NSDictionary *)parseURLParams
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    [pairs enumerateObjectsUsingBlock: ^(NSString *pair, NSUInteger idx, BOOL *stop) {
        NSArray *comps = [pair componentsSeparatedByString:@"="];
        if ([comps count] == 2)
        {
            [result setObject:[comps[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:comps[0]];
        }
    }];
    
    return result;
}

//linux时间戳
+ (NSString *)timestampForTransfer
{
    //服务端和客户端时间戳使用为距离1970的时间
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return timestamp;
}

//服务端指定的加密使用时区时间
+ (NSString *)hourStringForSecret
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //统一使用GMT+8，即东8区，服务端也是
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    [formatter setDateFormat:@"HH"];
    NSString *hourStr = [formatter stringFromDate:date];
    
    return hourStr;
}

//服务端指定的生成secret的算法
+ (NSString *)generateSecret:(NSString *)token hour:(NSString *)hourStr
{
    NSString *md5Token = [NSString md5:token];
    
    NSArray *indexes = @[@(2), @(4), @(7), @(9), @(12), @(22)];
    NSMutableString *key = [NSMutableString stringWithCapacity:6];
    for (NSNumber *index in indexes)
    {
        [key appendFormat:@"%c", [md5Token characterAtIndex:[index unsignedIntegerValue]]];
    }
    [key appendString:hourStr];
    NSString *goodKey = key;
    //因为服务端MD5加密之后都是小写的字母，而客户端这边是大写的，所以最后DES结果不同；客户端这边key要转换为小写的才好；
    goodKey = [goodKey lowercaseString];
    
    NSString *retVal = [self encryptUseDES:token key:goodKey];
    return retVal;
}

//使用DES加密
+ (NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSString *ciphertext = nil;
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String], kCCBlockSizeDES,
                                          NULL,
                                          [textData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [self stringWithHexBytes2:data];
    }
    else
    {
        NSLog(@"DES加密失败");
    }
    
    free(buffer);
    return ciphertext;
}

//nsdata转成16进制字符串
+ (NSString *)stringWithHexBytes2:(NSData *)sender
{
    static const char hexdigits[] = "0123456789ABCDEF";
    const size_t numBytes = [sender length];
    const unsigned char *bytes = [sender bytes];
    char *strbuf = (char *)malloc(numBytes * 2 + 1);
    char *hex = strbuf;
    NSString *hexBytes = nil;
    
    for (int i = 0; i < numBytes; ++i)
    {
        const unsigned char c = *bytes++;
        *hex++ = hexdigits[(c >> 4) & 0xF];
        *hex++ = hexdigits[(c) & 0xF];
    }
    
    *hex = 0;
    hexBytes = [NSString stringWithUTF8String:strbuf];
    
    free(strbuf);
    return hexBytes;
}

/**
 *  返回自适应label大小
 */
- (CGSize)calculateHeightWithWidth:(CGFloat)width font:(UIFont *)font numberOfLine:(NSInteger)lines
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    //    CGRect frame = label.frame;
    //    frame.size.width = width;
    //    label.frame = width;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.text = self;
    label.font = font;
    label.numberOfLines = lines;
    [label sizeToFit];
    return label.frame.size;
}


@end
