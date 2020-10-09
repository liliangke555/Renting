//
//  LDRHomeViewController.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeViewController.h"
#import "LoginViewController.h"
#import "LDRHomeTableViewAgente.h"
#import "LDRHomeMessageTableViewCell.h"
#import "LDRHomeHouseManagerCell.h"
#import "LDRHomeEmptyDataCell.h"
#import "LDRHomeLoginHeaderView.h"
#import "LDRHomeHouseInfoCell.h"
#import "LDRHomeNavigationBar.h"
#import "LDRAddLockViewController.h"
#import "LDRMyBillController.h"
#import "LDRProfitBonusController.h"
#import "LDRMyHouseViewController.h"
#import "LDRMyREntingController.h"
#import "LDRGetAppCollectionIndexCountRequest.h"
#import "LDRCashnookIndexCountRequest.h"
#import "LDRMessageNotificationController.h"
#import "LDRHomePageMessageNotifyRequest.h"

@interface LDRHomeViewController ()<
LDRHomeNavigationDelegate,
UIScrollViewDelegate,
SDCycleScrollViewDelegate,
LDRHomeTableDelegate,
LDRHomeHeaderDelegate>

@property (nonatomic, strong) LDRHomeLoginHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LDRHomeTableViewAgente *agente;
@property (nonatomic, strong) UIView *emptyHeaderView;
@property (nonatomic, assign,getter=isLogin) BOOL login;
@property (nonatomic, strong) LDRHomeNavigationBar *navBar;

@end

@implementation LDRHomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    id state = [[NSUserDefaults standardUserDefaults] objectForKey:LDRLoginState];
    self.login = state;
    self.agente.login = state;
    self.navBar.login = state;
    if (self.isLogin) {
        [self.tableView setTableHeaderView:self.headerView];
    } else {
        [self.tableView setTableHeaderView:self.emptyHeaderView];
    }
    [self.tableView reloadData];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:LDR_BackgroundColor];
    [self.navigationController.navigationBar setTranslucent:true];
//    [self.tableView reloadData];
    id state = [[NSUserDefaults standardUserDefaults] objectForKey:LDRLoginState];
    if (state) {
        [self reloadCollectionIndexCount];
        [self reloadCashbookIndexCount];
        [self reloadMessageData];
    }
}
#pragma mark - Networking
- (void)reloadCollectionIndexCount
{
    LDRWeakify(self);
    LDRGetAppCollectionIndexCountRequest *request = [LDRGetAppCollectionIndexCountRequest new];
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        weakSelf.headerView.model = response.data;
    } failHandler:^(BaseResponse *response) {
    }];
}
- (void)reloadCashbookIndexCount
{
    LDRWeakify(self);
    LDRCashnookIndexCountRequest *request = [LDRCashnookIndexCountRequest new];
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        LDRCashbookIndexCountModel *model = response.data;
        weakSelf.agente.model = response.data;
        weakSelf.headerView.moneyCount = [model.moneyCount floatValue];
    } failHandler:^(BaseResponse *response) {
        
    }];
}
- (void)reloadMessageData
{
    LDRWeakify(self);
    LDRHomePageMessageNotifyRequest *request = [LDRHomePageMessageNotifyRequest new];
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        weakSelf.agente.messageArray = response.data;
        [weakSelf.tableView reloadData];
    } failHandler:^(BaseResponse *response) {
        
    }];
}
#pragma mark - LDRHomeHeaderDelegate
- (void)didClickMyBill
{
    LDRMyBillController *vc = [[LDRMyBillController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didClickProfit
{
    LDRProfitBonusController *vc = [[LDRProfitBonusController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toNoticeView
{
    LDRMessageNotificationController *vc = [[LDRMessageNotificationController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - LDRHomeTableDelegate

- (void)didClickHouse
{
    LDRMyHouseViewController *vc = [[LDRMyHouseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didClickTenant
{
    LDRMyREntingController *vc = [[LDRMyREntingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LDRHomeNavigationDelegate
- (void)leftButtonDidClick
{
    if (!self.isLogin) {
        [[LDRRootConfig sharedRootConfig] toLogin];
        return;
    }
}
- (void)rightButtonDidClick
{
    LDRAddLockViewController *vc = [[LDRAddLockViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self.agente;
        _tableView.dataSource = self.agente;
        _tableView.tableFooterView = [UIView new];
  
        
        [_tableView setBackgroundColor:LDR_BackgroundColor];
        [_tableView setSeparatorColor:LDR_BackgroundColor];
        [_tableView registerClass:[LDRHomeMessageTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([LDRHomeMessageTableViewCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHomeHouseManagerCell class])
                                               bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHomeHouseManagerCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHomeEmptyDataCell class])
                                               bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHomeEmptyDataCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHomeHouseInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHomeHouseInfoCell class])];
    }
    return _tableView;
}
- (LDRHomeTableViewAgente *)agente
{
    if (!_agente) {
        _agente = [[LDRHomeTableViewAgente alloc] init];
        _agente.login = self.isLogin;
        _agente.form = self;
        _agente.navForm = self.navBar;
    }
    return _agente;
}
- (LDRHomeLoginHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LDRHomeLoginHeaderView class])
                                                     owner:nil
                                                   options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, LDR_WIDTH, LDRHomeHeaderHeight);
        _headerView.delegate = self;
    }
    return _headerView;
}
- (UIView *)emptyHeaderView
{
    if (!_emptyHeaderView) {
        _emptyHeaderView = [[UIView alloc] init];
        _emptyHeaderView.frame = CGRectMake(0, 0, LDR_WIDTH, 0.1);
    }
    return _emptyHeaderView;
}

- (LDRHomeNavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [[LDRHomeNavigationBar alloc] initWithLogin:YES];
        [self.view addSubview:_navBar];
        _navBar.delegate = self;
    }
    return _navBar;
}

#pragma mark - Layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat height = CGRectGetHeight(self.view.frame) - 49;
    CGFloat navBarHeight = 44 + KStatusHeight;
    self.navBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), navBarHeight);
    self.tableView.frame = CGRectMake(0, navBarHeight, CGRectGetWidth(self.view.frame), height - KBottomSafeHeight);
    if (self.isLogin) {
//        self.headerView.frame = CGRectMake(0, 0, LDR_WIDTH, 260);
    }
}

@end
