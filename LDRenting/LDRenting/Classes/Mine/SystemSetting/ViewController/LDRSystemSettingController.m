//
//  LDRSystemSettingController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSystemSettingController.h"
#import "LDRSheetView.h"
#import "LDRFollowWeController.h"
static NSString * const LDRAboutWe = @"联系我们";
static NSString * const LDRFollowWe = @"关注我们";
static NSString * const LDRToEvaluate = @"去评价";
static NSString * const LDRLoginOut = @"退出登录";
@interface LDRSystemSettingController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LDRSystemSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[LDRAboutWe,LDRFollowWe,LDRToEvaluate,LDRLoginOut];
    self.navigationItem.title = @"设置";
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    [self.tableView setRowHeight:56];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.textLabel setTextColor:LDR_TextBalckColor];
        [cell.textLabel setFont:LDRFont16];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    [cell.textLabel setText:title];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    if ([title isEqualToString:LDRLoginOut]) {
        [self showLoginOutAlert];
    }
    if ([title isEqualToString:LDRAboutWe]) {
        [self alboutWe];
    }
    if ([title isEqualToString:LDRFollowWe]) {
        LDRFollowWeController *vc = [[LDRFollowWeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)showLoginOutAlert
{
    MMPopupItemHandler block = ^(NSInteger index){
                NSLog(@"clickd %@ button",@(index));
            if (index == 0) {
    //            [weakSelf showBuleToothOpenDoor];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LDRLoginState];
            }
        };
        NSArray *items =@[MMItemMake(@"退出登录", MMItemTypeNormal, block)];
    LDRSheetView *sheet = [[LDRSheetView alloc] initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号" items:items];
    [sheet show];
}
- (void)alboutWe
{MMPopupItemHandler block = ^(NSInteger index){
                NSLog(@"clickd %@ button",@(index));
            if (index == 0) {
    //            [weakSelf showBuleToothOpenDoor];
            } else {
                NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"40000001232"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            }
        };
        NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
        MMItemMake(@"拨打", MMItemTypeNormal, block)];
    LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"联系客服" detail:@"是否拨打400-0000-1232" items:items];
    [alertView show];
}
@end
