//
//  XDPinYin.h
//  XDCommonLib
//
//  Created by SuXinDe on 16/5/25.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDPinYin : NSObject

+ (NSString *)convert:(NSString *) hzStr;//输入中文，返回拼音。

+ (NSString *)quickConvert:(NSString *)hzStr;

+ (void)clearCache;

@end
