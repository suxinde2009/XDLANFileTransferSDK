//
//  Client.m
//  MultiCastDemo
//
//  Created by suxinde on 16/8/30.
//  Copyright © 2016年 com.su. All rights reserved.
//

#import "Client.h"

#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<sys/types.h>
#include<unistd.h>
#include<sys/socket.h>
#include<netdb.h>
#include<arpa/inet.h>
#include<netinet/in.h>

/*
#define MCAST_PORT 8888
#define MCAST_ADDR "224.0.0.88" //一个局部连接多播地址，路由器不进行转发
#define MCAST_INTERVAL 5  //发送时间间隔
#define BUFF_SIZE 256   //接收缓冲区大小

using std::cout;
using std::endl;
using std::string;

int startClient()
{
    int sock;
    struct sockaddr_in local_addr;
    int err = -1;
    sock = socket(AF_INET,SOCK_DGRAM,0);
    if(sock==-1)
    {
        cout<<"sock error"<<endl;
        return -1;
    }
    //初始化地址
    local_addr.sin_family=AF_INET;
    local_addr.sin_addr.s_addr=htonl(INADDR_ANY);
    local_addr.sin_port=htons(MCAST_PORT);
    
    //绑定socket
    //    int	bind(int, const struct sockaddr *, socklen_t) __DARWIN_ALIAS(bind);
    err = bind(sock,
               (const struct sockaddr*)&local_addr,
               sizeof(local_addr));
    
    if(err<0) {
        cout<<"bind error"<<endl;
        return -2;
    }
    //设置回环许可
    int loop = 1;
    err = setsockopt(sock,IPPROTO_IP,IP_MULTICAST_LOOP,&loop,sizeof(loop));
    if(err<0)
    {
        cout<<"set sock error"<<endl;
        return -3;
    }
    struct ip_mreq mreq;//加入广播组
    mreq.imr_multiaddr.s_addr=inet_addr(MCAST_ADDR);//广播地址
    mreq.imr_interface.s_addr=htonl(INADDR_ANY); //网络接口为默认
    //将本机加入广播组
    err = setsockopt(sock,IPPROTO_IP,IP_ADD_MEMBERSHIP,&mreq,sizeof(mreq));
    if(err<0) {
        cout<<"set sock error"<<endl;
        return -4;
    }
    
    
    int ttl = 64;
    err = setsockopt(sock, IPPROTO_IP, IP_MULTICAST_TTL, (char *)&ttl, sizeof(ttl));  //设置组播TTL
    if (err < 0) {
//                if (errPtr) {
//                    *errPtr = [self errnoErrorWithReason:@"Error setting multicast ttl (setsockopt)"];
//                }
        cout<<"set sock ttl error"<<endl;
        return -4;
    }
    
    
    
    int times=0;
    socklen_t addr_len=0;
    char buff[BUFF_SIZE];
    int n=0;
    //循环接受广播组的消息，5次后退出
    for(times=0; times < 5 ;times++)
    {
        addr_len = sizeof(local_addr);
        memset(buff,0,BUFF_SIZE);
        n = recvfrom(sock,
                     buff,
                     BUFF_SIZE,
                     0,
                     (struct sockaddr*)&local_addr,&addr_len);
        if(n == -1) {
            cout<<"recv error"<<endl;
            return -5;
        }
        //打印信息
        printf("RECV %dst message from server : %s\n",times,buff);
        sleep(MCAST_INTERVAL);
    }
    //退出广播组
    err=setsockopt(sock,IPPROTO_IP,IP_DROP_MEMBERSHIP,&mreq,sizeof(mreq));
    close(sock);
    return 0;
}
*/


#define BUFLEN 255

int startClient(char *groupIp,
                char *groupPort,
                char *selfIp,
                char *selfPort)
{
    struct sockaddr_in peeraddr, myaddr;
    
    int sockfd;
    char recmsg[BUFLEN + 1];
    unsigned int socklen;
    
    /* 创建 socket 用于UDP通讯 */
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        printf("socket creating error\n");
        exit(1);
    }
    socklen = sizeof(struct sockaddr_in);
    
    /* 设置对方的端口和IP信息 */
    memset(&peeraddr, 0, socklen);
    peeraddr.sin_family = AF_INET;
    if (groupPort)
        peeraddr.sin_port = htons(atoi(groupPort));
    else
        peeraddr.sin_port = htons(7838);
    if (groupIp) {
        /* 注意这里设置的对方地址是指组播地址，而不是对方的实际IP地址 */
        if (inet_pton(AF_INET, groupIp, &peeraddr.sin_addr) <= 0) {
            printf("wrong group address!\n");
            exit(0);
        }
    } else {
        printf("no group address!\n");
        exit(0);
    }
    
    /* 设置自己的端口和IP信息 */
    memset(&myaddr, 0, socklen);
    myaddr.sin_family = AF_INET;
    if (selfPort)
        myaddr.sin_port = htons(atoi(selfPort));
    else
        myaddr.sin_port = htons(23456);
    
    if (selfIp) {
        if (inet_pton(AF_INET, selfIp, &myaddr.sin_addr) <= 0) {
            printf("self ip address error!\n");
            exit(0);
        }
    } else
        myaddr.sin_addr.s_addr = INADDR_ANY;
    
    /* 绑定自己的端口和IP信息到socket上 */
    if (bind
        (sockfd, (struct sockaddr *) &myaddr,
         sizeof(struct sockaddr_in)) == -1) {
            printf("Bind error\n");
            exit(0);
        }
    
    /* 循环接受用户输入的消息发送组播消息 */
    for (;;) {
        /* 接受用户输入 */
        bzero(recmsg, BUFLEN + 1);
        if (fgets(recmsg, BUFLEN, stdin) == (char *) EOF)
            exit(0);
        /* 发送消息 */
        if (sendto
            (sockfd, recmsg, strlen(recmsg), 0,
             (struct sockaddr *) &peeraddr,
             sizeof(struct sockaddr_in)) < 0) {
                printf("sendto error!\n");
                exit(3);
            }
        printf("'%s' send ok\n", recmsg);
    }
}

@implementation Client

- (int)startClient
{
    // 获取Ip
    
    return 0;
    //return startClient();
}

@end

