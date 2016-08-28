/*****************************************************
 *  MIT Licence
 *
 *  Author: __承_影__
 *
 *  Date:   2015.2.10
 *
 ****************************************************/

#import "UIView+UIScreenDisplaying.h"

@implementation UIView (UIScreenDisplaying)

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}

@end

// 测试用例
/*
@interface TestDisplayInScreenVC : UIViewController
- (void)testDisplayInScreen;
@end

@implementation TestDisplayInScreenVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testDisplayInScreen];
}

- (void)testDisplayInScreen
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    // 无父视图
    BOOL b1 = [v isDisplayedInScreen];
    NSLog(@"b1: %d", b1);
    
    
    //
    [self.view addSubview:v];
    
    BOOL b2 = [v isDisplayedInScreen];
    NSLog(@"b2: %d", b2);
    
    
    v.frame = CGRectZero;
    BOOL b3 = [v isDisplayedInScreen];
    NSLog(@"b3: %d", b3);
    
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    v.frame = CGRectMake(-screenWidth, -screenHeight, screenWidth, screenHeight);
    BOOL b4 = [v isDisplayedInScreen];
    NSLog(@"b4: %d", b4);
}

@end
*/