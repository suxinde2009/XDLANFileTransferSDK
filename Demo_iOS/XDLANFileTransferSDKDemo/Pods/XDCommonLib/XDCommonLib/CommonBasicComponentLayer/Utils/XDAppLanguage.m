//
//  XDAppLanguage.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDAppLanguage.h"

@implementation XDAppLanguage

+ (NSString *)currentLanguage
{
    NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
    NSString *currentLanguage = [languages firstObject];
    return currentLanguage;
}

+ (BOOL)isEqualToLanguage:(NSString*)language
{
    return [[self currentLanguage] compare:language options:NSCaseInsensitiveSearch] == NSOrderedSame;
}

+ (BOOL)isCurrentLanguageZH
{
    return [self isCurrentLanguageZHHANS] || [self isCurrentLanguageZHHANT] || [self isCurrentLanguageZHHK];
}

+ (BOOL)isCurrentLanguageZHHANS
{
    return [self isEqualToLanguage:@"zh-Hans"];
}

+ (BOOL)isCurrentLanguageZHHANT
{
    return [self isEqualToLanguage:@"zh-Hant"];
}

+ (BOOL)isCurrentLanguageZHHK
{
    return [self isEqualToLanguage:@"zh-HK"];
}

+ (BOOL)isCurrentLanguageEN
{
    return [[self currentLanguage] hasPrefix:@"en"];
}

+ (BOOL)isCurrentLanguageJA
{
    return [self isEqualToLanguage:@"ja"];
}

+ (BOOL)isCurrentLanguageTHAI
{
    return [self isEqualToLanguage:@"th"];
}

+ (BOOL)isCurrentLanguageID
{
    return [self isEqualToLanguage:@"id"];
}

+ (BOOL)isCurrentLanguageUnsupported
{
    BOOL isSupported = [[self class] isCurrentLanguageZH]
    || [[self class] isCurrentLanguageEN]
    || [[self class] isCurrentLanguageJA]
    || [[self class] isCurrentLanguageTHAI]
    || [[self class] isCurrentLanguageID];
    return !isSupported;
}

+ (BOOL)isCurrentLanguageContainedIn:(NSArray*)languages
{
    BOOL isContained = NO;
    NSString *currenLaguage = [self currentLanguage];
    
    for (NSString *language in languages) {
        if ([language isKindOfClass:[NSString class]] &&
            [currenLaguage compare:language options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            isContained = YES;
            break;
        }
    }
    
    return isContained;
}

@end
