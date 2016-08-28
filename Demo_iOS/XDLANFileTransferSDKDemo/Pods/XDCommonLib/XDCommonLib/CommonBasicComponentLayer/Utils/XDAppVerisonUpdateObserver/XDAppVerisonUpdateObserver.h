//
//  XDAppVerObserver.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/9.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDAppVerisonUpdateObserver : NSObject

/**
 *  同步当前包版本号到NSUserDefaults中
 */
+ (void)sycAppVerToCurrent;

/**
 *  通过当前包版本号跟NSUserDefaults中的版本号对比，判断包是否覆盖安装
 *
 *  @return YES 包覆盖安装 NO 包未覆盖安装
 */
+ (BOOL)isAppVersionChanged;

@property (nonatomic, copy) NSString *endPointUrl;
@property (nonatomic, copy) NSString *customAlertTitle;
@property (nonatomic, copy) NSString *customAlertBody;

- (void) executeVersionCheck;

@end
