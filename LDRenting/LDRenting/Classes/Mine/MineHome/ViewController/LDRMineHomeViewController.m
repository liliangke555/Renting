//
//  LDRMineHomeViewController.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMineHomeViewController.h"
#import "LDRMineHomeHeaderView.h"
#import "LDRMineHomeTableViewCell.h"
#import "LDRMineNoTableViewCell.h"
#import "LDRMineRemindView.h"
#import "LDRLockManageController.h"
#import "LDRAccountSettingController.h"
#import "LDRMessageNotificationController.h"
#import "LDRFeedBackController.h"
#import "LDRSystemSettingController.h"
static CGFloat const headerHeight = 95;

static NSString * const LDRMineMessage = @"消息通知";
static NSString * const LDRMineLock = @"我的门锁";
static NSString * const LDRMineOrder = @"订单记录";
static NSString * const LDRMineSetting = @"账号设置";
static NSString * const LDRMineFeedBack = @"意见反馈";

@interface LDRMineHomeViewController ()
@property (nonatomic, strong) LDRMineHomeHeaderView *headerView;
@property (nonatomic, assign,getter=isLogin) BOOL login;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LDRMineHomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
    id state = [[NSUserDefaults standardUserDefaults] objectForKey:LDRLoginState];
    self.login = [state boolValue];
    if (self.isLogin) {
        self.headerView.name = @"大菠萝";
        self.headerView.phone = @"181****0028";
        self.headerView.authentication = YES;
    } else {
        self.headerView.login = self.isLogin;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addRightBarButtonItemWithImage:[UIImage imageNamed:@"mine_setting_icon"] action:@selector(rightButtonAction:)];
    
    [self headerView];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRMineHomeTableViewCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRMineHomeTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRMineNoTableViewCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRMineNoTableViewCell class])];
    
    [self.tableView setRowHeight:65];
    
    NSNumber *state = [[NSUserDefaults standardUserDefaults] objectForKey:LDRMineRemindState];
    if (![state boolValue]) {
        [self setUpRemindView];
    }
}
- (void)setUpRemindView
{
    LDRMineRemindView *view = [[LDRMineRemindView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 12, 0, 12));
        make.height.mas_equalTo(52);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-KBottomSafeHeight-KTabBarHeight-LDRPadding);
    }];
    [view setBackgroundColor:[UIColor colorWithHex:0x000000BF]];
    [view.layer setCornerRadius:8.0f];
}
#pragma mark - IBAction
- (void)rightButtonAction:(UIButton *)sender
{
    LDRSystemSettingController *vc = [[LDRSystemSettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didClickAuthentication
{
    
}
- (void)showOrderAlert
{
    LDRWeakify(self);
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
//            [weakSelf showBuleToothOpenDoor];
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
    MMItemMake(@"确定", MMItemTypeNormal, block)];
    LDRAlterView *alert = [[LDRAlterView alloc] initWithTitle:@"小程序打开确认" detail:@"即将跳往“360房东购小程序”，确定打开？" items:items];
    [alert show];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRMineHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRMineHomeTableViewCell class])];
    NSString *title = [[[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"key"];
    NSString *image = [[[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"image"];
    [cell.titleLabel setText:title];
    [cell.headerImageView setImage:[UIImage imageNamed:image]];
    if (indexPath.row == 0) {
        cell.numberBage =  99;
    } else {
        cell.numberBage = 0;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [[[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"key"];
    if ([title isEqualToString:LDRMineLock]) {
        LDRLockManageController *vc = [[LDRLockManageController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:LDRMineOrder]) {
        [self showOrderAlert];
    }
    if ([title isEqualToString:LDRMineSetting]) {
        LDRAccountSettingController *vc = [[LDRAccountSettingController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:LDRMineMessage]) {
        LDRMessageNotificationController *vc = [[LDRMessageNotificationController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:LDRMineFeedBack]) {
        LDRFeedBackController *vc = [[LDRFeedBackController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor colorWithHex:0xFEFCEEFF]];
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).mas_offset(LDRPadding);
            make.centerY.equalTo(view);
        }];
        [label setTextColor:[UIColor colorWithHex:0xFD942DFF]];
        [label setText:@"您还未进行实人认证，点我认证"];
        [label setFont:LDRFont12];
        
        UIImageView *iamgeView = [[UIImageView alloc] init];
        [view addSubview:iamgeView];
        [iamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view.mas_right).mas_offset(-LDRPadding);
            make.centerY.equalTo(view);
            make.width.height.mas_equalTo(LDRPadding);
        }];
        [iamgeView setImage:[UIImage imageNamed:@"orange_right"]];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickAuthentication)]];
        return view;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        UIView *line = [[UIView alloc] init];
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.centerY.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
        [line setBackgroundColor:[UIColor colorWithHex:0xF2F2F2FF]];
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return LDRButtonHeight;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
#pragma mark - Getter
- (LDRMineHomeHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LDRMineHomeHeaderView alloc] init];
        [self.view addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(headerHeight+KNavBarAndStatusBarHeight);
        }];
    }
    return _headerView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[
                       @[@{@"key":LDRMineMessage,
                           @"image":@"mine_message",},
                       @{@"key":LDRMineLock,
                         @"image":@"mine_lock",},
                       @{@"key":LDRMineOrder,
                         @"image":@"mine_order",}],
                       @[@{@"key":LDRMineSetting,
                           @"image":@"mine_setting",},
                       @{@"key":LDRMineFeedBack,
                         @"image":@"mine_feedback",},]
        ]];
    }
    return _dataSource;
}
@end
