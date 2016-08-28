//
//  UIColor+iOS7.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/18.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

///---------------------------------------------------------------------------
/// @name Creating colors
///---------------------------------------------------------------------------
#define RGBCOLOR(r, g, b) \
[UIColor colorWithRed: r / 255.f green: g / 255.f blue: b / 255.f alpha: 1.f]

#define RGBACOLOR(r, g, b, a) \
[UIColor colorWithRed: r / 255.f green: g / 255.f blue: b / 255.f alpha: a]


@interface UIColor (iOS7)

+ (UIColor *)defaultTintColor;

+ (UIColor *)iOS7BackgroundColor;

+ (UIColor *)iOS7ButtonTitleColor;

+ (UIColor *)iOS7ButtonTitleEmphasizedColor;

+ (UIColor *)groupTableViewBackgroundColor;

- (UIColor *)highligtedColor;

- (NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

- (UIImage *)image;

- (UIImage *)imageWithSize:(CGSize)size;

+ (id)colorWith8bitRed:(UInt8)red
                 green:(UInt8)green
                  blue:(UInt8)blue
                 alpha:(UInt8)alpha;

@end

@interface UIColor (Graphics)

- (UIColor *)highligtedColor;

@end