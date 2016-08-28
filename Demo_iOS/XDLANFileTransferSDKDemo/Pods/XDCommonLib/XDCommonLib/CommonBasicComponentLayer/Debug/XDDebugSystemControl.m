//
//  XDDebugSystemControl.m
//  XDCommonLib
//
//  Created by su xinde on 15/11/26.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import "XDDebugSystemControl.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

@implementation XDDebugSystemControl

+ (NSString *)getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    free(answer);
    return results;
}


+ (NSString *)platform
{
    return [self getSysInfoByName:"hw.machine"];
}

+ (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

//获取CPU频率
+ (NSUInteger)getCpuFrequency
{
    return [self getSysInfo:HW_CPU_FREQ];
}

//获取总线频率
+ (NSUInteger)getBusFrequency
{
    return [self getSysInfo:HW_BUS_FREQ];
}

//获取总的内存大小
+ (NSUInteger)getTotalMemory
{
    return [self getSysInfo:HW_PHYSMEM];
}

//获取用户内存
+ (NSUInteger)getUserMemory
{
    return [self getSysInfo:HW_USERMEM];
}

//获取socketBufferSize
+ (NSUInteger)maxSocketBufferSize
{
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}

//iphone下获取可用的内存大小
+ (NSUInteger)getAvailableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if(kernReturn != KERN_SUCCESS)
        return NSNotFound;
    return (vm_page_size * vmStats.free_count);// / 1024.0) / 1024.0;
}

//获取CPU使用率
+(float)cpuUsage
{    
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    if (thread_count > 0)stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++){
        
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}

@end
