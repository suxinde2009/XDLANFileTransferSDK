//
//  AVAsset+Utils.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/25.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

/**
 *  裁剪的样式
 */
typedef NS_ENUM(NSUInteger, XDVideoTrimDimension) {
    XDVideoTrimDimensionSquare = 0, // 正方形
    XDVideoTrimDimensionOriginal    // 原始比例
};

@interface AVAsset (Utils)

/**
 * 获取视频素材对应的时长秒数
 */
- (Float64)xd_durationInSeconds;

/**
 * 根据预期的window长度 和 dimension, 计算视频缩放的大小
 *
 * @param dimension 原始比例还是正方形
 * @param windowSize 这里window一定是正方形的, 所以这个是宽高一致
 */
- (CGSize)xd_calculatePlayerSizeForDimension:(XDVideoTrimDimension)dimension
                                  windowSize:(CGFloat)windowSize;

@end
