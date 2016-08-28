//
//  XDLANDeviceInfo.m
//  XDLANFileTransferSDKDemo
//
//  Created by suxinde on 16/8/29.
//  Copyright © 2016年 com.su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDLANDeviceInfo : NSObject

@property (nonatomic, strong) NSString *platForm;

@property (nonatomic, strong) NSString *ip;

@property (nonatomic, strong) NSString *port;

@property (nonatomic, strong) NSDictionary *userInfo;

- (instancetype)initWithJSONDict:(NSDictionary *)josnDict;

@end
