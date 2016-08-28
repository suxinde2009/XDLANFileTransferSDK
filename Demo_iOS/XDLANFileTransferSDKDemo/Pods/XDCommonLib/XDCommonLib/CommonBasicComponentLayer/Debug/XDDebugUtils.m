//
//  XDDebugUtils.m
//  XDCommonLib
//
//  Created by suxinde on 15/5/6.
//  Copyright (c) 2015年 su xinde. All rights reserved.
//

#import "XDDebugUtils.h"
#import <mach/mach.h>
#import <mach/mach_host.h>

@implementation XDDebugUtils


+ (XDMemroyInfo)memoryInfo
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
        NSLog(@"Failed to fetch vm statistics");
    
    /* Stats in bytes */
    natural_t mem_used = (vm_stat.active_count +
                          vm_stat.inactive_count +
                          vm_stat.wire_count) * pagesize;
    natural_t mem_free = vm_stat.free_count * pagesize;
    return (XDMemroyInfo){ .used = mem_used, .free = mem_free};
}

+(NSString *)memoryUsageDescription
{
    XDMemroyInfo info=[self memoryInfo];
    return [NSString stringWithFormat:@"used:%d , free:%d",info.used,info.free];
}

+ (UIView *)sysStatusBar
{
    UIView *bar=[[UIApplication sharedApplication] valueForKey:@"_statusBar"];
    NSArray *vs=[bar subviews];
    Class clazz=NSClassFromString(@"UIStatusBarForegroundView");
    for (id v in vs) {
        if ([v isKindOfClass:clazz]) {
            return v;
        }
    }
    return nil;
}

+ (UIView *)sysStatusBarBgView
{
    UIView *bar=[[UIApplication sharedApplication] valueForKey:@"_statusBar"];
    NSArray *vs=[bar subviews];
    Class clazz=NSClassFromString(@"UIStatusBarBackgroundView");
    for (id v in vs) {
        if ([v isKindOfClass:clazz]) {
            return v;
        }
    }
    return nil;
}

@end
