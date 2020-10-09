//
//  LDRBluetoothController.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBluetoothController.h"
#import "LDRBlueToothCell.h"
#import "LDRHouseInfoController.h"
#import "LDRLockManageTableCell.h"
#import "LDRBabyBluetoothManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <Lottie/Lottie.h>
#import "LDRAddLockRequest.h"
static CGFloat tableRowHeight = 96.0f;
static CGFloat sectionHeight = 236;
@interface LDRBluetoothController ()<LDRBabyBluetoothManageDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) LDRBabyBluetoothManager *buleManager;
@end

@implementation LDRBluetoothController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    self.navigationItem.title = @"蓝牙添加";
    [self.view setBackgroundColor:LDR_BackgroundColor];
    [self setupView];
    [self initBabyBuletooth];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)setupView
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRBlueToothCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRBlueToothCell class])];
    [self.tableView setRowHeight:tableRowHeight];

}
#pragma mark - Networking
- (void)loadAddLock
{
    LDRPeripheralInfo *info = self.dataSource[self.selectedIndex];
    NSData *data = [info.advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
    NSData *macData = [data subdataWithRange:NSMakeRange(2, 6)];
    NSData *sVersionData = [data subdataWithRange:NSMakeRange(9, 2)];
    NSData *hVersionData = [data subdataWithRange:NSMakeRange(11, 2)];
    NSData *modelData = [data subdataWithRange:NSMakeRange(17, 8)];

    LDRAddLockRequest *request = [LDRAddLockRequest new];
    request.deviceName = info.peripheral.name;
    request.electric = [NSString stringWithFormat:@"%ld",self.buleManager.battery];
    NSInteger i = [NSString numberWithHexString:[NSString stringFromData:[hVersionData subdataWithRange:NSMakeRange(0, 1)]]];
    NSInteger j = [NSString numberWithHexString:[NSString stringFromData:[hVersionData subdataWithRange:NSMakeRange(1, 1)]]];
    request.hardVersion = [NSString stringWithFormat:@"%ld.%ld",i,j];
    request.imei = self.buleManager.imeiString;
    request.imsi = self.buleManager.imsiString;
    request.mac = [NSString stringFromData:macData];
    request.model = [NSString stringFromHexString:[NSString stringFromData:modelData]];
    request.nbModelType = self.buleManager.NbModel;
    request.signal = [NSString stringWithFormat:@"%ld",self.buleManager.nbSignal];
    i = [NSString numberWithHexString:[NSString stringFromData:[sVersionData subdataWithRange:NSMakeRange(0, 1)]]];
    j = [NSString numberWithHexString:[NSString stringFromData:[sVersionData subdataWithRange:NSMakeRange(1, 1)]]];
    request.softVersion = [NSString stringWithFormat:@"%ld.%ld",i,j];
    LDRWeakify(self);
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {

        LDRHouseInfoController *vc = [[LDRHouseInfoController alloc] init];
        vc.macString = [NSString stringFromData:macData];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } failHandler:^(BaseResponse *response) {
        
    }];
}
#pragma mark -
- (void)initBabyBuletooth
{
    _buleManager = [LDRBabyBluetoothManager sharedManager];
    _buleManager.macString = self.scanQRCode;
    _buleManager.delegate = self;
}
- (void)showBuleToothAlert
{
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 1) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }
    };
    NSArray *items =@[MMItemMake(LDRAlterCancle, MMItemTypeNormal, block),
                      MMItemMake(LDRAlterGoTo, MMItemTypeNormal, block)];
    LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"提示"
                                                         detail:@"请在iphone的“设置-蓝牙”选项中，打开你的蓝牙"
                                                          items:items];
    [alertView show];
}
#pragma mark - LDRBabyBluetoothManageDelegate
- (void)systemBluetoothClose
{
    // 系统蓝牙被关闭、提示用户去开启蓝牙
    [self showBuleToothAlert];
}
- (void)sysytemBluetoothOpen
{
    // 系统蓝牙已开启、开始扫描周边的蓝牙设备
    [_buleManager startScanPeripheral];
}
- (void)getScanResultPeripherals:(NSArray *)peripheralInfoArr
{
    // 这里获取到扫描到的蓝牙外设数组、添加至数据源中
    if (self.dataSource.count>0) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:peripheralInfoArr];
    [self.tableView reloadData];
}
- (void)connectSuccess
{
    [LDRHUD hideHUDForView:self.view];
    [LDRHUD showSuccessfulWithMessage:@"连接成功" view:self.view];
    
//    NSArray * array = [[LDRBabyBluetoothManager sharedManager] getCurrentPeripherals];
//    CBPeripheral *p = array[0];
////    NSLog(@"-%@",p.identifier);
//    NSDictionary *ad = [[LDRBabyBluetoothManager sharedManager] getCurrentPeripheralsAdWithPeripherals:array[0]];
    
//    LDRPeripheralInfo *info = self.dataSource[self.selectedIndex];
//    NSData *data = [info.advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
//    NSData *macData = [data subdataWithRange:NSMakeRange(2, 6)];
//    NSString *macString = [NSString stringFromData:macData];
//    macString = [NSString stringWithFormat:@"00000000-0000-1000-8000-%@",macString];
//    NSArray *arr = [macString componentsSeparatedByString:@"-"];
//    NSMutableArray *arrM = [NSMutableArray arrayWithArray:arr];
//    [arrM replaceObjectAtIndex:0 withObject:@"0000FF07"];
//    NSString *uuidString = [arrM componentsJoinedByString:@"-"];
//    [arrM replaceObjectAtIndex:0 withObject:@"00000001"];
//    NSString *serverUUID = [arrM componentsJoinedByString:@"-"];
//    
//    
//    
//    // 连接成功 写入UUID值【替换成自己的蓝牙设备UUID值】
//    _buleManager.serverUUIDString = serverUUID;
//    _buleManager.writeUUIDString = uuidString;
//    _buleManager.readUUIDString = uuidString;
    

    
}
- (void)connectFailed
{
    [LDRHUD hideHUDForView:self.view];
    [LDRHUD showHUDWithMessage:@"连接失败"];
    // 连接失败、做连接失败的处理
}
- (void)disconnectPeripheral:(CBPeripheral *)peripheral
{
    // 获取到当前断开的设备 这里可做断开UI提示处理
    NSLog(@"----蓝牙连接已断开");
    [LDRHUD showHUDWithMessage:@"蓝牙连接已断开"];
}
- (void)readData:(NSData *)valueData
{
//    // 获取到蓝牙设备发来的数据
//    if (valueData) {
//        NSString *string = [NSString stringFromData:valueData];
//        NSLog(@"蓝牙发来的数据 = %@",[NSString stringWithFormat:@"%@",valueData]);
//        NSLog(@"蓝牙发来的数据 = %@",string);
//    }
}
- (void)readDataForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (!error && [characteristic.UUID.UUIDString hasPrefix:@"0000FF07"]) {
        NSData *lmeiLengthData = [characteristic.value subdataWithRange:NSMakeRange(0, 1)];
        NSInteger i = [NSString numberWithHexString:[NSString stringFromData:lmeiLengthData]];
        if (i != 0) {
            [self loadAddLock];
        } else {
            LDRWeakify(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *string = @"01";
                [weakSelf.buleManager write:[NSString dataFromString:string]];
            });
        }
    }
}
-  (void)didUpdateCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        [LDRHUD showHUDWithMessage:error.localizedDescription];
    }
//    if ([characteristic.UUID.UUIDString isEqualToString:_buleManager.readUUIDString]) {
//
//    }
}
- (void)didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {

    }
}
#pragma mark - LDRBlueAddDelegate

- (void)buleAddWithIndex:(NSInteger)index
{
    [LDRHUD showBlueToothConnectingInView:self.view];
    self.selectedIndex = index;
    LDRPeripheralInfo *info = self.dataSource[index];
    // 去连接当前选择的Peripheral
    [_buleManager connectPeripheral:info.peripheral];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count] > 0 ? 1 : 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRBlueToothCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRBlueToothCell class])];
    LDRPeripheralInfo *info = self.dataSource[indexPath.row];
    NSData *data = [info.advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
    NSData *macData = [data subdataWithRange:NSMakeRange(2, 6)];
    NSString *macString = [NSString stringFromData:macData];
    [cell setTitleString:macString];
    [cell setSingnal:fabsf([info.RSSI floatValue] / 100.0f)];
    LDRWeakify(self);
    [cell didClickAddButton:^{
        [weakSelf buleAddWithIndex:indexPath.row];
    }];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.titleView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_buletooth"];
}
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"未搜索到门锁，请检查蓝牙是否打\n开，并靠近门锁重新搜索";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
// MARK: 空白页添加按钮，设置按钮文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    // 设置按钮标题
    NSString *buttonTitle = @"重新搜索";
    UIColor *buttonColor = (state == UIControlStateNormal) ? LDR_GrayColor : LDR_BackgroundColor;
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont14,
        NSForegroundColorAttributeName: buttonColor
    };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}
// MARK: 空白页添加按钮，设置按钮背景图片
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
   
    UIImage *image;
    if (state == UIControlStateNormal) {
        image = [UIImage imageNamed:@"button_background"];
    }
    if (state == UIControlStateHighlighted) {
        image = [UIImage imageNamed:@"button_background"];
    }
    UIEdgeInsets capInsets = UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsMake(0.0, 10, 0.0, 10);
    return [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // 处理空白页面按钮点击事件
    NSLog(@"处理空白页面按钮点击事件");
    [_buleManager startScanPeripheral];
}
#pragma mark - Getter
- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        [_titleView setBackgroundColor:LDR_BackgroundColor];
        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        [_titleView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_titleView.mas_top).mas_offset(24);
//            make.width.height.mas_equalTo(100);
//            make.centerX.equalTo(_titleView);
//        }];
//        [imageView setImage:[UIImage imageNamed:@"blue_icon"]];
        
        LOTAnimationView *animationView = [LOTAnimationView animationWithFilePath:[[NSBundle mainBundle] pathForResource:@"2727-qimtronics_" ofType:@"json"]];
        animationView.loopAnimation = YES;
        [_titleView addSubview:animationView];
        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_top).mas_offset(24);
            make.width.height.mas_equalTo(100);
            make.centerX.equalTo(_titleView);
        }];
        [animationView play];
        
        UILabel *typeLabel = [[UILabel alloc] init];
        [_titleView addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(animationView.mas_bottom).mas_offset(8);
            make.centerX.equalTo(_titleView);
        }];
        [typeLabel setTextColor:LDR_TextBalckColor];
        [typeLabel setFont:LDRBoldFont18];
        typeLabel.text = @"搜索中";
        
        UILabel *label = [[UILabel alloc] init];
        [_titleView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(typeLabel.mas_bottom).mas_offset(16);
            make.centerX.equalTo(_titleView);
        }];
        [label setTextColor:LDR_TextLightGrayColor];
        [label setFont:LDRFont16];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.text = @"请打开蓝牙后靠近门锁，进行\n房屋切换操作";
        [label setNumberOfLines:0];
    }
    return _titleView;
}

@end
