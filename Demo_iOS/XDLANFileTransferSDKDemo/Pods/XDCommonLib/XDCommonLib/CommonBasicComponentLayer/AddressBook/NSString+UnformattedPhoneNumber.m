//
//  NSString+UnformattedPhoneNumber.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/10.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSString+UnformattedPhoneNumber.h"

@implementation NSString (UnformattedPhoneNumber)

- (NSString *)unformattedPhoneNumber
{
    NSCharacterSet *toExclude = [NSCharacterSet characterSetWithCharactersInString:@"/.,()-+ "];
    return [[self componentsSeparatedByCharactersInSet:toExclude] componentsJoinedByString:@""];
}

@end
