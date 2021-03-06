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

/*
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
    
    int ttl = 64;
    int err = setsockopt(sock, IPPROTO_IP, IP_MULTICAST_TTL, (char *)&ttl, sizeof(ttl));  //设置组播TTL
    if (err < 0) {
        //                if (errPtr) {
        //                    *errPtr = [self errnoErrorWithReason:@"Error setting multicast ttl (setsockopt)"];
        //                }
        cout<<"set sock ttl error"<<endl;
        return -4;
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
*/


#define BUFLEN 255

int startServer(char *groupAddress,
                char *port)
{
    struct sockaddr_in peeraddr;
    struct in_addr ia;
    int sockfd;
    char recmsg[BUFLEN + 1];
    unsigned int socklen, n;
    struct hostent *group;
    struct ip_mreq mreq;
    
    /* 创建 socket 用于UDP通讯 */
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        printf("socket creating err in udptalk\n");
        exit(1);
    }
    
    /* 设置要加入组播的地址 */
    bzero(&mreq, sizeof(struct ip_mreq));
    if (groupAddress) {
        if ((group = gethostbyname(groupAddress)) == (struct hostent *) 0) {
            perror("gethostbyname");
            exit(errno);
        }
    } else {
        printf
        ("you should give me a group address, 224.0.0.0-239.255.255.255\n");
        exit(errno);
    }
    
    bcopy((void *) group->h_addr, (void *) &ia, group->h_length);
    /* 设置组地址 */
    bcopy(&ia, &mreq.imr_multiaddr.s_addr, sizeof(struct in_addr));
    
    /* 设置发送组播消息的源主机的地址信息 */
    mreq.imr_interface.s_addr = htonl(INADDR_ANY);
    
    /* 把本机加入组播地址，即本机网卡作为组播成员，只有加入组才能收到组播消息 */
    if (setsockopt
        (sockfd, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mreq,
         sizeof(struct ip_mreq)) == -1) {
            perror("setsockopt");
            exit(-1);
        }
    
    socklen = sizeof(struct sockaddr_in);
    memset(&peeraddr, 0, socklen);
    peeraddr.sin_family = AF_INET;
    if (port)
        peeraddr.sin_port = htons(atoi(port));
    else
        peeraddr.sin_port = htons(7838);
    if (groupAddress) {
        if (inet_pton(AF_INET, groupAddress, &peeraddr.sin_addr) <= 0) {
            printf("Wrong dest IP address!\n");
            exit(0);
        }
    } else {
        printf("no group address given, 224.0.0.0-239.255.255.255\n");
        exit(errno);
    }
    
    /* 绑定自己的端口和IP信息到socket上 */
    if (bind
        (sockfd, (struct sockaddr *) &peeraddr,
         sizeof(struct sockaddr_in)) == -1) {
            printf("Bind error\n");
            exit(0);
        }
    
    /* 循环接收网络上来的组播消息 */
    for (;;) {
        bzero(recmsg, BUFLEN + 1);
        n = recvfrom(sockfd, recmsg, BUFLEN, 0,
                     (struct sockaddr *) &peeraddr, &socklen);
        if (n < 0) {
            printf("recvfrom err in udptalk!\n");
            exit(4);
        } else {
            /* 成功接收到数据报 */
            recmsg[n] = 0;
            printf("peer:%s", recmsg);
        }
    }

}

@implementation Server

- (int)startServer
{
    return startServer("224.0.0.1", "7123");
    //return startServer();
}

@end


