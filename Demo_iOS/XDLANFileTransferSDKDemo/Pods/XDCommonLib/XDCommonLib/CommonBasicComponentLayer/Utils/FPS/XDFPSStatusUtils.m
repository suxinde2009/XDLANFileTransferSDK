//
//  XDFPSStatus.m
//  XDCommonLib
//
//  Created by suxinde on 16/6/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDFPSStatusUtils.h"

static const NSInteger XD_FPS_View_Tag = 101;

@interface XDFPSStatusUtils () {
    CADisplayLink *_displayLink;
    NSTimeInterval _lastTime;
    NSUInteger _count;
}

@property (nonatomic, copy) void (^fpsHandler)(NSInteger fpsValue);

@end


@implementation XDFPSStatusUtils



- (void)dealloc {
    [_displayLink setPaused:YES];
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop]
                            forMode:NSRunLoopCommonModes];
}

+ (instancetype)sharedInstance
{
    static XDFPSStatusUtils *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedInstance) {
            _sharedInstance = [[XDFPSStatusUtils alloc] init];
        }
    });
    return _sharedInstance;
}


- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name: UIApplicationDidBecomeActiveNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
        
        // Track FPS using display link
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        [_displayLink setPaused:YES];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        // fpsLabel
        _fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-50)/2+50, 0, 50, 20)];
        _fpsLabel.font=[UIFont boldSystemFontOfSize:12];
        _fpsLabel.textColor=[UIColor colorWithRed:0.33 green:0.84 blue:0.43 alpha:1.00];
        _fpsLabel.backgroundColor=[UIColor clearColor];
        _fpsLabel.textAlignment=NSTextAlignmentRight;
        _fpsLabel.tag=101;
        
    }
    return self;
}


- (void)displayLinkTick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval interval = link.timestamp - _lastTime;
    if (interval < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / interval;
    _count = 0;
    
    NSString *text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    [_fpsLabel setText: text];
    if (_fpsHandler) {
        _fpsHandler((int)round(fps));
    }
    
}

- (void)open {
    NSArray *rootVCViewSubViews = [[UIApplication sharedApplication].delegate window].rootViewController.view.subviews;
    for (UIView *label in rootVCViewSubViews) {
        if ([label isKindOfClass:[UILabel class]]&& label.tag == XD_FPS_View_Tag) {
            return;
        }
    }
    [_displayLink setPaused:NO];
    [[((NSObject <UIApplicationDelegate> *)([UIApplication sharedApplication].delegate)) window].rootViewController.view addSubview:_fpsLabel];
}

- (void)openWithHandler:(void (^)(NSInteger fpsValue))handler{
    [[XDFPSStatusUtils sharedInstance] open];
    _fpsHandler = handler;
}

- (void)close {
    [_displayLink setPaused:YES];
    NSArray *rootVCViewSubViews=[[UIApplication sharedApplication].delegate window].rootViewController.view.subviews;
    for (UIView *label in rootVCViewSubViews) {
        if ([label isKindOfClass:[UILabel class]]&& label.tag==XD_FPS_View_Tag) {
            [label removeFromSuperview];
            return;
        }
    }
}

- (void)applicationDidBecomeActiveNotification {
    [_displayLink setPaused:NO];
}

- (void)applicationWillResignActiveNotification {
    [_displayLink setPaused:YES];
}

@end
