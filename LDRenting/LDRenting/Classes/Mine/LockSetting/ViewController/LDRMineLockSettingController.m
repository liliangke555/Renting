//
//  LDRMineLockSettingController.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMineLockSettingController.h"
#import "LDRLockSettingHeaderView.h"
#import "LDRLockSettingTableCell.h"
#import "LDRSetPasswordController.h"
#import "LDRBuleToothOpenAlertView.h"
#import "LDRLockRecordController.h"
#import "LDRLandlordAuthorityController.h"
#import "LDRLockOtherSettingController.h"
static CGFloat headrHeight = 174;

static NSString *const LDRSetting = @"房东权限设置";
static NSString *const LDRNetFix = @"NB-IoT网络修复";
static NSString *const LDRNetOPen = @"NB-IoT网络开关";
static NSString *const LDROther = @"其他设置";
@interface LDRMineLockSettingController ()
@property (nonatomic, strong)LDRLockSettingHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LDRMineLockSettingController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"门锁设置";
    [self headerView];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass( [LDRLockSettingTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRLockSettingTableCell class])];
}
- (void)showAlert
{
    LDRWeakify(self);
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            [weakSelf showBuleToothOpenDoor];
        }
    };
    NSArray *items =@[MMItemMake(@"我知道了", MMItemTypeNormal, block)];
    LDRAlterView *alert = [[LDRAlterView alloc] initWithTitle:@"您还未打开蓝牙" setImage:^(UIImageView * _Nonnull imageView) {
        [imageView setImage:[UIImage imageNamed:@"add_step_one"]];
    } detail:@"为不影响功能使用，请先去系统设置打开蓝牙开关" items:items];
    [alert show];
}
- (void)showBuleToothOpenDoor
{
    LDRBuleToothOpenAlertView *alertView = [[LDRBuleToothOpenAlertView alloc] initWithTitle:@"请靠近门锁，并保持在3米之内"];
    [alertView show];
    
//    LDRWeakify(alertView);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        alertView.openType = LDRBuleToothOpenFailure;
    });
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    LDRLockSettingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRLockSettingTableCell class])];
    cell.title = [dic objectForKey:@"key"];
    cell.detail = [dic objectForKey:@"detail"];
    cell.imageString = [dic objectForKey:@"image"];
    if ([[dic objectForKey:@"key"] isEqualToString:LDRNetOPen]) {
        cell.open = YES;
    } else {
        cell.open = NO;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"key"];
    if ([title isEqualToString:LDRSetting]) {
        LDRLandlordAuthorityController *vc = [[LDRLandlordAuthorityController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:LDRNetFix]) {
        
    }
    if ([title isEqualToString:LDROther]) {
        LDRLockOtherSettingController *vc = [[LDRLockOtherSettingController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Getter
-(LDRLockSettingHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LDRLockSettingHeaderView class])
                                                     owner:nil
                                                   options:nil] lastObject];
        [self.view addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(headrHeight);
        }];
        LDRWeakify(self);
        [_headerView didClickRecords:^{
            LDRLockRecordController *vc = [[LDRLockRecordController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } didClickBuleTooth:^{
            [weakSelf showAlert];
            
        } didClickPassword:^{
            LDRSetPasswordController *vc = [[LDRSetPasswordController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headerView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
            @{@"key":LDRSetting,
              @"detail":@"房东权限设置：包括指纹权限、本地密码权限、IC卡权限",
              @"image":@"lock_setting_set"
            },
            @{@"key":LDRNetFix,
              @"detail":@"是否遇到远程无法开锁、授权密码无法开锁、开锁无法上报；若遇到此类问题，可能是NB-IoT网络出现问题。",
              @"image":@"lock_net_fix"
            },
            @{@"key":LDRNetOPen,
              @"detail":@"注意：关闭NB-IoT网络会导致远程无法开锁、授权密码无法开锁、开锁功能无法上报。但不影响指纹密码钥匙蓝牙正常开锁",
              @"image":@"lock_net_open"
            },
            @{@"key":LDROther,
              @"detail":@"设置门锁基本参数，例如音量、同步时间、禁用开关，出厂设置等；可查看门锁基本信息。",
              @"image":@"lock_setting_other"
            },
        ];
    }
    return _dataSource;
}
@end
