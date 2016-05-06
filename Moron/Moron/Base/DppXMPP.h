//
//  DppXMPP.h
//  Moron
//
//  Created by bever on 16/4/12.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

@interface DppXMPP : NSObject <XMPPStreamDelegate,XMPPRosterDelegate,XMPPRosterMemoryStorageDelegate>

@property (nonatomic,strong) XMPPStream *stream;
@property (nonatomic,strong) XMPPRoster *roster;//好友模块
@property (nonatomic,strong) XMPPRosterMemoryStorage *rosterMS;//好友存储模块
@property (nonatomic,strong) XMPPReconnect *reconnect;//自动连接模块
@property (nonatomic,strong) XMPPMessageArchiving *messageArchiving;//消息模块
@property (nonatomic,strong) XMPPMessageArchivingCoreDataStorage *messageACDS;


+ (id)shared;

- (void)GOWithJID:(NSString *)JID passWord:(NSString *)passWord;

- (void)registerJID:(NSString *)JID passWord:(NSString *)password;



@end


