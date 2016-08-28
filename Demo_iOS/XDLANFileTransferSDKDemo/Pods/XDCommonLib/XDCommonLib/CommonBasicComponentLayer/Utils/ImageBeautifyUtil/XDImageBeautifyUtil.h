//
//  XDImageBeautifyUtil.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface XDImageBeautifyUtil : NSObject

//实现滤镜效果
+ (UIImage *)imageWithImage:(UIImage*)inImage
            withColorMatrix:(const float*)f;

@end
