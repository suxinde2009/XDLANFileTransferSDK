//
//  XDCameraOrientationMonitor.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDCameraOrientationMonitor.h"
#import <CoreMotion/CoreMotion.h>

typedef struct {
    float x;			/**< The X-componenent of the vector. */
    float y;			/**< The Y-componenent of the vector. */
    float z;			/**< The Z-componenent of the vector. */
} Vector;

static inline Vector VectorMake(float x, float y, float z) {
    Vector v;
    v.x = x;
    v.y = y;
    v.z = z;
    return v;
}

/** Returns the dot-product of the two given vectors (v1 . v2). */
static inline float VectorDot(Vector v1, Vector v2) {
    return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z);
}

/** Returns the dot-product of the two given vectors (v1 . v2). */
static inline float VectorAngle(Vector v1, Vector v2) {
    float dot = VectorDot(v1, v2);
    dot = dot > 1.0f ? 1.0f : dot;
    dot = dot < -1.0f ? -1.0f :dot;
    return acosf(dot);
}

NSString *const kXDCameraOrientationMonitorDidChangeNotification  = @"kXDOrientationMonitorDidChangeNotification";


@interface XDCameraOrientationMonitor () {
    UIDeviceOrientation willOrientation;
}

@property (nonatomic,strong) CMMotionManager *motionManager;

- (void)changeOrientation;

@end

@implementation XDCameraOrientationMonitor

@synthesize orientation = _orientation;

+ (instancetype)monitor {
    static XDCameraOrientationMonitor *__sharedManager = nil;
    static dispatch_once_t onceToeken;
    dispatch_once(&onceToeken, ^{
        __sharedManager = [[self alloc] init];
    });
    return __sharedManager;
}

- (id)init
{
    if((self = [super init])) {
        _orientation = UIDeviceOrientationPortrait;
        _motionManager = [[CMMotionManager alloc] init];
        [self performSelector:@selector(orientationDetect) withObject:nil afterDelay:0.1];
    }
    return self;
}

- (void)orientationDetect
{
    [self.motionManager setAccelerometerUpdateInterval:1.0f/10];
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                 if (error == nil) {
                                                     [self accelerometer:accelerometerData];
                                                 }
                                             }];
}

- (void)changeOrientation
{
    _orientation = willOrientation;
    [[NSNotificationCenter defaultCenter] postNotificationName:kXDCameraOrientationMonitorDidChangeNotification object:nil];
}

#pragma mark - Responding to accelerations

- (void)accelerometer:(CMAccelerometerData *)accelerometerData{
    
    Vector accVector = VectorMake(accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
    
    UIDeviceOrientation tmpOrientation;
    
    float radian = M_PI/180.0*30.0;
    if (VectorAngle(accVector, VectorMake(0, -1, 0)) < radian) {
        tmpOrientation = UIDeviceOrientationPortrait;
    }
    else if (VectorAngle(accVector, VectorMake(0, 1, 0)) < radian) {
        tmpOrientation = UIDeviceOrientationPortraitUpsideDown;
    }
    else if (VectorAngle(accVector, VectorMake(-1, 0, 0)) < radian) {
        tmpOrientation = UIDeviceOrientationLandscapeLeft;
    }
    else if (VectorAngle(accVector, VectorMake(1, 0, 0)) < radian) {
        tmpOrientation = UIDeviceOrientationLandscapeRight;
    }
    else if (VectorAngle(accVector, VectorMake(0, 0, -1)) < radian) {
        tmpOrientation = UIDeviceOrientationFaceUp;
    }
    else if (VectorAngle(accVector, VectorMake(0, 0, 1)) < radian) {
        tmpOrientation = UIDeviceOrientationFaceDown;
    }
    else {
        tmpOrientation = UIDeviceOrientationUnknown;
    }
    
    if (tmpOrientation != willOrientation && tmpOrientation != UIDeviceOrientationUnknown) {
        willOrientation = tmpOrientation;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(changeOrientation) withObject:nil afterDelay:0.3f];
    }
}

- (NSString*)getOrientationString
{
    NSString *string = @"UIDeviceOrientationUnknown";
    
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortrait:
            string = @"UIDeviceOrientationPortrait";
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            string = @"UIDeviceOrientationPortraitUpsideDown";
            break;
        case UIDeviceOrientationLandscapeLeft:
            string = @"UIDeviceOrientationLandscapeLeft";
            break;
        case UIDeviceOrientationLandscapeRight:
            string = @"UIDeviceOrientationLandscapeRight";
            break;
        case UIDeviceOrientationFaceUp:
            string = @"UIDeviceOrientationFaceUp";
            break;
        case UIDeviceOrientationFaceDown:
            string = @"UIDeviceOrientationFaceDown";
            break;
        default:
            break;
    }
    return string;
    
}

- (NSInteger)updateEmitterOrientationWithCamera:(BOOL)isFront frontMirror:(BOOL)isForntMirror
{
    NSInteger _emitterOrientation = UIDeviceOrientationPortrait;
    switch (_orientation)
    {
        case UIDeviceOrientationPortrait:
        default:
            if (isFront){
                if(isForntMirror) {
                    _emitterOrientation = 1;
                }
                else{
                    _emitterOrientation = 2;
                }
            }
            else {
                _emitterOrientation = 1;
            }
            break;
        case UIDeviceOrientationLandscapeRight:
            if (isFront){
                if(isForntMirror) {
                    _emitterOrientation = 7;
                }
                else{
                    _emitterOrientation = 8;
                }
            }
            else {
                _emitterOrientation = 7;
            }
            break;
        case UIDeviceOrientationLandscapeLeft:
            if (isFront){
                if(isForntMirror) {
                    _emitterOrientation = 3;
                }
                else{
                    _emitterOrientation = 4;
                }
            }
            else {
                _emitterOrientation = 3;
            }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            if (isFront){
                if(isForntMirror) {
                    _emitterOrientation = 5;
                }
                else{
                    _emitterOrientation = 6;
                }
            }
            else {
                _emitterOrientation = 5;
            }
            break;
    }
    
    return _emitterOrientation;
}

- (UIImageOrientation)getUIImageOrientationFromUIDeviceOrientation:(BOOL)isFront frontMirror:(BOOL)isForntMirror
{
    UIImageOrientation orientImage = UIImageOrientationLeftMirrored;
    switch (_orientation)
    {
        case UIDeviceOrientationPortrait:
        default:
            if (isFront == YES) {
                if (isForntMirror) {
                    orientImage = UIImageOrientationLeftMirrored;
                }
                else{
                    orientImage = UIImageOrientationRight;
                }
            }
            else {
                orientImage = UIImageOrientationRight;
            }
            break;
        case UIDeviceOrientationLandscapeRight:
            if (isFront == YES) {
                if (isForntMirror) {
                    orientImage = UIImageOrientationUpMirrored;
                } else {
                    orientImage = UIImageOrientationUp;
                }
            }
            else {
                orientImage = UIImageOrientationDown;
            }
            
            break;
        case UIDeviceOrientationLandscapeLeft:
            if (isFront == YES) {
                if (isForntMirror) {
                    orientImage = UIImageOrientationDownMirrored;
                } else {
                    orientImage = UIImageOrientationDown;
                }
            }
            else {
                orientImage = UIImageOrientationUp;
            }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            if (isFront == YES) {
                if (isForntMirror) {
                    orientImage = UIImageOrientationRightMirrored;
                } else {
                    orientImage = UIImageOrientationLeft;
                }
            }
            else {
                orientImage = UIImageOrientationLeft;
            }
            break;
    }
    
    return orientImage;
}

@end
