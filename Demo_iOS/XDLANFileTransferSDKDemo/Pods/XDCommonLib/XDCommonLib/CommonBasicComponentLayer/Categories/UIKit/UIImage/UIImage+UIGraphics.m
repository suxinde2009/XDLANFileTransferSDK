//
//  UIImage+UIGraphics.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/18.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "UIImage+UIGraphics.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>


///---------------------------------------------------------------------------
/// @name Creating colors
///---------------------------------------------------------------------------
#define __RGBCOLOR(r, g, b) \
[UIColor colorWithRed: r / 255.f green: g / 255.f blue: b / 255.f alpha: 1.f]

#define __RGBACOLOR(r, g, b, a) \
[UIColor colorWithRed: r / 255.f green: g / 255.f blue: b / 255.f alpha: a]

@interface UIColor (UIGraphics_Private)

- (UIImage *)imageWithSize:(CGSize)size;

- (UIImage *)image;

@end

@implementation UIColor (UIGraphics_Private)

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

@implementation UIImage (UIGraphics)

+ (UIImage *) roundImageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *) roundImageWithColor:(UIColor *)color
                      borderColor:(UIColor *)borderColor
                             size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    
    if (borderColor)
    {
        CGFloat lineWidth = 2.f;
        CGContextSetLineWidth(context, lineWidth);
        
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextStrokeEllipseInRect(context, CGRectMake(lineWidth / 2, lineWidth / 2, size.width - lineWidth, size.height - lineWidth));
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *) roundedImageWithSize:(CGSize)size color:(UIColor *)color radius:(CGFloat)radius
{
    CGRect rect = CGRectZero;
    
    rect.size = size;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    return [UIImage imageWithBezierPath:path color:color backgroundColor:color];
}

+ (UIImage *) imageWithBezierPath:(UIBezierPath *)path color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor
{
    UIGraphicsBeginImageContextWithOptions(path.bounds.size, NO, [UIScreen mainScreen].scale);
    
    if (backgroundColor)
    {
        [backgroundColor set];
        [path fill];
    }
    if (color)
    {
        [color set];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) clearImage
{
    static __strong UIImage *image = nil;
    
    if (image == nil)
    {
        image = [[UIColor clearColor] imageWithSize:(CGSize) { .width = 1.0, .height = 1.0 }];
    }
    return image;
}

+ (UIImage *) clearImageWithSize:(CGSize)size
{
    UIImage *image = [[UIColor clearColor] imageWithSize:(CGSize) { .width = 2, .height = 40 }];
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2
                                       topCapHeight:image.size.height / 2];
    return image;
}




+ (UIImage *) lightBlueImageWithSize:(CGSize)size
{
    UIImage *image = [UIImage roundImageWithColor:__RGBCOLOR(73, 150, 251) size:size];
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2
                                       topCapHeight:image.size.height / 2];
    return image;
}

+ (UIImage *) darkBlueImageWithSize:(CGSize)size
{
    UIImage *image = [UIImage roundImageWithColor:__RGBCOLOR(17, 96, 210) size:size];
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2
                                       topCapHeight:image.size.height / 2];
    return image;
}

+ (UIImage *) darkGreenImage
{
    static __strong UIImage *darkGreenImage = nil;
    
    if (darkGreenImage == nil)
    {
        UIImage *image = [UIImage roundImageWithColor:__RGBCOLOR(89, 188, 90) size:CGSizeMake(40, 40)];
        darkGreenImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2
                                                    topCapHeight:image.size.height / 2];
    }
    return darkGreenImage;
}

- (UIImage *) imageByFilledWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    [color set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = CGRectZero;
    bounds.size = self.size;
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, bounds, self.CGImage);
    CGContextFillRect(context, bounds);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
+ (UIImage *) imageWithColor:(UIColor *)color title:(NSString *)title size:(CGSize)size
{
    UIFont *font = [UIFont systemFontOfSize:9.f];
    
    CGFloat minSize = MIN(size.width, size.height);
    UIImage *roundImage = [UIImage roundImageWithColor:color size:CGSizeMake(minSize, minSize)];
    
    roundImage = [roundImage stretchableImageWithLeftCapWidth:roundImage.size.width / 2
                                                 topCapHeight:roundImage.size.height];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [roundImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    CGRect textFrame = CGRectZero;
    
    CGSize textSize;
    
    
    if ([title respondsToSelector:@selector(sizeWithAttributes:)])
    {
        textSize = [title sizeWithAttributes:@{ NSFontAttributeName:font }];
    }
    else
    {
        textSize = [title sizeWithFont:font];
    }
    
    textFrame.size = textSize;
    textFrame.origin.x = (size.width - textFrame.size.width) / 2.0f;
    textFrame.origin.y = (size.height - textFrame.size.height) / 2.0f;
    
    
    [[UIColor whiteColor] set];
    //    if ([title respondsToSelector:@selector(drawInRect:withAttributes:)]) {
    //        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    //        style.lineBreakMode = NSLineBreakByWordWrapping;
    //        style.alignment = NSTextAlignmentCenter;
    //
    //        NSDictionary *attributes = @{
    //                                     NSFontAttributeName : font,
    //                                     NSParagraphStyleAttributeName : style
    //                                     };
    //
    //        // text を描画する
    //        [title drawInRect:textFrame withAttributes:attributes];
    //    }
    //    else
    //    {
    [title drawInRect:textFrame
             withFont:font
        lineBreakMode:NSLineBreakByCharWrapping
            alignment:NSTextAlignmentCenter];
    //    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma clang diagnostic pop
- (UIImageView *) view
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self];
    
    [imageView sizeToFit];
    
    return imageView;
}

// - (UIImage *)boxblurImageWithBlur:(CGFloat)blur {
//    if (blur < 0.f || blur > 1.f) {
//        blur = 0.5f;
//    }
//    int boxSize = (int)(blur * 40);
//    boxSize = boxSize - (boxSize % 2) + 1;
//
//    CGImageRef img = self.CGImage;
//
//    vImage_Buffer inBuffer, outBuffer;
//
//    vImage_Error error;
//
//    void *pixelBuffer;
//
//
//    //create vImage_Buffer with data from CGImageRef
//
//    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
//    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
//
//
//    inBuffer.width = CGImageGetWidth(img);
//    inBuffer.height = CGImageGetHeight(img);
//    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
//
//    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
//
//    //create vImage_Buffer for output
//
//    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
//
//    if(pixelBuffer == NULL)
//        NSLog(@"No pixelbuffer");
//
//    outBuffer.data = pixelBuffer;
//    outBuffer.width = CGImageGetWidth(img);
//    outBuffer.height = CGImageGetHeight(img);
//    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
//
//    // Create a third buffer for intermediate processing
//    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
//    vImage_Buffer outBuffer2;
//    outBuffer2.data = pixelBuffer2;
//    outBuffer2.width = CGImageGetWidth(img);
//    outBuffer2.height = CGImageGetHeight(img);
//    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
//
//    //perform convolution
//    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//
//    if (error) {
//        NSLog(@"error from convolution %ld", error);
//    }
//
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
//                                             outBuffer.width,
//                                             outBuffer.height,
//                                             8,
//                                             outBuffer.rowBytes,
//                                             colorSpace,
//                                             kCGImageAlphaNoneSkipLast);
//    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
//    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
//
//    //clean up
//    CGContextRelease(ctx);
//    CGColorSpaceRelease(colorSpace);
//
//    free(pixelBuffer);
//    CFRelease(inBitmapData);
//
//    CGImageRelease(imageRef);
//
//    return returnImage;
// }


+ (UIImage *) imageWithColor:(UIColor *)color imageSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *) imageCoverWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [[UIColor whiteColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = CGRectZero;
    bounds.size = self.size;
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //    CGContextClipToMask(context, bounds, self.CGImage);
    CGContextFillRect(context, bounds);
    CGContextDrawImage(context, bounds, self.CGImage);
    CGContextDrawImage(context, bounds, [color image].CGImage);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}


@end
