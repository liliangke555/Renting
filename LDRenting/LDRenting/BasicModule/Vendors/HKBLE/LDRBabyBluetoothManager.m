//
//  HKBabyBluetoothManager.m
//  HKBabyBluetooth
//
//  Created by 刘华坤 on 2019/3/15.
//  Copyright © 2018年 liuhuakun. All rights reserved.
//

#import "LDRBabyBluetoothManager.h"

@interface LDRBabyBluetoothManager ()

@property (nonatomic, strong) BabyBluetooth    *babyBluetooth;
//扫描到的外设设备数组
@property (nonatomic, strong) NSMutableArray   *peripheralArr;
//写数据特征值
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;
//读数据特征值
@property (nonatomic, strong) CBCharacteristic *readCharacteristic;
//当前连接的外设设备
@property (nonatomic, strong) CBPeripheral     *currentPeripheral;

//写数据特征值
@property (nonatomic, strong) CBCharacteristic *writeFF01Characteristic;
//写数据特征值
//@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;
////写数据特征值
//@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@end

@implementation LDRBabyBluetoothManager


///lazy
- (NSMutableArray *)peripheralArr {
    if (!_peripheralArr) {
        _peripheralArr = [NSMutableArray new];
    }
    return _peripheralArr;
}


+ (LDRBabyBluetoothManager *)sharedManager {
    static LDRBabyBluetoothManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LDRBabyBluetoothManager alloc] init];
    });
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initBabyBluetooth];
    }
    return self;
}


- (void)initBabyBluetooth {
    self.babyBluetooth = [BabyBluetooth shareBabyBluetooth];
    [self babyBluetoothDelegate];
}


#pragma mark 蓝牙配置
- (void)babyBluetoothDelegate {
    __weak typeof(self) weakSelf = self;
    
    // 1-系统蓝牙状态
    [self.babyBluetooth setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 从block中取到值，再回到主线程
            if ([weakSelf respondsToSelector:@selector(systemBluetoothState:)]) {
                [weakSelf systemBluetoothState:central.state];
            }
        });
    }];
    
    // 2-设置查找设备的过滤器
    [self.babyBluetooth setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        // 最常用的场景是查找某一个前缀开头的设备
        if ([peripheralName hasPrefix:kMyDevicePrefix]) {
            if (weakSelf.macString.length > 0) {
                NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
                NSData *macData = [data subdataWithRange:NSMakeRange(2, 6)];
                NSString *mac = [NSString stringFromData:macData];
                if ([mac isEqualToString:weakSelf.macString]) {
                    return YES;
                }
                return NO;
            }
            return YES;
        }
        return NO;
    }];
    
    // 查找的规则
    [self.babyBluetooth setFilterOnDiscoverPeripheralsAtChannel:channelOnPeropheralView
                                                         filter:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
                                                             // 最常用的场景是查找某一个前缀开头的设备
                                                             if ([peripheralName hasPrefix:kMyDevicePrefix]) {
                                                                 if (weakSelf.macString.length > 0) {
                                                                     NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
                                                                     NSData *macData = [data subdataWithRange:NSMakeRange(2, 6)];
                                                                     NSString *mac = [NSString stringFromData:macData];
                                                                     if ([mac isEqualToString:weakSelf.macString]) {
                                                                         return YES;
                                                                     }
                                                                     return NO;
                                                                 }
                                                                 return YES;
                                                             }
                                                             return NO;
                                                         }];
    
    //设置连接规则
    [self.babyBluetooth setFilterOnConnectToPeripheralsAtChannel:channelOnPeropheralView
                                                          filter:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
                                                              return NO;
                                                          }];
    
    //2.1-设备连接过滤器
    [self.babyBluetooth setFilterOnConnectToPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //不自动连接
        return NO;
    }];
    
    //3-设置扫描到设备的委托
    [self.babyBluetooth setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 从block中取到值，再回到主线程
            if ([weakSelf respondsToSelector:@selector(scanResultPeripheral: advertisementData: rssi:)]) {
                [weakSelf scanResultPeripheral:peripheral advertisementData:advertisementData rssi:RSSI];
            }
        });
    }];
    
    BabyRhythm *rhythm = [[BabyRhythm alloc]init];
    //4-设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [self.babyBluetooth setBlockOnConnectedAtChannel:channelOnPeropheralView
                                               block:^(CBCentralManager *central, CBPeripheral *peripheral) {
                                                   NSLog(@"【HKBabyBluetooth】->连接成功");
        
                                                    NSArray * arr = [[NSUserDefaults standardUserDefaults] objectForKey:LDRBuleToothConnected];
                                                    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:arr];
                                                    [arrayM addObject:peripheral.identifier.UUIDString];
                                                    [[NSUserDefaults standardUserDefaults] setObject:arrayM forKey:LDRBuleToothConnected];
        
        for (LDRPeripheralInfo *info in weakSelf.peripheralArr) {
            if ([info.peripheral.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
                NSData *data = [info.advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
                NSData *macData = [data subdataWithRange:NSMakeRange(2, 6)];
                NSString *macString = [NSString stringFromData:macData];
                macString = [NSString stringWithFormat:@"00000000-0000-1000-8000-%@",macString];
                NSArray *arr = [macString componentsSeparatedByString:@"-"];
                NSMutableArray *arrM = [NSMutableArray arrayWithArray:arr];
                [arrM replaceObjectAtIndex:0 withObject:@"00000001"];
                NSString *serverUUID = [arrM componentsJoinedByString:@"-"];
                // 连接成功 写入UUID值【替换成自己的蓝牙设备UUID值】
                weakSelf.serverUUIDString = serverUUID;
            }
        }
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       // 从block中取到值，再回到主线程
                                                       if ([weakSelf respondsToSelector:@selector(connectSuccess)]) {
                                                           [weakSelf connectSuccess];
                                                       }
                                                   });
                                               }];
    
    // 5-设置设备连接失败的委托
    [self.babyBluetooth setBlockOnFailToConnectAtChannel:channelOnPeropheralView
                                                   block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
                                                       NSLog(@"【HKBabyBluetooth】->连接失败");
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           // 从block中取到值，再回到主线程
                                                           if ([weakSelf respondsToSelector:@selector(connectFailed)]) {
                                                               [weakSelf connectFailed];
                                                           }
                                                       });
                                                   }];
    
    // 6-设置设备断开连接的委托
    [self.babyBluetooth setBlockOnDisconnectAtChannel:channelOnPeropheralView
                                                block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
                                                    NSLog(@"【HKBabyBluetooth】->设备：%@断开连接",peripheral.name);
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        // 从block中取到值，再回到主线程
                                                        if ([weakSelf respondsToSelector:@selector(disconnectPeripheral:)]) {
                                                            [weakSelf disconnectPeripheral:peripheral];
                                                        }
                                                    });
                                                }];
    
    // 7-设置发现设备的Services的委托
    [self.babyBluetooth setBlockOnDiscoverServicesAtChannel:channelOnPeropheralView
                                                      block:^(CBPeripheral *peripheral, NSError *error) {
                                                          [rhythm beats];
                                                      }];
    
    // 8-设置发现设service的Characteristics的委托
    [self.babyBluetooth setBlockOnDiscoverCharacteristicsAtChannel:channelOnPeropheralView
                                                             block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
                                                                 NSString *serviceUUID = [NSString stringWithFormat:@"%@",service.UUID];
                                                                 if ([serviceUUID isEqualToString:weakSelf.serverUUIDString]) {
                                                                     for (CBCharacteristic *ch in service.characteristics) {
                                                                         // 写数据的特征值
                                                                         NSString *chUUID = ch.UUID.UUIDString;
                                                                         if ([chUUID isEqualToString:weakSelf.writeUUIDString]) {
                                                                             weakSelf.writeCharacteristic = ch;
                                                                         }
                                                                         if ([chUUID hasPrefix:@"0000FF07-"]) {
                                                                             weakSelf.writeCharacteristic = ch;
                                                                         }
                                                                         if ([chUUID hasPrefix:@"0000FF01-"]) {
                                                                             weakSelf.writeFF01Characteristic = ch;
                                                                         }
                                                                         
                                                                         // 读数据的特征值
//                                                                         if ([chUUID isEqualToString:weakSelf.readUUIDString]) {
//                                                                             weakSelf.readCharacteristic = ch;
//                                                                             [weakSelf.currentPeripheral setNotifyValue:YES
//                                                                                                      forCharacteristic:weakSelf.readCharacteristic];
//                                                                         }
                                                                         if ([chUUID hasPrefix:@"0000FF07-"]) {
                                                                             [weakSelf.currentPeripheral setNotifyValue:YES
                                                                                                      forCharacteristic:ch];
                                                                         }
                                                                         if ([chUUID hasPrefix:@"0000FF09-"]) {
                                                                             [weakSelf.currentPeripheral setNotifyValue:YES
                                                                                                      forCharacteristic:ch];
                                                                         }
                                                                     }
                                                                 }
                                                             }];
    
    // 9-设置读取characteristics的委托
    [self.babyBluetooth setBlockOnReadValueForCharacteristicAtChannel:channelOnPeropheralView
                                                                block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        if ([characteristics.UUID.UUIDString hasPrefix:@"0000FF07"]) {
                                                                            if (characteristics.value) {
                                                                                NSString *string = [NSString stringFromData:characteristics.value];
                                                                                NSLog(@"蓝牙发来的数据 === %@",string);
                                                                                NSData *lmeiLengthData = [characteristics.value subdataWithRange:NSMakeRange(0, 1)];
                                                                                NSInteger i = [NSString numberWithHexString:[NSString stringFromData:lmeiLengthData]];
                                                                                if (i != 0) {
                                                                                    NSData *lmeiData = [characteristics.value subdataWithRange:NSMakeRange(1, i)];
                                                                                    weakSelf.imeiString = [NSString stringFromHexString:[NSString stringFromData:lmeiData]];
                                                                                    
                                                                                    NSData *lmsiLengthData = [characteristics.value subdataWithRange:NSMakeRange(1+i, 1)];
                                                                                    NSInteger j = [NSString numberWithHexString:[NSString stringFromData:lmsiLengthData]];
                                                                                    NSData *lmsiData = [characteristics.value subdataWithRange:NSMakeRange(1+i+1, j)];
                                                                                    weakSelf.imsiString = [NSString stringFromHexString:[NSString stringFromData:lmsiData]];
                                                                                    
                                                                                    NSData *batteryData = [characteristics.value subdataWithRange:NSMakeRange(1+i+1+j, 1)];
                                                                                    weakSelf.battery = [NSString numberWithHexString:[NSString stringFromData:batteryData]];
                                                                                    
                                                                                    NSData *nbSignalData = [characteristics.value subdataWithRange:NSMakeRange(1+i+1+j+1+1, 1)];
                                                                                    weakSelf.nbSignal = [NSString numberWithHexString:[NSString stringFromData:nbSignalData]];
                                                                                    
                                                                                    NSData *NbModelData = [characteristics.value subdataWithRange:NSMakeRange(1+i+1+j+1+1+1+1+5, 1)];
                                                                                    NSInteger m = [NSString numberWithHexString:[NSString stringFromData:NbModelData]];
                                                                                    NSString *modelstring = @"未知";
                                                                                    if (m == 1) {
                                                                                        modelstring = @"BC28";
                                                                                    }
                                                                                    if (m == 2) {
                                                                                        modelstring = @"5310A";
                                                                                    }
                                                                                    weakSelf.NbModel = modelstring;
                                                                                }
                                                                            }
                                                                        }
                                                                        // 从block中取到值，再回到主线程
                                                                        if ([weakSelf respondsToSelector:@selector(readData:)]) {
                                                                            [weakSelf readData:characteristics.value];
                                                                        }
                                                                        if ([weakSelf.delegate respondsToSelector:@selector(readDataForCharacteristic:error:)]) {
                                                                            [weakSelf.delegate readDataForCharacteristic:characteristics error:error];
                                                                        }
                                                                        
                                                                    });
                                                                }];
    
    [self.babyBluetooth setBlockOnDidUpdateNotificationStateForCharacteristicAtChannel:channelOnPeropheralView
                                                                                 block:^(CBCharacteristic *characteristic, NSError *error) {
        
        if (error) {
            NSLog(@"Error changing notification state: %@", error.localizedDescription);
        }

        if ([weakSelf.delegate respondsToSelector:@selector(didUpdateCharacteristic:error:)]) {
            [weakSelf.delegate didUpdateCharacteristic:characteristic error:error];
        }
    }];
    
    [self.babyBluetooth setBlockOnDidWriteValueForCharacteristicAtChannel:channelOnPeropheralView block:^(CBCharacteristic *characteristic, NSError *error) {
        if (error) {
            NSLog(@"Error : %@", error.localizedDescription);
        }
        
        if ([weakSelf.delegate respondsToSelector:@selector(didWriteValueForCharacteristic:error:)]) {
            [weakSelf.delegate didWriteValueForCharacteristic:characteristic error:error];
        }
    }];
    // 设置发现characteristics的descriptors的委托
    [self.babyBluetooth setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnPeropheralView
                                                                          block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) { }];
    
    // 设置读取Descriptor的委托
    [self.babyBluetooth setBlockOnReadValueForDescriptorsAtChannel:channelOnPeropheralView
                                                             block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) { }];
    
    // 读取rssi的委托
    [self.babyBluetooth setBlockOnDidReadRSSI:^(NSNumber *RSSI, NSError *error) { }];
    
    // 设置beats break委托
    [rhythm setBlockOnBeatsBreak:^(BabyRhythm *bry) { }];
    
    // 设置beats over委托
    [rhythm setBlockOnBeatsOver:^(BabyRhythm *bry) { }];
    
    // 扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    /*连接选项->
     CBConnectPeripheralOptionNotifyOnConnectionKey :当应用挂起时，如果有一个连接成功时，如果我们想要系统为指定的peripheral显示一个提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnDisconnectionKey :当应用挂起时，如果连接断开时，如果我们想要系统为指定的peripheral显示一个断开连接的提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnNotificationKey:
     当应用挂起时，使用该key值表示只要接收到给定peripheral端的通知就显示一个提
     */
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnNotificationKey:@YES};
    
    [self.babyBluetooth setBabyOptionsAtChannel:channelOnPeropheralView
                  scanForPeripheralsWithOptions:scanForPeripheralsWithOptions
                   connectPeripheralWithOptions:connectOptions
                 scanForPeripheralsWithServices:nil
                           discoverWithServices:nil
                    discoverWithCharacteristics:nil];
    
    // 连接设备
    [self.babyBluetooth setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions
                                           connectPeripheralWithOptions:connectOptions
                                         scanForPeripheralsWithServices:nil
                                                   discoverWithServices:nil
                                            discoverWithCharacteristics:nil];
}

#pragma mark 对蓝牙操作
/// 蓝牙状态
- (void)systemBluetoothState:(CBManagerState)state  API_AVAILABLE(ios(10.0)) {
    if (state == CBManagerStatePoweredOn) {
        if ([self.delegate respondsToSelector:@selector(sysytemBluetoothOpen)]) {
            [self.delegate sysytemBluetoothOpen];
        }
    }else if (state == CBManagerStatePoweredOff) {
        if ([self.delegate respondsToSelector:@selector(systemBluetoothClose)]) {
            [self.delegate systemBluetoothClose];
        }
    }
}

/// 开始扫描
- (void)startScanPeripheral {
    self.babyBluetooth.scanForPeripherals().begin();
}

/// 扫描到的设备[由block回主线程]
- (void)scanResultPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)RSSI {
    for (LDRPeripheralInfo *peripheralInfo in self.peripheralArr) {
        if ([peripheralInfo.peripheral.identifier isEqual:peripheral.identifier]) {
            return;
        }
    }
    
    LDRPeripheralInfo *peripheralInfo = [[LDRPeripheralInfo alloc] init];
    peripheralInfo.peripheral = peripheral;
    peripheralInfo.advertisementData = advertisementData;
    peripheralInfo.RSSI = RSSI;
    [self.peripheralArr addObject:peripheralInfo];
    
    if ([self.delegate respondsToSelector:@selector(getScanResultPeripherals:)]) {
        [self.delegate getScanResultPeripherals:self.peripheralArr];
    }
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:LDRBuleToothConnected];
    for (NSString *uuidString in array) {
        if ([uuidString isEqualToString:peripheral.identifier.UUIDString]) {
            [self connectPeripheral:peripheral];
            break;
        }
    }
}


/// 停止扫描
- (void)stopScanPeripheral
{
    [self.peripheralArr removeAllObjects];
    [self.babyBluetooth cancelScan];
}


/// 连接设备
-(void)connectPeripheral:(CBPeripheral *)peripheral
{
    // 断开之前的所有连接
    [self.babyBluetooth cancelAllPeripheralsConnection];
    self.currentPeripheral = peripheral;
    NSLog(@"-- currentPeripheral : %@",self.currentPeripheral.identifier.UUIDString);
    self.babyBluetooth.having(peripheral).and.channel(channelOnPeropheralView).
    then.connectToPeripherals().discoverServices().
    discoverCharacteristics().readValueForCharacteristic().
    discoverDescriptorsForCharacteristic().
    readValueForDescriptors().begin();
}


/// 连接成功[由block回主线程]
- (void)connectSuccess {
    if ([self.delegate respondsToSelector:@selector(connectSuccess)]) {
        [self.delegate connectSuccess];
    }
}


/// 连接失败[由block回主线程]
- (void)connectFailed {
    if ([self.delegate respondsToSelector:@selector(connectFailed)]) {
        [self.delegate connectFailed];
    }
}


/// 获取当前断开的设备[由block回主线程]
- (void)disconnectPeripheral:(CBPeripheral *)peripheral
{
    if ([self.delegate respondsToSelector:@selector(disconnectPeripheral:)]) {
        [self.delegate disconnectPeripheral:peripheral];
    }
}


/// 获取当前连接
- (NSArray *)getCurrentPeripherals
{
    return [self.babyBluetooth findConnectedPeripherals];
}

- (NSDictionary *)getCurrentPeripheralsAdWithPeripherals:(CBPeripheral *)peripheral
{
    for (LDRPeripheralInfo *info in self.peripheralArr) {
        if ([info.peripheral.identifier isEqual:peripheral.identifier]) {
            return info.advertisementData;
        }
    }
    return nil;
}

///获取设备的服务跟特征值[当已连接成功时]
- (void)searchServerAndCharacteristicUUID {
    self.babyBluetooth.having(self.currentPeripheral).and.channel(channelOnPeropheralView).
    then.connectToPeripherals().discoverServices().discoverCharacteristics()
    .readValueForCharacteristic().discoverDescriptorsForCharacteristic().
    readValueForDescriptors().begin();
}


///断开所有连接
- (void)disconnectAllPeripherals {
    [self.babyBluetooth cancelAllPeripheralsConnection];
}


///断开当前连接
- (void)disconnectLastPeripheral:(CBPeripheral *)peripheral {
    [self.babyBluetooth cancelPeripheralConnection:peripheral];
}


///发送数据
- (void)write:(NSData *)msgData {
    if (self.writeCharacteristic == nil) {
        NSLog(@"【HKBabyBluetooth】->数据发送失败");
        return;
    }
    
    //若最后一个参数是CBCharacteristicWriteWithResponse
    //则会进入setBlockOnDidWriteValueForCharacteristic委托
    NSLog(@"-- writeCharacteristic : %@",self.writeCharacteristic.UUID.UUIDString);
    [self.currentPeripheral writeValue:msgData
                     forCharacteristic:self.writeCharacteristic
                                  type:CBCharacteristicWriteWithResponse];
}

///发送数据
- (void)writeFF01:(NSData *)msgData {
    if (self.writeFF01Characteristic == nil) {
        NSLog(@"【HKBabyBluetooth】->数据发送失败");
        return;
    }
    if (self.writeFF01Characteristic.properties & CBCharacteristicPropertyWrite) {
        
    } else {
        NSLog(@"该字段不能写！");
        return;
    }
    //若最后一个参数是CBCharacteristicWriteWithResponse
    //则会进入setBlockOnDidWriteValueForCharacteristic委托
    NSLog(@"-- writeFF01Characteristic : %@",self.writeFF01Characteristic.UUID.UUIDString);
    NSLog(@"-- currentPeripheral : %@",self.currentPeripheral.identifier.UUIDString);
    int len = (int)[msgData length];
    if (len >= 20) {
        NSData *dataTemp = [msgData subdataWithRange:NSMakeRange(0, 20)];
        [self.currentPeripheral writeValue:msgData
                         forCharacteristic:self.writeFF01Characteristic
                                      type:CBCharacteristicWriteWithResponse];
        for (int i = 0; i < len / 20; i++) {
            int lenTemp = 20;
            if ((len - (20 + 20 * i) < 20) && (len - (20 + 20 * i) > 0)) {//i == 1
                lenTemp = len - (20 + 20 * i);

            }
            if (len - (20 + 20 * i) > 0) {
                dataTemp = [msgData subdataWithRange:NSMakeRange(20 + 20 * i, lenTemp)];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.currentPeripheral writeValue:msgData
                                     forCharacteristic:self.writeFF01Characteristic
                                                  type:CBCharacteristicWriteWithResponse];
                });
            }
        }
    } else {
        [self.currentPeripheral writeValue:msgData
                         forCharacteristic:self.writeFF01Characteristic
                                      type:CBCharacteristicWriteWithResponse];
    }
}


///读取数据
- (void)readData:(NSData *)valueData {
    if ([self.delegate respondsToSelector:@selector(readData:)]) {
        [self.delegate readData:valueData];
    }
}


@end
