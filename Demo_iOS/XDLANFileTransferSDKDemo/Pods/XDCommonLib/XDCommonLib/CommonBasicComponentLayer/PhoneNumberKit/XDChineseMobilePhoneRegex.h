//
//  XDChineseMobilePhoneRegex.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/1.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 电信
 2G/3G号段（CDMA2000网络）133、153、180、181、189
 4G号段 177、173
 
 联通
 2G号段（GSM网络）130、131、132、155、156
 3G上网卡145
 3G号段（WCDMA网络）185、186
 4G号段 176、185
 
 移动
 2G号段（GSM网络）有134x（0-8）、135、136、137、138、139、150、151、152、158、159、182、183、184。
 3G号段（TD-SCDMA网络）有157、187、188
 3G上网卡 147
 4G号段 178、184
 
 卫星通信 1349
 
 
 虚拟运营商号码段：
 
 电信 1700、1701、1702
 联通 1707、1708、1709、171
 移动 1705
 
 
 整理如下：
 
 ```
 130、131、132、133、134、135、136、137、138、139
 150、151、152、153、155、156、157、158、159
 173、176、177、178
 180、181、182、183、184、185、186、187、188、189
 171、1700、1701、1702、1705、1707、1708、1709
 ```
 */


@interface XDChineseMobilePhoneRegex : NSObject

+ (BOOL)isValidChineseMobilePhont:(NSString *)mobilePhone;

@end
