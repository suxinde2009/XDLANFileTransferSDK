//
//  XDDebugStatusBar.m
//  XDCommonLib
//
//  Created by su xinde on 15/11/26.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import "XDDebugStatusBar.h"
#import "XDDebugUtils.h"
#import "XDDebugSystemControl.h"

@interface drawLines : NSObject{
    float lineCl[4];
    CGFloat fillCl[4];
}

- (void)drawLinesWithPoints:(NSMutableArray *)points;

@end

static BOOL _isLongPress;

@interface XDDebugMemoryView : UIView {
    NSMutableArray *mPointList;
    int mPCount;
    drawLines *mdraw;
}
@property (assign, nonatomic) XDMemroyInfo memInfo;

@end

@interface XDDebugCpuView : UIView {
    NSMutableArray *pointList;
    int pCount;
    drawLines *cdraw;
}

- (void)setUsage:(float)usage;

@end


@interface XDDebugStatusBar ()

@property (strong, nonatomic) UIButton *debugButton;
@property (strong, nonatomic) XDDebugMemoryView *memoryView;
@property (strong, nonatomic) XDDebugCpuView *cpuView;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIView *statusbar;

@end

@implementation XDDebugStatusBar

IMP_SINGLETON

+ (void)attach
{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height = 20;
    XDDebugStatusBar *bar = [XDDebugStatusBar sharedInstance];
    bar.frame = frame;
    bar.windowLevel = UIWindowLevelStatusBar;
    //    [bar makeKeyAndVisible];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isLongPress = NO;//初始化长按键未按下
        self.windowLevel = UIWindowLevelStatusBar;
        self.statusbar=[XDDebugUtils sysStatusBar];
        
        //轻击手势
        //        UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(offShowDebuggerStatus:)];
        //        [self.statusbar addGestureRecognizer:tapPress];
        
        //内存视图
        self.memoryView = [[XDDebugMemoryView alloc] initWithFrame:CGRectZero];
        //self.memoryView.alpha=0.6;
        [self.statusbar insertSubview:self.memoryView atIndex:0];
        
        //cpu视图
        self.cpuView=[[XDDebugCpuView alloc] initWithFrame:CGRectZero];
        self.cpuView.userInteractionEnabled=NO;
        [self.statusbar insertSubview:self.cpuView atIndex:1];
        
        //Debugger按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"bug"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onShowDebugger:) forControlEvents:UIControlEventTouchUpInside];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(handleMemoryWarning)
                       name:UIApplicationDidReceiveMemoryWarningNotification
                     object:nil];
        [self onUpdateInfo:nil];
    }
    return self;
}


- (void)handleMemoryWarning
{
    [UIView animateWithDuration:0.3 animations:^{
        self.memoryView.frame=CGRectMake(0, 0, self.memoryView.frame.size.width, self.frame.size.height);
        self.memoryView.alpha=1;
    }];
}

- (float)getDebugButtonRight
{
    float left=self.frame.size.width,temp,center=self.frame.size.width/2;
    if (self.statusbar) {
        NSArray *vs = [self.statusbar subviews];
        Class clazz=[UIView class];
        Class clazz2=NSClassFromString(@"UIStatusBarActivityItemView");
        Class clazz3=[XDDebugCpuView class];
        for (UIView *v in vs) {
            if ([v isKindOfClass:(clazz)]&&
                v!=self.debugButton&&
                ![v isKindOfClass:clazz2]&&
                ![v isKindOfClass:clazz3]) {
                temp=v.frame.origin.x;
                if (temp>center) {
                    if (temp<left) {
                        left=temp;
                    }
                }
            }
        }
    }
    return left;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.statusbar != [XDDebugUtils sysStatusBar]) {
        self.statusbar = [XDDebugUtils sysStatusBar];
        [self.statusbar addSubview:self.debugButton];
        [self.statusbar insertSubview:self.memoryView atIndex:0];
        [self.statusbar insertSubview:self.cpuView atIndex:1];
    }
    [self.statusbar bringSubviewToFront:self.debugButton];
    [self.statusbar bringSubviewToFront:self.cpuView];
    [self.statusbar sendSubviewToBack:self.memoryView];
    self.cpuView.frame = CGRectMake(250, 0, self.bounds.size.width-250, 20);
    self.memoryView.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.debugButton.frame = CGRectMake([self getDebugButtonRight]-20, 2, 16, 16);
    }];
}

//打开调试视图
- (void)onShowDebugger:(id)sender
{
    for (UIWindow *w in [UIApplication sharedApplication].windows) {
        if (!w.hidden && w.windowLevel == UIWindowLevelNormal) {
            self.window = w;
            break;
        }
    }
}

//关闭调试视图
- (void)onCloseDebugger:(id)sender
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onUpdateInfo:(NSTimer *)timer
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (1) {
            self.memoryView.memInfo = [XDDebugUtils memoryInfo];
            [self.cpuView setUsage:[XDDebugSystemControl cpuUsage]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setNeedsLayout];
            });
            [NSThread sleepForTimeInterval:0.3];
        }
    });
}

//长按手势
- (void)onShowDebuggerStatus:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    if ([longPressGestureRecognizer state] == UIGestureRecognizerStateEnded) {
        _isLongPress = YES;
        //分左右两栏显示cpu利用率和内存占用率
        self.statusbar.backgroundColor = [UIColor blackColor];
        [self.cpuView setNeedsLayout];
        [self.memoryView setNeedsLayout];
    }
}

//轻击手势
- (void)offShowDebuggerStatus:(UITapGestureRecognizer *)tabGestureRecognizer
{
    if (_isLongPress) {
        _isLongPress = NO;
        //关闭
        self.statusbar.backgroundColor = [UIColor clearColor];
        [self.memoryView setNeedsLayout];
        [self.cpuView setNeedsLayout];
    }
}

@end

@implementation XDDebugMemoryView

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        mPointList=[[NSMutableArray alloc] initWithCapacity:200];
        mdraw = [[drawLines alloc]init];
    }
    return self;
    
}

//设置当前内存占用率
- (void)setMemInfo:(XDMemroyInfo)info
{
    _memInfo = info;
    natural_t total = info.free + info.used;
    float percent = (float)info.used / total;
    [mPointList insertObject:@(20-percent*20) atIndex:0];
    if ([mPointList count]>self.frame.size.width/2+2) {
        [mPointList removeLastObject];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay]; //调用drawRect方法,绘制view
    });
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    if (_isLongPress) {
        //长按
        self.frame = CGRectMake(0, 0,width/2, 20);
    }else{
        self.frame = CGRectMake(0, 0, width, 1);
    }
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (_isLongPress) {
        //长按，折线图
        [mdraw drawLinesWithPoints:mPointList];
    }else{
        //正常按下，线条显示
        XDMemroyInfo info = self.memInfo;
        natural_t total = info.free + info.used;
        float percent = (float)info.used / total;
        CGFloat width = floorf(percent * self.frame.size.width);
        [[UIColor redColor] set];//占用的部分是红色
        UIRectFill(CGRectMake(0, 0, width, self.frame.size.height));
        
        [[UIColor greenColor] set];//未占用的部分是绿色
        UIRectFill(CGRectMake(width, 0, self.frame.size.width - width, self.frame.size.height));
    }
}

@end

@implementation XDDebugCpuView

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        pointList=[[NSMutableArray alloc] initWithCapacity:200];
        cdraw = [[drawLines alloc]init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    if (_isLongPress) {
        //长按
        
        self.frame = CGRectMake(width/2, 0, width/2, 20);
    }else{
        self.frame = CGRectMake(width-70, 0, 70, 20);
    }
}
//设置当前cpu使用率
- (void)setUsage:(float)usage
{
    [pointList insertObject:@(20.5-usage/5) atIndex:0];
    if ([pointList count]>self.frame.size.width/2+2) {
        [pointList removeLastObject];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];//调用drawRect方法
    });
}

//绘制cpu占用折线图
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [cdraw drawLinesWithPoints:pointList];
}
@end

@implementation drawLines

- (instancetype)init
{
    if (self = [super init]) {
        //路径的颜色
        lineCl[0]=1.0f;
        lineCl[1]=0.0f;
        lineCl[2]=0.0f;
        lineCl[3]=1.0f;
        //用来填充路径所包围的区域
        fillCl[0]=1.0f;
        fillCl[1]=0.0f;
        fillCl[2]=0.0f;
        fillCl[3]=0.3f;
    }
    return self;
}

- (void)drawLinesWithPoints:(NSMutableArray *)pointList
{
    NSUInteger count = [pointList count];
    if (count==0) {
        return;
    }
    CGPoint points[count+2];
    points[0]=CGPointMake(-0.5,20.5);
    for (int i =0 ;i<count;i++) {
        points[i+1]=CGPointMake(i*2, [pointList[i] floatValue]);
    }
    points[1]=CGPointMake(-0.5, points[1].y);
    points[count+1]=CGPointMake(points[count].x,20.5);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (NULL == context) return;
    CGContextSetLineWidth(context, 0.5);
    CGContextSetAlpha(context, 0.8);
    CGContextAddLines(context, points, count+2);
    CGContextSetStrokeColor(context, (const CGFloat *)lineCl);
    CGContextSetFillColor(context,(const CGFloat *)fillCl);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
