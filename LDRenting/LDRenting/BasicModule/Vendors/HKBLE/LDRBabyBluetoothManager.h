//
//  HKBabyBluetoothManager.h
//  HKBabyBluetooth
//
//  Created by 刘华坤 on 2019/3/15.
//  Copyright © 2018年 liuhuakun. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LDRPeripheralInfo.h"

// 设置蓝牙的前缀【开发者必须改为自己的蓝牙设备前缀】
#define kMyDevicePrefix (@"SWLOCK")
// 设置蓝牙的channel值【开发者可不做修改】
#define channelOnPeropheralView @"peripheral"

@protocol LDRBabyBluetoothManageDelegate <NSObject>

@optional

/**
 蓝牙被关闭
 */
- (void)systemBluetoothClose;

/**
 蓝牙已开启
 */
- (void)sysytemBluetoothOpen;


/**
 扫描到的设备回调
 
 @param peripheralInfoArr 扫描到的蓝牙设备数组
 */
- (void)getScanResultPeripherals:(NSArray *)peripheralInfoArr;


/**
 连接成功
 */
- (void)connectSuccess;


/**
 连接失败
 */
- (void)connectFailed;


/**
 当前断开的设备
 
 @param peripheral 断开的peripheral信息
 */
- (void)disconnectPeripheral:(CBPeripheral *)peripheral;

- (void)didUpdateCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;

/**
 读取蓝牙数据
 
 @param valueData 蓝牙设备发送过来的data数据
 */
- (void)readData:(NSData *)valueData;

/// 读取蓝牙数据
/// @param characteristic 特征
/// @param error 错误
- (void)readDataForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;

/// 写入蓝牙数据回调
/// @param characteristic 特征值
/// @param error 错误
- (void)didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;
@end


@interface LDRBabyBluetoothManager : NSObject

//外设的服务UUID值
@property (nonatomic, copy) NSString *serverUUIDString;
//外设的写入UUID值
@property (nonatomic, copy) NSString *writeUUIDString;
//外设的读取UUID值
@property (nonatomic, copy) NSString *readUUIDString;

@property (nonatomic, copy) NSString *macString;

@property (nonatomic, copy) NSString *imeiString;
@property (nonatomic, copy) NSString *imsiString;
@property (nonatomic) NSInteger battery;
@property (nonatomic) NSInteger nbSignal;
@property (nonatomic, copy) NSString *NbModel;

/**
 单例
 
 @return 单例对象
 */
+ (LDRBabyBluetoothManager *)sharedManager;


@property (nonatomic, weak) id<LDRBabyBluetoothManageDelegate> delegate;


/**
 开始扫描周边蓝牙设备
 */
- (void)startScanPeripheral;


/**
 停止扫描
 */
- (void)stopScanPeripheral;


/**
 连接所选取的蓝牙外设
 
 @param peripheral 所选择蓝牙外设的perioheral
 */
-(void)connectPeripheral:(CBPeripheral *)peripheral;


/**
 获取当前连接成功的蓝牙设备数组
 
 @return 返回当前所连接成功蓝牙设备数组
 */
- (NSArray *)getCurrentPeripherals;
- (NSDictionary *)getCurrentPeripheralsAdWithPeripherals:(CBPeripheral *)peripheral;


/**
 获取设备的服务跟特征值
 当已连接成功时调用有效
 */
- (void)searchServerAndCharacteristicUUID;


/**
 断开当前连接的所有蓝牙设备
 */
- (void)disconnectAllPeripherals;


/**
 断开所选择的蓝牙设备
 
 @param peripheral 所选择蓝牙外设的perioheral
 */
- (void)disconnectLastPeripheral:(CBPeripheral *)peripheral;

/**
 向蓝牙设备发送数据
 
 @param msgData 数据data值
 */
- (void)write:(NSData *)msgData;

///发送数据
- (void)writeFF01:(NSData *)msgData;

@end
