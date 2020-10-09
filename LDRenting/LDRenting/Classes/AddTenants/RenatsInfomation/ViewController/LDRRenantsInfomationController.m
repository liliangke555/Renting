//
//  LDRRenantsInfomationController.m
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRenantsInfomationController.h"
#import "LDRRenantsInfoHeaderCell.h"
#import "LDRRenatsInfoBottomCell.h"
#import "LDRRenantsInfoHouseTableCell.h"
#import "LDRRenantsFlagTableCell.h"
#import "LDRUserCanOpenTableCell.h"
#import "LDRUserCanOpenTimeTableCell.h"
#import "LDROpenDoorTypeTableCell.h"
#import "LDROfflineOpenTableCell.h"
#import "LDRAddFlagController.h"
#import "LDRFingerprintManagerController.h"
#import "LDRICCardManagerController.h"
#import "LDRChangePhoneViewController.h"
static NSString *const RenatsInfo = @"RenatsInfo";
static NSString *const RenatsInfoKey = @"成员信息";
static NSString *const RenatsInfoKeyHouse = @"房屋信息";
static NSString *const RenatsInfoKeyFlag = @"成员标签";
static NSString *const RenatsInfoKeyMore = @"更多信息";

static NSString *const RenatsJurisdiction = @"RenatsJurisdiction";
static NSString *const RenatsCanOpenDoor = @"成员开门权限";
static NSString *const RenatsCanOpenTime = @"权限有效期";

static NSString *const RenatsBlueToothOpen = @"默认开门方式";
static NSString *const RenatsSettingOffline = @"设置线下开门方式";
@interface LDRRenantsInfomationController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign,getter=isOpenMore) BOOL openMore;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LDRRenantsInfomationController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:LDR_BackgroundColor];
    self.navigationItem.title = @"租客详情";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRRenantsInfoHeaderCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRRenantsInfoHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRRenatsInfoBottomCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRRenatsInfoBottomCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRRenantsInfoHouseTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRRenantsInfoHouseTableCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRRenantsFlagTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRRenantsFlagTableCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRUserCanOpenTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRUserCanOpenTableCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRUserCanOpenTimeTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRUserCanOpenTimeTableCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDROpenDoorTypeTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDROpenDoorTypeTableCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDROfflineOpenTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDROfflineOpenTableCell class])];
}
#pragma mark - IBAction
- (void)bottomButtonAction:(UIButton *)sender
{
    LDRWeakify(self);
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            
        } else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
                      MMItemMake(@"确定", MMItemTypeNormal, block)];
    LDRAlterView *alert = [[LDRAlterView alloc] initWithTitle:@"删除租客" detail:@"确认将该租客删除吗？" isWarning:YES items:items];
    alert.attachedView = self.view;
    alert.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alert.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alert show];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [self.dataSource objectAtIndex:section];
    NSString *key = dic[@"key"];
    if ([key isEqualToString:RenatsInfo]) {
        if (!self.isOpenMore) {
            return 2;
        }
    }
    return [dic[@"detail"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.dataSource objectAtIndex:indexPath.section][@"key"];
    NSArray *details = [self.dataSource objectAtIndex:indexPath.section][@"detail"];
    if ([key isEqualToString:RenatsInfo]) {
        NSString *title = [details objectAtIndex:indexPath.row][@"key"];
        if ([title isEqualToString:RenatsInfoKey]) {
            LDRRenantsInfoHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRRenantsInfoHeaderCell class])];
            [cell setDidClickChange:^{
                LDRChangePhoneViewController *vc = [[LDRChangePhoneViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            return cell;
        }
        if (([title isEqualToString:RenatsInfoKeyMore] && self.isOpenMore) || ([title isEqualToString:RenatsInfoKeyHouse] && !self.isOpenMore)) {
            LDRRenatsInfoBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRRenatsInfoBottomCell class])];
            cell.open = self.isOpenMore;
            return cell;
        }
        if ([title isEqualToString:RenatsInfoKeyHouse]) {
            LDRRenantsInfoHouseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRRenantsInfoHouseTableCell class])];
            cell.title = title;
            return cell;
        }
        if ([title isEqualToString:RenatsInfoKeyFlag]) {
            LDRRenantsFlagTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRRenantsFlagTableCell class])];
            cell.title = title;
            LDRWeakify(self);
            cell.didClickAddFlag = ^{
                LDRAddFlagController *vc = [[LDRAddFlagController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            return cell;
        }
    }
    if ([key isEqualToString:RenatsJurisdiction]) {
        NSString *title = [details objectAtIndex:indexPath.row][@"key"];
        if ([title isEqualToString:RenatsCanOpenDoor]) {
            LDRUserCanOpenTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRUserCanOpenTableCell class])];
            cell.title = title;
            return cell;
        }
        if ([title isEqualToString:RenatsCanOpenTime]) {
            LDRUserCanOpenTimeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRUserCanOpenTimeTableCell class])];
            cell.title = title;
            return cell;
        }
    }
    if ([key isEqualToString:RenatsBlueToothOpen]) {
        LDROpenDoorTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDROpenDoorTypeTableCell class])];
        [cell.titlesLabel setText:key];
        return cell;
    }
    if ([key isEqualToString:RenatsSettingOffline]) {
        LDROfflineOpenTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDROfflineOpenTableCell class])];
        [cell setDidClickFinger:^{
            LDRFingerprintManagerController *vc = [[LDRFingerprintManagerController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell setDidClickicCard:^{
            LDRICCardManagerController* vc = [[LDRICCardManagerController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }
    
    return [UITableViewCell new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.dataSource objectAtIndex:indexPath.section][@"key"];
    NSArray *details = [self.dataSource objectAtIndex:indexPath.section][@"detail"];
    if ([key isEqualToString:RenatsInfo]) {
        NSString *title = [details objectAtIndex:indexPath.row][@"key"];
        if (([title isEqualToString:RenatsInfoKeyMore] && self.isOpenMore) || ([title isEqualToString:RenatsInfoKeyHouse] && !self.isOpenMore)) {
            self.openMore = !self.isOpenMore;
            [self.tableView reloadData];
        }
    }
}
#pragma mark - Getter
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
            @{@"key":RenatsInfo,@"detail":@[
        @{@"key":RenatsInfoKey},
        @{@"key":RenatsInfoKeyHouse},
        @{@"key":RenatsInfoKeyFlag},
        @{@"key":RenatsInfoKeyMore}]},
            @{@"key":RenatsJurisdiction,
              @"detail":@[@{@"key":RenatsCanOpenDoor},@{@"key":RenatsCanOpenTime}],
            },
            @{@"key":RenatsBlueToothOpen,@"detail":@[@""]},
            @{@"key":RenatsSettingOffline,@"detail":@[@""]}
        ];
    }
    return _dataSource;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        
        UIButton *button = [UIButton viceButtonWithTarget:self action:@selector(bottomButtonAction:)];
        [_bottomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bottomView.mas_top).mas_offset(LDRPadding);
            make.left.right.equalTo(_bottomView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
            make.bottom.equalTo(_bottomView.mas_bottom).mas_offset(-LDRPadding-KBottomSafeHeight);
        }];
        [button setTitle:@"删除租客" forState:UIControlStateNormal];
    }
    return _bottomView;
}
- (void)viewDidLayoutSubviews
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}
@end
