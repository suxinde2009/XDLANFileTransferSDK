//
//  XDFileMimeType.m
//  XDCommonLib
//
//  Created by zj－db0367 on 15/12/20.
//  Copyright © 2015年 su xinde. All rights reserved.
//

#import "XDFileMimeType.h"

@interface XDFileMimeType ()

@property (retain) NSDictionary* config;

@end

@implementation XDFileMimeType
@synthesize config = _config;

static XDFileMimeType *_sharedLoader = nil;

- (id)init
{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"MTFileMimeType" ofType:@"plist"];
        _config = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return self;
}

- (NSString *)mimeType:(NSString *)fileName
{
    NSString *mime = nil;
    NSString *ext = fileName.pathExtension.lowercaseString;
    if (ext && ext.length != 0) {
        mime = [_config objectForKey:ext];
        if (!mime)
            mime = ext;
    }
    return mime;
}

+ (XDFileMimeType *)sharedLoader
{
    if (_sharedLoader == nil)
        _sharedLoader = [[XDFileMimeType alloc] init];
    return _sharedLoader;
}

+ (NSString *)mimeType:(NSString *)fileName
{
    return [[XDFileMimeType sharedLoader] mimeType:fileName];
}


@end
