//
//  MKMapView+BetterMaps.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/xjunior/BetterMaps


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapView (ZoomToFitAnnotations)

/**
 *  放大到Annotation对应区域
 *
 *  @param animated 是否有放大过度动画 YES 有 NO 没有
 */
- (void)zoomToFitAnnotationsAnimated:(BOOL)animated;

@end