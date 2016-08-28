//
//  XDDebugStatusBar.h
//  XDCommonLib
//
//  Created by su xinde on 15/11/26.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XDSingleton.h"

@interface XDDebugStatusBar : UIWindow

DEF_SINGLETON
@property (readonly, nonatomic) UIButton *debugButton;

+ (void)attach;

@end
