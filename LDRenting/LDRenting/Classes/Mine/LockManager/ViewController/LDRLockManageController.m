//
//  LDRLockManageController.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockManageController.h"
#import "LDRRemindView.h"
#import "LDRLockManageHeader.h"
#import "LDRAddLockViewController.h"
#import "LDRLockManageTableCell.h"
#import "LDRMineLockSettingController.h"
static CGFloat const headerHeight = 146.0f;
@interface LDRLockManageController ()
@property (nonatomic, strong) LDRLockManageHeader *headerView;
@end

@implementation LDRLockManageController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    self.whiteBack= YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRightBarButtonItemWithImage:[UIImage imageNamed:@"home_add_clock"] action:@selector(addLockAction)];
    [self headerView];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(-LDRControllerRadius*2);
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    NSNumber *state = [[NSUserDefaults standardUserDefaults] objectForKey:LDRAddHouseRemindState];
    if (![state boolValue]) {
        [self setupRemindView];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRLockManageTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRLockManageTableCell class])];
}
- (void)setupRemindView
{
    LDRRemindView* remindView = [[LDRRemindView alloc] initWithTitle:@"点击这里添加门锁" setImage:^(UIImageView * _Nonnull imageView) {
        [imageView setImage:[UIImage imageNamed:@"remind_top_background"]];
    } close:^{
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:LDRAddHouseRemindState];
    }];
    [self.view insertSubview:remindView aboveSubview:self.headerView];
    [remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).mas_offset(KNavBarAndStatusBarHeight);
        make.right.equalTo(self.view.mas_right).mas_offset(-LDRPadding-3);
    }];
}
#pragma mark - IBAction
- (void)addLockAction
{
    LDRAddLockViewController *vc = [[LDRAddLockViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRLockManageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRLockManageTableCell class])];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRMineLockSettingController *vc = [[LDRMineLockSettingController alloc] init];
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
    NSString *text = @"立即去添加智能门锁吧";
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
- (LDRLockManageHeader *)headerView
{
    if (!_headerView) {
        _headerView = [[LDRLockManageHeader alloc] initWithTitle:@"门锁管理" details:@"" image:^(UIImageView * _Nonnull imageView) {
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
#pragma mark - Layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableBakcView clipCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:LDRControllerRadius];
    [self.tableBakcView setClipsToBounds:YES];
}
@end
