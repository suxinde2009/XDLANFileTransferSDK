//
//  UIColor+iOS7.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/18.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "UIColor+iOS7.h"

@interface UIAColorComponents : NSObject {
    CGFloat _components[4];
}

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

- (id)initWithColor:(UIColor *)color;

+ (id)componentsWithColor:(UIColor *)color;

@end

@implementation UIAColorComponents

- (id)initWithColor:(UIColor *)color
{
    self = [super init];
    if (self != nil)
    {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        self->_components[0] = components[0];
        self->_components[1] = components[1];
        self->_components[2] = components[2];
        self->_components[3] = components[3];
    }
    return self;
}

+ (id)componentsWithColor:(UIColor *)color
{
    return [(UIAColorComponents *)[self alloc] initWithColor:color];
}

- (CGFloat)red
{
    return self->_components[0];
}

- (CGFloat)green
{
    return self->_components[1];
}

- (CGFloat)blue
{
    return self->_components[2];
}

- (CGFloat)alpha
{
    return self->_components[3];
}


@end

@implementation UIColor (ShortCuts)

- (UIAColorComponents *)components
{
    return [UIAColorComponents componentsWithColor:self];
}

@end

@implementation UIColor (iOS7)

- (id)initWith8bitWhite:(UInt8)white
                  alpha:(UInt8)alpha
{
    return [self initWithWhite:white / 255.0f alpha:alpha / 255.0f];
}

- (id)initWith8bitRed:(UInt8)red
                green:(UInt8)green
                 blue:(UInt8)blue
                alpha:(UInt8)alpha
{
    return [self initWithRed:red / 255.0f
                       green:green / 255.0f
                        blue:blue / 255.0f
                       alpha:alpha / 255.0f];
}

+ (id)colorWith8bitRed:(UInt8)red
                 green:(UInt8)green
                  blue:(UInt8)blue
                 alpha:(UInt8)alpha
{
    return [[self alloc] initWith8bitRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWith8bitWhite:(UInt8)white
                          alpha:(UInt8)alpha
{
    return [[self alloc] initWith8bitWhite:white alpha:alpha];
}

+ (UIColor *)defaultTintColor
{
    return [UIColor colorWith8bitRed:0 green:126 blue:245 alpha:255];
}

+ (UIColor *)iOS7BackgroundColor
{
    return [UIColor colorWith8bitRed:246 green:246 blue:246 alpha:255];
}

+ (UIColor *)iOS7ButtonTitleColor
{
    return [UIColor colorWith8bitRed:16 green:134 blue:255 alpha:255];
}

+ (UIColor *)iOS7ButtonTitleEmphasizedColor
{
    return [UIColor colorWith8bitRed:255 green:69 blue:55 alpha:255];
}

- (UIColor *)highligtedColor
{
    return [UIColor colorWithRed:0.75f + self.components.red / 4.0f
                           green:0.75f + self.components.green / 4.0f
                            blue:0.75f + self.components.blue / 4.0f
                           alpha:self.components.alpha];
}

+ (UIColor *)groupTableViewBackgroundColor
{
    return [UIColor colorWith8bitRed:239 green:239 blue:244 alpha:255];
}

- (UIImage *)imageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, (CGRect) {.size = size });
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)image
{
    return [self imageWithSize:(CGSize) {.width = 1.0, .height = 1.0 }];
}

- (NSString *)hexString
{
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    
    static NSString *stringFormat = @"%02x%02x%02x";
    
    // Grayscale
    if (count == 2)
    {
        NSUInteger white = (NSUInteger)(components[0] * (CGFloat)255);
        return [NSString stringWithFormat:stringFormat, white, white, white];
    }
    
    // RGB
    else if (count == 4)
    {
        return [NSString stringWithFormat:stringFormat, (NSUInteger)(components[0] * (CGFloat)255),
                (NSUInteger)(components[1] * (CGFloat)255), (NSUInteger)(components[2] * (CGFloat)255)];
    }
    
    return nil;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    if ([hexString length] != 6)
    {
        return nil;
    }
    
    // Brutal and not-very elegant test for non hex-numeric characters
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-fA-F|0-9]" options:0 error:NULL];
    NSUInteger match = [regex numberOfMatchesInString:hexString
                                              options:NSMatchingWithTransparentBounds
                                                range:NSMakeRange(0, [hexString length])];
    
    if (match != 0)
    {
        return nil;
    }
    
    NSRange rRange = NSMakeRange(0, 2);
    NSString *rComponent = [hexString substringWithRange:rRange];
    unsigned int rVal = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:rComponent];
    [rScanner scanHexInt:&rVal];
    float rRetVal = (float)rVal / 254;
    
    
    NSRange gRange = NSMakeRange(2, 2);
    NSString *gComponent = [hexString substringWithRange:gRange];
    unsigned int gVal = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:gComponent];
    [gScanner scanHexInt:&gVal];
    float gRetVal = (float)gVal / 254;
    
    NSRange bRange = NSMakeRange(4, 2);
    NSString *bComponent = [hexString substringWithRange:bRange];
    unsigned int bVal = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:bComponent];
    [bScanner scanHexInt:&bVal];
    float bRetVal = (float)bVal / 254;
    
    return [UIColor colorWithRed:rRetVal green:gRetVal blue:bRetVal alpha:1.0f];
}


@end

@implementation UIColor (Graphics)

- (UIColor *)highligtedColor
{
    return [UIColor colorWithRed:0.75f + self.components.red / 4.0f
                           green:0.75f + self.components.green / 4.0f
                            blue:0.75f + self.components.blue / 4.0f
                           alpha:self.components.alpha];
}

- (UIImage *)imageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, (CGRect) {.size = size });
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)image
{
    return [self imageWithSize:(CGSize) {.width = 1.0, .height = 1.0 }];
}

@end

