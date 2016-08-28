//
//  UIImage+UIGraphics.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/18.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIGraphics)

+ (UIImage *)clearImage;

+ (UIImage *)clearImageWithSize:(CGSize)size;

+ (UIImage *)darkGreenImage;

+ (UIImage *)lightBlueImageWithSize:(CGSize)size;

+ (UIImage *)darkBlueImageWithSize:(CGSize)size;

- (UIImage *)imageByFilledWithColor:(UIColor *)color;

+ (UIImage *)roundImageWithColor:(UIColor *)color
                            size:(CGSize)size;

+ (UIImage *)roundImageWithColor:(UIColor *)color
                     borderColor:(UIColor *)borderColor
                            size:(CGSize)size;

+ (UIImage *)roundedImageWithSize:(CGSize)size
                            color:(UIColor *)color
                           radius:(CGFloat)radius;

+ (UIImage *)imageWithColor:(UIColor *)color
                      title:(NSString *)title
                       size:(CGSize)size;

- (UIImageView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color
                  imageSize:(CGSize)size;

/**
 *  在图片上叠加蒙层后绘制
 *
 *  @param color 蒙层颜色
 *
 *  @return 结果图
 */
- (UIImage *)imageCoverWithColor:(UIColor *)color;

@end
