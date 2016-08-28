//
//  XDChineseMobilePhoneRegex.m
//  XDCommonLib
//
//  Created by suxinde on 16/6/1.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDChineseMobilePhoneRegex.h"

@implementation XDChineseMobilePhoneRegex

+ (BOOL)isValidChineseMobilePhont:(NSString *)mobilePhone
{
    NSString *validRegrex = @"(^(13\\d|15[^4,\\D]|17[13678]|18\\d)\\d{8}|170[^346,\\D]\\d{7})$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegrex];
    BOOL isValid = [pre evaluateWithObject:mobilePhone];
    return isValid;
}


@end
