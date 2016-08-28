//
//  UIImageView+CompressWithoutDeformation.h
//  XDCommonLib
//
//  Created by su xinde on 15/11/23.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CompressWithoutDeformation)

+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage
                       targetSize:(CGSize)size;

@end

@interface UIImageView (CompressWithoutDeformation)

/**
 *  正方形UIImageView放置长方形图片时防止形变
 *
 *  @param image            待展示的长方形图片
 *  @param placeHolderImage 预置图片
 */
- (void)setImageWithoutDeformation:(UIImage *)image
                  placeHolderImage:(UIImage *)placeHolderImage;

@end
