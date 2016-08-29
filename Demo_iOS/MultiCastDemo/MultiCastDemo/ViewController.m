//
//  ViewController.m
//  MultiCastDemo
//
//  Created by suxinde on 16/8/30.
//  Copyright © 2016年 com.su. All rights reserved.
//

#import "ViewController.h"

#import "Server.h"
#import "Client.h"

@interface ViewController ()

@property (nonatomic, strong) Server *server;
@property (nonatomic, strong) Client *client;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.server = [Server new];
    self.client = [Client new];
    
    
}

- (IBAction)server:(id)sender {
    [self.server startServer];
}

- (IBAction)client:(id)sender {
    [self.client startClient];
}

@end
