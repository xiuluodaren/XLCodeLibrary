//
//  XLSocket.m
//  SmartHome
//
//  Created by 修罗.
//  Created by 修罗.
//  Copyright © 2017年 xiuluodaren. All rights reserved.
//

#import "XLSocket.h"
#import "GCDAsyncSocket.h"

@interface XLSocket ()<GCDAsyncSocketDelegate>

/** socket */
@property (nonatomic,strong) GCDAsyncSocket *socket;

/** delegate */
@property (nonatomic,strong) NSArray<id<XLSocketDelegate>> * delegates;

@end

@implementation XLSocket

#pragma mark - 单例
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone]init];
    });
    return _instance;
}

+ (instancetype)sharedSocket
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[XLSocket alloc]init];
    });
    return _instance;
}

- (instancetype)copy
{
    return _instance;
}

//添加/移除delegate YES添加 NO移除
- (void)changeDelegates:(id<XLSocketDelegate>)delegate isAdd:(BOOL)isAdd
{
    NSUInteger count = _delegates.count;
    
    NSMutableArray *newDelegates = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        if (delegate != _delegates[i]) {
            [newDelegates addObject:_delegates[i]];
        }
    }
    
    if (isAdd) {
        [newDelegates addObject:delegate];
    }
    _delegates = newDelegates;
}

//发送消息
- (void)sendMsg:(NSString *)Msg
{
    NSData *sendData = [Msg dataWithString];
    XLLog(@"sendMsg:%@",Msg);
    [_socket writeData:sendData withTimeout:-1 tag:100];
}

//发送数据
- (void)sendData:(NSData *)data
{
    [_socket writeData:data withTimeout:-1 tag:100];
}

#pragma mark - 初始化TCP连接
- (void)setupConnect
{
    XLLog(@"%s Link: %d",__func__,__LINE__);
    
    if ([_socket isConnected]) return;
    
    //创建socket对象
    GCDAsyncSocket *socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    //连接
    NSError *error = nil;
    [socket connectToHost:_hostName onPort:_hostPort withTimeout:_timeOut != 0 ? _timeOut : 5.0 error:&error];

    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    
}

//断开连接
- (void)disconnect
{
    [_socket disconnect];
}

//连接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功:%s Link: %d",__func__,__LINE__);
    
    //保存连接
    _socket = sock;
    
    for (id<XLSocketDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(socketSuccessConnect)]) {
            [delegate socketSuccessConnect];
        }
    }
    
    //设置读取超时
    [sock readDataWithTimeout:-1 tag:100];

}

//断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"断开连接:%s Link: %d",__func__,__LINE__);
    NSLog(@"error:%@",err.localizedDescription);
    
    //断线重连
    if (_isReconnection) {
        [self setupConnect];
    }
    
    for (id<XLSocketDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(socketDidDisconnectWithError:)]) {
            [delegate socketDidDisconnectWithError:err];
        }
    }
    
}

//读取数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"读取数据:%s Link: %d",__func__,__LINE__);
    [sock readDataWithTimeout:-1 tag:100];
    NSString *receiverStr = [NSString stringWithASCIIData:data];

    for (id<XLSocketDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(socketDidReadMessage:)]) {
            [delegate socketDidReadMessage:receiverStr];
        }
    }
}

//写入数据完成
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%s Link:%d",__func__,__LINE__);
    [sock readDataWithTimeout:-1 tag:100];
}

//是否已连接
- (BOOL)isConnected
{
    return [_socket isConnected];
}

@end
