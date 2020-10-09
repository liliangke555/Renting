//
//  LDRMyREntingController.m
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyREntingController.h"
#import "LDRMyReningHeaderView.h"
#import "LDRRemindView.h"
#import "LDRHomeHouseInfoCell.h"
#import "LDRAddTenantsController.h"
#import "LDRRenantsInfomationController.h"
static CGFloat headerHeight = 198.0f;
@interface LDRMyREntingController ()<LDRMyRentingHeaderDelegate>
@property (nonatomic, strong) LDRMyReningHeaderView *headerView;
@property (nonatomic, strong) LDRRemindView *remindView;
@end

@implementation LDRMyREntingController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    self.whiteBack = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addRightBarButtonItemWithImage:[UIImage imageNamed:@"home_add_clock"] action:@selector(addRentingAction:)];
    [self headerView];
    NSNumber *state = [[NSUserDefaults standardUserDefaults] objectForKey:LDRAddRentingRemindState];
    if (![state boolValue]) {
        [self remindView];
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHomeHouseInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHomeHouseInfoCell class])];
    
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(-LDRControllerRadius*2);
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
#pragma mark - IBAction
- (void)addRentingAction:(UIButton *)sender
{
    LDRAddTenantsController *vc = [[LDRAddTenantsController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - LDRMyRentingHeaderDelegate
- (void)didToSearchText:(NSString *)text
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRHomeHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHomeHouseInfoCell class])];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRRenantsInfomationController *vc = [[LDRRenantsInfomationController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无租客信息";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
// MARK: 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_renants"];
}
#pragma mark - Getter

- (LDRMyReningHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LDRMyReningHeaderView alloc] initWithTitle:@"我的租客"];
        [self.view insertSubview:_headerView atIndex:0];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(headerHeight + KStatusHeight);
        }];
        _headerView.delegate = self;
    }
    return _headerView;
}
- (LDRRemindView *)remindView
{
    if (!_remindView) {
        _remindView = [[LDRRemindView alloc] initWithTitle:@"点击这里添加租客" setImage:^(UIImageView * _Nonnull imageView) {
            [imageView setImage:[UIImage imageNamed:@"remind_top_background"]];
        } close:^{
            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:LDRAddRentingRemindState];
        }];
        [self.view addSubview:_remindView];
        [_remindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).mas_offset(KNavBarAndStatusBarHeight);
            make.right.equalTo(self.view.mas_right).mas_offset(-LDRPadding-3);
        }];
    }
    return _remindView;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableBakcView clipCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:LDRControllerRadius];
    [self.tableBakcView setClipsToBounds:YES];
}
@end
