//
//  NSObject+XD_ClassesConformingToProtocol.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/13.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSObject+XD_ClassesConformingToProtocol.h"
#import <objc/runtime.h>

@implementation NSObject (XD_ClassesConformingToProtocol)

+ (NSArray *)xd_ClassesConformingToProtocol:(Protocol *)protocol
{
    NSMutableArray *conformingClasses = [NSMutableArray new];
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0 ) {
        classes = (Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int index = 0; index < numClasses; index++) {
            Class nextClass = classes[index];
            if (class_conformsToProtocol(nextClass, protocol)) {
                [conformingClasses addObject:nextClass];
            }
        }
        free(classes);
    }
    return conformingClasses;
}

@end
