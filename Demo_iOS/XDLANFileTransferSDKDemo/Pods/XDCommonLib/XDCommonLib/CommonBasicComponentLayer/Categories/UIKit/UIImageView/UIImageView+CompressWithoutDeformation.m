//
//  UIImageView+CompressWithoutDeformation.m
//  XDCommonLib
//
//  Created by su xinde on 15/11/23.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import "UIImageView+CompressWithoutDeformation.h"

@implementation UIImage (CompressWithoutDeformation)

+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage
                       targetSize:(CGSize)size
{
    CGSize imageSize = sourceImage.size;
    
    // 如果图片大小跟目标显示区域大小一致，则不做压缩
    if(CGSizeEqualToSize(imageSize, size) == NO) {
        
        UIImage *newImage = nil;
        
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        
        CGFloat targetWidth = size.width;
        CGFloat targetHeight = size.height;
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        CGFloat scaleFactor = MAX(widthFactor, heightFactor);
        
        CGFloat scaledWidth = width * scaleFactor;
        CGFloat scaledHeight = height * scaleFactor;
        
        CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        
        UIGraphicsBeginImageContext(size);
        
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [sourceImage drawInRect:thumbnailRect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        if(newImage == nil){
            NSLog(@"scale image fail");
        }
        
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    else {
        return sourceImage;
    }
}

@end

@implementation UIImageView (CompressWithoutDeformation)

- (void)setImageWithoutDeformation:(UIImage *)image
                  placeHolderImage:(UIImage *)placeHolderImage
{
    CGFloat targetImageWidth = image.size.width;
    CGFloat targetImageHeight = image.size.height;
    
    // 正方形，则直接放置
    if (targetImageHeight == targetImageWidth) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    }else {
        if (placeHolderImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *compressedImage = [UIImage imageCompressForSize:image targetSize:self.bounds.size];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = compressedImage;
            });
        });
    }
    
}

@end

