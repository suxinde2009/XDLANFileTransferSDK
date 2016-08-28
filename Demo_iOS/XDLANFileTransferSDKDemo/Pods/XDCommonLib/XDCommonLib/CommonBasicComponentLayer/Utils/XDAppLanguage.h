//
//  XDAppLanguage.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDAppLanguage : NSObject

/**
 *  程序当前语言
 *
 *  @return 语言 ("zh-Hans"/"zh-Hant"/"en"...)
 */
+ (NSString *)currentLanguage;

/**
 *  当前系统语言是否是中文 (简体中文或者繁体中文)
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageZH;

/**
 *  当前系统语言是否是简体中文
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageZHHANS;


/**
 *  当前系统语言是否是繁体中文
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageZHHANT;

/**
 *  当前系统语言是否是繁体中文（香港）
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageZHHK;

/**
 *  当前系统语言是否是英文
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageEN;

/**
 *  当前系统语言是否是日文
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageJA;

/**
 *  当前系统语言是否是泰语
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageTHAI;

/**
 *  当前系统语言是否是印尼语
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageID;

/**
 *  当前系统语言是否包含在提供的语言数组之一
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageContainedIn:(NSArray*)languages;

/**
 *  不支持当前系统语言（按英文处理)
 *
 *  @return YES 是 NO 不是
 */
+ (BOOL)isCurrentLanguageUnsupported;

@end
