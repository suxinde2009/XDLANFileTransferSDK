//
//  Server.m
//  MultiCastDemo
//
//  Created by suxinde on 16/8/30.
//  Copyright © 2016年 com.su. All rights reserved.
//

#import "Server.h"

#include<iostream>
#include<stdio.h>
#include<sys/socket.h>
#include<netdb.h>
#include<sys/types.h>
#include<arpa/inet.h>
#include<netinet/in.h>
#include<unistd.h>
#include<stdlib.h>
#include<string.h>

#define MCAST_PORT 8888
#define MCAST_ADDR "224.0.0.88"  // 多播地址
#define MCAST_DATA "BROADCAST TEST DATA"  // 多播内容
#define MCAST_INTERVAL 5  //多播时间间隔

using std::cout;
using std::endl;
using std::string;

int startServer()
{
    int sock;
    struct sockaddr_in mcast_addr;
    sock=socket(AF_INET,SOCK_DGRAM,0);
    if(sock==-1)
    {
        cout<<"socket error"<<endl;
        return -1;
    }
    memset(&mcast_addr,0,sizeof(mcast_addr));
    mcast_addr.sin_family=AF_INET;
    mcast_addr.sin_addr.s_addr=inet_addr(MCAST_ADDR);
    mcast_addr.sin_port=htons(MCAST_PORT);
    
    while(1)
    {       //向局部多播地址发送多播内容
        int n = sendto(sock,
                       MCAST_DATA,
                       sizeof(MCAST_DATA),
                       0,
                       (struct sockaddr*)&mcast_addr,
                       sizeof(mcast_addr));
        if(n<0)
        {
            cout<<"send error"<<endl;
            return -2;
        }
        else
        {
            cout<<"send message is going ...."<<endl;
        }
        sleep(MCAST_INTERVAL);
        
    }
    return 0;
}

@implementation Server

- (int)startServer
{
    return startServer();
}

@end


