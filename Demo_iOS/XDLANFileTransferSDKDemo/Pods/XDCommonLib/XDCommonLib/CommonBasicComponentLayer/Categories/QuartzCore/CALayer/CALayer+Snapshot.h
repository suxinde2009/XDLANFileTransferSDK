//
//  CALayer+Snapshot.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Snapshot)

/**
 *  生成Layer截图
 *
 *  @return 截图图片
 */
- (UIImage *)snapshot;

@end
