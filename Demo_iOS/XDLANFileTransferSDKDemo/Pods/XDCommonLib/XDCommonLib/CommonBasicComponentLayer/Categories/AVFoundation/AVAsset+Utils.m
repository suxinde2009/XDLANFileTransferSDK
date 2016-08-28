//
//  AVAsset+Utils.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/25.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "AVAsset+Utils.h"
#import <UIKit/UIKit.h>

@implementation AVAsset (Utils)

- (Float64)xd_durationInSeconds {
    return CMTimeGetSeconds(self.duration);
}

- (CGSize)xd_calculatePlayerSizeForDimension:(XDVideoTrimDimension)dimension
                                  windowSize:(CGFloat)windowSize {
    CGSize aspectSize;
    
    AVAssetTrack *track = [[self tracksWithMediaType:AVMediaTypeVideo] firstObject];
    // 注意这里需要用preferredTransform计算一下, 才能获得用户见到的视频宽高, 否则不区分landscape和portrait
    CGSize videoSize = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform);
    // 直接transform后的value可能是负的
    videoSize = CGRectStandardize((CGRect){CGPointZero, videoSize}).size;
    NSLog(@"track videoSize: %@", NSStringFromCGSize(videoSize));
    
    CGFloat squareWidth = windowSize;
    CGFloat widthScale = videoSize.width / squareWidth;
    CGFloat heightScale = videoSize.height / squareWidth;
    
    CGFloat finalScale = (XDVideoTrimDimensionSquare == dimension ?
                          MIN(heightScale, widthScale) : MAX(heightScale, widthScale));
    
    aspectSize = (CGSize){videoSize.width / finalScale, videoSize.height / finalScale};
    NSLog(@"aspectSize: %@", NSStringFromCGSize(aspectSize));
    
    return aspectSize;
}


@end
