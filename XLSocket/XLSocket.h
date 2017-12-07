//
//  XLSocket.h
//  SmartHome
//
//  Created by xiuluodaren on 17/4/6.
//  Copyright © 2017年 xiuluodaren. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLSocketDelegate <NSObject>

@optional

/** 读取消息的回调 */
- (void)socketDidReadMessage:(NSString *)msg;

/** 连接成功 */
- (void)socketSuccessConnect;

/** 断开连接 */
- (void)socketDidDisconnectWithError:(NSError *)error;

@end

@interface XLSocket : NSObject

/** hostName */
@property (nonatomic,strong) NSString *hostName;

/** hostPost */
@property (nonatomic,assign) uint16_t hostPort;

/** timeOut */
@property (nonatomic,assign) CGFloat timeOut;

/** 是否断线重连 */
@property (nonatomic,assign) BOOL isReconnection;

/** 初始化 */
- (void)setupConnect;

/** 发送消息 */
- (void)sendMsg:(NSString *)Msg;

/** 发送数据 */
- (void)sendData:(NSData *)data;

/** 断开连接 */
- (void)disconnect;

/** 是否已连接 */
- (BOOL)isConnected;

/** 添加delegate */
- (void)changeDelegates:(id<XLSocketDelegate>)delegate isAdd:(BOOL)isAdd;

+ (instancetype)sharedSocket;

@end
