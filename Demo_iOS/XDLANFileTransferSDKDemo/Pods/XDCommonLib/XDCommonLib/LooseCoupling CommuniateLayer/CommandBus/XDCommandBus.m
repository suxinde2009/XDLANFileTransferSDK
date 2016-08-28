//
//  XDCommandBus.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDCommandBus.h"

@interface XDCommandTranslator : NSObject

- (NSString *)toCommandHandler:(id)command;

@end

@implementation XDCommandTranslator

NSString *const KHANDLERCLASSSUFFIX = @"Handler";

- (NSString *)toCommandHandler:(id)command
{
    NSString *commandClassName =  NSStringFromClass([command class]);
    return [commandClassName stringByAppendingString:KHANDLERCLASSSUFFIX];
    
}

@end


@interface XDCommandBus ()

@property(nonatomic, strong) XDCommandTranslator *commandTranslator;

@end

@implementation XDCommandBus

- (instancetype)init {

    if(self = [super init]) {
        
        self.commandTranslator = [XDCommandTranslator new];
    }
    
    return self;
    
}

- (id)executeCommand:(id)command {
    
    NSString *commandHandlerClassName = [self.commandTranslator toCommandHandler:command];
    id<XDHandlerProtocol>handler = [NSClassFromString(commandHandlerClassName) new];
    
    return [handler handle:command];
    
}

- (void)executeCommand:(id)command withCompletion:(void(^)(id result))completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        id result = [self executeCommand:command];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completion)
                completion(result);
        });
    });
}

@end


