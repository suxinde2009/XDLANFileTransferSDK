//
//  NSString+Utils.m
//  CoreFramework
//
//  Created by Su XinDE on 14-3-10.
//  Copyright (c) 2014年 Su XinDE. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Utils)

+ (BOOL)validatEmail:(NSString *)emailAddress
{
	if([NSString isNullOrEmpty:emailAddress])
		return FALSE;
	
	NSString *stricterFilterString =
    //    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    //    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    //    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    //    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    //    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    //    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    //    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilterString ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailAddress];
}

+ (BOOL)isNullOrEmpty:(NSString *)s
{
    if(s == nil ||
       s.length == 0 ||
       [s isEqualToString:@""] ||
       [s isEqualToString:@"(null)"])
    {
        return YES;
    }
    
    return NO;
}


- (BOOL)hasSubString:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    if(range.location == NSNotFound)
        return FALSE;
    return TRUE;
}

- (BOOL)hasSubString:(NSString *)string options:(NSStringCompareOptions)mask
{
    NSRange range = [self rangeOfString:string options:mask];
    if(range.location == NSNotFound)
        return FALSE;
    return TRUE;
}

// 处理url中含有中文乱码的问题
- (id)urlEncoded
{
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,
                                                                             NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}

- (NSString*)urlDecoded
{
	NSString *result = (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
	return result;
}

/*
 要分台湾手机号还是大陆手机号，需要一组正则表达式根据情况判断
 ⑴台湾手机10位数，皆以09起头，拨打台湾手机，先拨台湾的国际区码00886，接着拨去起头0的手机号码，譬如0960XXXXXX，则拨00886-960XXXXXX
 ⑵台湾座机号码，县市区码2-3位数（以0起头），电话号码6-8位数，拨打台湾座机，先拨台湾的国际区码00886，接着拨去起头0的县市区码，最后拨电话号码，
 譬如台北市电话02-8780XXXX，则拨00886-2-8780XXXX，另一例是台东县电话，089-345XXX，则拨00886-89-345XXX
 */
// 检验手机号 大陆 跟 台湾 两种格式
//+ (BOOL)validateMobile:(NSString *)mobile
//{
//    if([NSString isNullOrEmpty:mobile])
//        return FALSE;
//    if(mobile.length < 10) return FALSE;
//    NSString *phoneRegex = @"^(((13[0-9])|(14[5,7])|(15[^4,\\D])|(18[0-9]))\\d{8})|(09\\d{8})$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:mobile];
//    return TRUE;
//}


////////////

- (CGSize)wrapString:(float)width
            fontSize:(float)fontSize
              isBold:(BOOL)isBold
{
    UIFont *font = isBold? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize];
    CGSize size  = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    return size;
}

- (float)wrapStringHeight:(float)width
                 fontSize:(float)fontSize
                   isBold:(BOOL)isBold
{
    return [self wrapString:width fontSize:fontSize isBold:isBold].height;
}

+ (NSString *)trimAngleBracketsAndBlanks:(NSString *)str
{
    if (str == nil) {
        return nil;
    }
    if (str.length == 0) {
        return nil;
    }
    if ([str isEqualToString:@" "]) {
        return nil;
    }
    
    NSString *s = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@">" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return s;
}

+ (NSString *)trimShortHorizontalBar:(NSString *)str
{
    if (str == nil) {
        return nil;
    }
    if (str.length == 0) {
        return nil;
    }
    if ([str isEqualToString:@" "]) {
        return nil;
    }
    
    NSString *s = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return s;
}


//////
+ (BOOL)isIPAddress:(NSString *)str
{
	NSArray *			components = [str componentsSeparatedByString:@"."];
	NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
	
	if ( [components count] == 4 )
	{
		NSString *part1 = [components objectAtIndex:0];
		NSString *part2 = [components objectAtIndex:1];
		NSString *part3 = [components objectAtIndex:2];
		NSString *part4 = [components objectAtIndex:3];
		
		if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
		{
			if ( [part1 intValue] < 255 &&
                [part2 intValue] < 255 &&
                [part3 intValue] < 255 &&
                [part4 intValue] < 255 )
			{
				return YES;
			}
		}
	}
	
	return NO;
}

+ (BOOL)isUrl:(NSString *)str
{
    NSString *		regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL retValue = [pred evaluateWithObject:str];
	return retValue;
}


//

+ (BOOL)validateMobile:(NSString *)mobile
{
    return [[self class] isPhoneFormatValid:mobile phoneFormat:@"CN|TW"];
}

+ (BOOL)isPhoneFormatValid:(NSString *)mobile
               phoneFormat:(NSString *)phoneFormat // CN, TW , CN|TW
{
    
    if ([[self class] isNullOrEmpty:mobile]) {
        return FALSE;
    }
    if(mobile.length < 10) return FALSE;
    
    NSString *phoneRegex = @"^(((13[0-9])|(14[5,7])|(15[^4,\\D])|(18[0-9]))\\d{8})|(09\\d{8})$";
    if ([phoneFormat isEqualToString:@"CN"]) {
        phoneRegex = @"^(((13[0-9])|(14[5,7])|(15[^4,\\D])|(18[0-9]))\\d{8})$";
    }else if ([phoneFormat isEqualToString:@"TW"]) {
        phoneRegex = @"^(09\\d{8})$";
    }else {
        phoneRegex = @"^(((13[0-9])|(14[5,7])|(15[^4,\\D])|(18[0-9]))\\d{8})|(09\\d{8})$";
    }
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
    return TRUE;
    
}

+ (BOOL)isEmailFormatValid:(NSString *)email
{
    if ([[self class] isNullOrEmpty:email]) {
        return FALSE;
    }
    
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilterString ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



@end
