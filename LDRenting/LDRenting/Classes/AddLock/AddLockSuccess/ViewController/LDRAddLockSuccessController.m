//
//  LDRAddLockSuccessController.m
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddLockSuccessController.h"
#import "LDRSuccessHouseCell.h"
#import "LDRBabyBluetoothManager.h"
#import "LDRAddAuthByBTRequest.h"
static CGFloat const headerHeight = 243;
static CGFloat const rowHeight = 72;
static CGFloat const otherRowHeight = 50;


static NSString * const LDRHOUSE = @"LDRHOUSE";
static NSString * const LDRNOTE = @"LDRNOTE";
static LDROpenType const LDRfingerprint = LDROpenTypeFinger;
static LDROpenType const LDRPASSWORD = LDROpenTypeLocPassword;
static LDROpenType const LDRICCARD = LDROpenTypeICCard;

@interface LDRAddLockSuccessController ()<LDRBabyBluetoothManageDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) LDRSettingAlterView *alertView;

@property (nonatomic, strong) LDRBabyBluetoothManager *buleManager;

@property (nonatomic) LDROpenType openType;
@end

@implementation LDRAddLockSuccessController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LDR_BackgroundColor;
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"navigation_back_black"] action:@selector(backAction:)];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.rowHeight = rowHeight;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRSuccessHouseCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRSuccessHouseCell class])];
    
    self.buleManager = [LDRBabyBluetoothManager sharedManager];
    self.buleManager.delegate = self;
    
}
#pragma mark - Networking
- (void)loadSettingKeyDataWithType:(NSInteger)type
{
    
    NSArray * array = [[LDRBabyBluetoothManager sharedManager] getCurrentPeripherals];
    if (array.count <= 0) {
        [LDRHUD showBlueToothConnectingInView:self.view];
        [self.buleManager stopScanPeripheral];
        [self.buleManager startScanPeripheral];
        return;
    }
    [LDRHUD showLoadingInView:self.view];
    NSDictionary *ad = [[LDRBabyBluetoothManager sharedManager] getCurrentPeripheralsAdWithPeripherals:array[0]];
    NSData *infoData = [ad objectForKey:@"kCBAdvDataManufacturerData"];
    NSString *infoString = [NSString stringFromData:[infoData subdataWithRange:NSMakeRange(2, 22)]];
    
    LDRWeakify(self);
    LDRAddAuthByBTRequest *request = [LDRAddAuthByBTRequest new];
    request.blueBrdInfo = infoString;
    request.userHouseRelationId = self.userHouseRelationId;
    request.openType = type;
    request.validFlag = 1;
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
        LDRAddAuthByBTModel *model = response.data;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf showAlterViewWithKey:weakSelf.openType];
            [weakSelf.buleManager writeFF01:[model.key hexToBytes]];
        });
    } failHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
    }];
}
#pragma mark - IBAction
- (void)finishButtonAction:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)backAction:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)showAlterViewWithKey:(NSInteger)key
{
    NSString *title = nil;
    NSString *details = nil;
    NSString *type = nil;
    NSString *image = nil;
    if (key == LDRfingerprint) {
        title = @"请靠近门锁，按照语音提示进行设置";
        details = @"请将手指放置门锁传感器上";
        type = @"添加指纹中…";
        image = @"setting_fingerprint_normal";
    }
    if (key ==LDRPASSWORD) {
        title = @"请靠近门锁，按照语音提示进行设置";
        details = @"输入6位本地密码，按#号结束";
        type = @"添加本地密码中…";
        image = @"setting_password_normal";
    }
    if (key == LDRICCARD) {
        title = @"请靠近门锁，按照语音提示进行设置";
        details = @"请将IC卡贴近门锁上方进行识别设置";
        type = @"添加IC卡中…";
        image = @"setting_ic_normal";
    }
    
    LDRSettingAlterView *alter = [[LDRSettingAlterView alloc] initWithTitle:title details:details type:type loadImage:^(UIImageView * _Nonnull imageView) {
        [imageView setImage:[UIImage imageNamed:image]];
    } cancel:^(NSInteger index) {
        [LDRHUD showHUDWithMessage:@"已取消"];
    }];
    self.alertView = alter;
    [alter show];
    
    
}
#pragma mark - LDRBabyBluetoothManageDelegate
- (void)connectSuccess
{
    [LDRHUD hideHUDForView:self.view];
    [LDRHUD showSuccessfulWithMessage:@"蓝牙连接成功" view:self.view];
//    [self loadSettingKeyDataWithType:self.openType];
}
- (void)disconnectPeripheral:(CBPeripheral *)peripheral
{
    [self.alertView hide];
    [self loadSettingKeyDataWithType:self.openType];
}
- (void)readDataForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if ([characteristic.UUID.UUIDString hasPrefix:@"0000FF09"] && !error) {
        if (self.openType ==LDRfingerprint) {
           self.alertView.typeString = [NSString stringWithFormat:@"已添加%@的指纹1",self.houseName];
            self.alertView.isCompletion = YES;
            self.alertView.completionImage = @"setting_fingerprint_completion";
        }
        if (self.openType == LDRPASSWORD) {
            self.alertView.typeString = [NSString stringWithFormat:@"已添加%@的本地密码1",self.houseName];
            self.alertView.isCompletion = YES;
            self.alertView.completionImage = @"setting_password_completion";
        }
        if (self.openType == LDRICCARD) {
            self.alertView.typeString = [NSString stringWithFormat:@"已添加%@的IC卡1",self.houseName];
            self.alertView.isCompletion = YES;
            self.alertView.completionImage = @"setting_ic_completion";
        }
        for (NSDictionary *dic in self.dataSource) {
            id key = dic[@"key"];
            if ([key isKindOfClass:[NSNumber class]]) {
                if ([key integerValue] == self.openType) {
                    [dic setValue:@"已设置" forKey:@"details"];
                    break;;
                }
            }
        }
        [self.tableView reloadData];
    }
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    id key = dic[@"key"];
    if ([key isKindOfClass:[NSString class]]) {
        if ([key isEqualToString:LDRHOUSE] || [key isEqualToString:LDRNOTE]) {
            return rowHeight;
        }
    }
    return otherRowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    id key = dic[@"key"];
    NSString *title = dic[@"title"];
    NSString *details = dic[@"details"];
    if ([key isKindOfClass:[NSString class]]) {
        if ([key isEqualToString:LDRHOUSE]) {
            LDRSuccessHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRSuccessHouseCell class])];
            cell.title = self.houseName;
            return cell;
        }
        if ([key isEqualToString:LDRNOTE]) {
           UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LDRNOTE];
            if (!cell ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:LDRNOTE];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell setSeparatorInset:UIEdgeInsetsMake(LDRPadding, 0, 0, 0)];
                [cell.textLabel setFont:LDRFont16];
                [cell.textLabel setTextColor:LDR_TextBalckColor];
                [cell.detailTextLabel setFont:LDRFont12];
                [cell.detailTextLabel setTextColor:LDR_TextGrayColor];
            }
            cell.textLabel.text = title;
            cell.detailTextLabel.text = details;
            return cell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSeparatorInset:UIEdgeInsetsMake(LDRPadding, 0, 0, 0)];
        [cell.textLabel setFont:LDRFont16];
        [cell.textLabel setTextColor:LDR_TextBalckColor];
        [cell.detailTextLabel setFont:LDRFont16];
        [cell.detailTextLabel setTextColor:LDR_TextGrayColor];
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text = details;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSNumber *key = dic[@"key"];
    self.openType = [key integerValue];
    [self loadSettingKeyDataWithType:self.openType];
//    [self showAlterViewWithKey:[key integerValue]];
}

#pragma mark - Getter
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [_headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_top).mas_offset(8);
            make.centerX.equalTo(_headerView);
        }];
        [imageView setImage:[UIImage imageNamed:@"main_success"]];
        
        UILabel *label = [[UILabel alloc] init];
        [_headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom);
            make.centerX.equalTo(imageView);
        }];
        [label setFont:LDRFont16];
        [label setTextColor:LDR_TextBalckColor];
        [label setText:@"门锁添加成功"];
        
        UILabel *detailsLabel = [[UILabel alloc] init];
        [_headerView addSubview:detailsLabel];
        [detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).mas_offset(8);
            make.centerX.equalTo(imageView);
//            make.bottom.equalTo(_headerView.mas_bottom).mas_offset(-8);
        }];
        [detailsLabel setFont:LDRFont12];
        [detailsLabel setTextColor:LDR_TextGrayColor];
        [detailsLabel setText:[NSString stringWithFormat:@"MAC：%@",self.macString]];
        
    }
    return _headerView;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(finishButtonAction:)];
        [_bottomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.equalTo(_bottomView).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding + KBottomSafeHeight, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [button setTitle:@"设置完成" forState:UIControlStateNormal];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
    }
    return _bottomView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[
            @{
                @"title":@"大菠萝的家",
                @"key":LDRHOUSE
            },
            @{
                @"details":@"注：已默认开启蓝牙、远程密码开门方式",
                @"title":@"请选择要开启的功能",
                @"key":LDRNOTE
            },
            @{
                @"details":@"去设置",
                @"title":@"指纹开锁",
                @"key":@(LDRfingerprint)
            },
            @{
                @"details":@"去设置",
                @"title":@"本地密码",
                @"key":@(LDRPASSWORD)
            },
            @{
                @"details":@"去设置",
                @"title":@"IC卡",
                @"key":@(LDRICCARD)
            },
        ]];
    }
    return _dataSource;
}

- (void)viewDidLayoutSubviews
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), headerHeight);
    [self.tableView reloadData];
}

@end
