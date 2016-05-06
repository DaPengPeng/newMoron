//
//  DppXMPP.m
//  Moron
//
//  Created by bever on 16/4/12.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DppXMPP.h"

@implementation DppXMPP {
    
    
    NSString *_password;
    
    BOOL _isRegister;
    
    
    
}

+ (id)shared {
    
    static DppXMPP *xmpp = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        xmpp = [[DppXMPP alloc] init];
    });
    return xmpp;
}

- (id)init {
    
    if (self = [super init]) {
        _stream = [[XMPPStream alloc] init];
        
        _stream.hostName = @"192.168.199.141";
        
        [_stream setHostPort:5222];
        
        //断开后自动连接
        _reconnect = [[XMPPReconnect alloc] init];
        [_reconnect activate:_stream];//激活该模块
        [_reconnect setAutoReconnect:YES];//设置自动连接
        
        //好友管理模块
        _rosterMS = [[XMPPRosterMemoryStorage alloc] init];//好友存储模块
        _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterMS dispatchQueue:dispatch_get_main_queue()];//好友模块
        [_roster activate:_stream];//激活
        [_roster setAutoFetchRoster:YES];//设置自动同步好友
        [_roster setAutoAcceptKnownPresenceSubscriptionRequests:YES];//设置自动接受好友请求
        
        //消息模块
        _messageACDS = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        _messageArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_messageACDS dispatchQueue:dispatch_get_global_queue(0, 0)];
        [_messageArchiving activate:_stream];//激活消息模块
        
        [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [_roster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}
- (void)GOWithJID:(NSString *)JID passWord:(NSString *)passWord {
    
    if ([_stream isConnected]) {
        [_stream disconnect];
        
    }
    _password = passWord;
    
    XMPPJID *userJID = [XMPPJID jidWithUser:JID domain:@"ainiderenpeng001" resource:@"DPP"];
    
    [_stream setMyJID:userJID];
    
    _isRegister = NO;
    NSError *error = nil;
    
    [_stream connectWithTimeout:5 error:&error];
    if (error) {
        
        NSLog(@"error:%@",error);
    }
    
    
    
}

- (void)registerJID:(NSString *)JID passWord:(NSString *)password {
    
    if ([_stream isConnected]) {
        [_stream disconnect];
        
    }
    _password = password;
    
    XMPPJID *userJID = [XMPPJID jidWithUser:JID domain:@"ainiderenpeng001" resource:@"DPP"];
    [_stream setMyJID:userJID];
    
    NSError *error = nil;
    
    _isRegister = YES;
    [_stream connectWithTimeout:5 error:&error];
    if (error) {
        
        NSLog(@"error:%@",error);
    }
    
}

#pragma mark - XMPPDelegete
- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    
    NSLog(@"连接成功");
    
    if (_isRegister) {
        
        [_stream registerWithPassword:_password error:nil];
    }else {
        
        [_stream authenticateWithPassword:_password error:nil];
    }
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error {
    
    NSLog(@"连接失败");
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    
    NSLog(@"验证成功");
    
    //更改状态
    XMPPPresence *presence = [XMPPPresence presence];
    
    [presence addChild:[DDXMLNode elementWithName:@"status" stringValue:@"在线"]];
    [_stream sendElement:presence];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kGO object:nil];
    
    
    
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error {
    
    NSLog(@"验证失败");
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender {
    
    NSLog(@"注册成功");
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kRegister object:nil];
}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error {
    
    NSLog(@"注册失败");
    NSLog(@"%@",error);
}

#pragma mark - XMPPRosterDelegate
- (void)xmppRosterDidBeginPopulating:(XMPPRoster *)sender {
    
    NSLog(@"开始同步好友信息");
}
- (void)xmppRosterDidPopulate:(XMPPRosterMemoryStorage *)sender {
    
    NSLog(@"同步好友信息完成");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPopulate object:nil];
}

//好友发生状态改变时调用
- (void)xmppRosterDidChange:(XMPPRosterMemoryStorage *)sender {
    
    NSLog(@"好友状态发生改变");
    [[NSNotificationCenter defaultCenter] postNotificationName:kPopulate object:nil];
}

- (void)xmppRoster:(XMPPRosterMemoryStorage *)sender didAddUser:(XMPPUserMemoryStorageObject *)user {
    
    NSLog(@"添加好友成功");
    [[NSNotificationCenter defaultCenter] postNotificationName:kPopulate object:nil];
}
#pragma mark ------ 状态改变
-(void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    //获取用户名
    NSString *userId = [[presence from] user];
    
    //获取当前登陆用户名
    NSString *currentName = sender.myJID.user;
    
    if (![userId isEqualToString:currentName]) {
        
        if ([[presence type] isEqualToString:@"available"]) {
            NSLog(@"好友上线");
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kPopulate object:nil];
        }
        else if ([[presence type] isEqualToString:@"unavailable"])
        {
            NSLog(@"好友离线");
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kPopulate object:nil];
        }
        else if ([[presence type] isEqualToString:@"subscribed"])
        {
            //其它用户同意了好友请求
            
        }
    }
}

#pragma mark - 接收好友消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
    
    NSLog(@"接收到好友消息");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMessage object:nil];
}
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message {
    
    NSLog(@"自己发送消息");
    [[NSNotificationCenter defaultCenter] postNotificationName:kMessage object:nil];
}



@end
