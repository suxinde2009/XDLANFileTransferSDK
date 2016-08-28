//
//  XDCommandBus.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 The Command
 A command is a DTO that carries the data needed to perform a specific business logic.
 
 The CommandHandler
 The command handler uses the Command DTO object and performs a set of operations over or along the object. The CommandHandler conforms to RBHandlerProtocol
 
 The CommandBus
 The command bus uses the command translator to map a specific command to its handler class, and executes commands that are issues to it.
 */

@protocol XDHandlerProtocol <NSObject>
@required

- (id)handle:(id)command;

@end

/**
 *  命令总线 （松耦合的命令执行管理类）
 */
@interface XDCommandBus : NSObject

//execute a command object with its specific handler
- (id)executeCommand:(id)command;

//execute command with Completion Blocks
- (void)executeCommand:(id)command withCompletion:(void(^)(id result))completion;

@end
