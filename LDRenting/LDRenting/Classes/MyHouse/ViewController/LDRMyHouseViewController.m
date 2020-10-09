//
//  LDRMyHudeViewController.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyHouseViewController.h"
#import "LDRMyHouseHeaderView.h"
#import "LDRMyHouseCell.h"
#import "LDRAddLockViewController.h"
#import "LDRAddTenantsController.h"
#import "LDRRemindView.h"
#import "LDRHouseInfoationViewController.h"
static CGFloat const headerHeight = 146.0f;
@interface LDRMyHouseViewController ()

@property (nonatomic, strong) LDRMyHouseHeaderView *headerView;
@property (nonatomic, strong) LDRRemindView *remindView;
@end

@implementation LDRMyHouseViewController
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
    
    [self addRightBarButtonItemWithImage:[UIImage imageNamed:@"home_add_clock"] action:@selector(addLockAction:)];
    [self headerView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRMyHouseCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRMyHouseCell class])];
    
    NSNumber *state = [[NSUserDefaults standardUserDefaults] objectForKey:LDRAddHouseRemindState];
    if (![state boolValue]) {
        [self remindView];
    }
    
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(-LDRControllerRadius*2);
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
#pragma mark - IBAction
- (void)addLockAction:(UIButton *)sender
{
    LDRAddLockViewController *vc = [[LDRAddLockViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addHouseAction
{
    LDRAddTenantsController *vc = [[LDRAddTenantsController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addBookingAction
{
    
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRMyHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRMyHouseCell class])];
    LDRWeakify(self);
    [cell setDidClickAddHouse:^{
        [weakSelf addHouseAction];
    }];
    [cell setDidClickAddBooking:^{
        [weakSelf addBookingAction];
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRHouseInfoationViewController *vc = [[LDRHouseInfoationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_house_big"];
}
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"您还没有智能门锁";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRBoldFont18,
        NSForegroundColorAttributeName:LDR_TextBalckColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
// MARK: 空白页显示详细描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"请先添加智能门锁，通过门锁绑定房屋，这\n样就可以使用房屋的管理功能，开启你的智\n能租房在线管理";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont12,
        NSForegroundColorAttributeName:LDR_TextGrayColor,
        NSParagraphStyleAttributeName:paragraph
    };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - Getter
- (LDRMyHouseHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LDRMyHouseHeaderView alloc] initWithTitle:@"我的房屋" details:@"" image:^(UIImageView * _Nonnull imageView) {
            [imageView setImage:[UIImage imageNamed:@"myhouse_header_icon"]];
        }];
        [self.view insertSubview:_headerView atIndex:0];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(headerHeight+KStatusHeight);
        }];
    }
    return _headerView;
}
- (LDRRemindView *)remindView
{
    if (!_remindView) {
        _remindView = [[LDRRemindView alloc] initWithTitle:@"点击这里添加门锁" setImage:^(UIImageView * _Nonnull imageView) {
            [imageView setImage:[UIImage imageNamed:@"remind_top_background"]];
        } close:^{
            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:LDRAddHouseRemindState];
        }];
        [self.view insertSubview:_remindView aboveSubview:self.headerView];
        [_remindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).mas_offset(KNavBarAndStatusBarHeight);
            make.right.equalTo(self.view.mas_right).mas_offset(-LDRPadding-3);
        }];
    }
    return _remindView;
}
#pragma mark - Layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableBakcView clipCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:LDRControllerRadius];
    [self.tableBakcView setClipsToBounds:YES];
}

@end
