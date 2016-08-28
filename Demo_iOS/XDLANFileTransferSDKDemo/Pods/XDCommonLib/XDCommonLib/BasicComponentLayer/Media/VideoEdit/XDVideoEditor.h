//
//  XDVideoEditor.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/4.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^XDVideoEditProgressHandle)(CGFloat progress);

@interface XDVideoEditor : NSObject

/**
 *  导出倒序播放的视频
 *
 *  @param asset            待导出媒体文件的AVAsset
 *  @param videoComposition AVMutableVideoComposition
 *  @param duration         时长
 *  @param outputURL        导出路径URL
 *  @param progressHandle   进度回调
 *  @param cancel           是否取消操作
 *
 *  @return 导出文件的AVAsset
 */
+ (AVAsset *)assetByReversingAsset:(AVAsset *)asset
                  videoComposition:(AVMutableVideoComposition *)videoComposition
                          duration:(CMTime)duration
                         outputURL:(NSURL *)outputURL
                    progressHandle:(XDVideoEditProgressHandle)progressHandle
                            cancel:(BOOL *)cancel;

@end
