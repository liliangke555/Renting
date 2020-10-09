//
//  LDRAccountSettingController.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAccountSettingController.h"
#import "LDRCancelAccuntController.h"
#import "LDRChangePhoneController.h"

static NSString *const LDRWechat = @"微信号";
static NSString *const LDRPhone = @"修改手机号";
static NSString *const LDRCancel = @"注销账号";
@interface LDRAccountSettingController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LDRAccountSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账号设置";
    self.dataSource = @[LDRWechat,LDRPhone,LDRCancel];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [self.tableView setRowHeight:56];
}
- (void)showAlert
{
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
    MMItemMake(@"确定", MMItemTypeNormal, block)];
    LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"提示" detail:@"解绑会影响微信登录360租房，确定解绑微信账号吗？" isWarning:YES items:items];
    [alertView show];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell.textLabel setFont:LDRFont16];
        [cell. textLabel setTextColor:LDR_TextBalckColor];
        [cell.detailTextLabel setFont:LDRFont16];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    [cell.textLabel setText:title];
    if ([title isEqualToString:LDRCancel]) {
        [cell.detailTextLabel setText:@"注销后无法恢复，请谨慎操作"];
    }
    if ([title isEqualToString:LDRWechat]) {
        [cell.detailTextLabel setTextColor:LDR_MainGreenColor];
        [cell.detailTextLabel setText:@"已绑定"];
    } else {
        [cell.detailTextLabel setTextColor:LDR_TextGrayColor];
    }
    if ([title isEqualToString:LDRPhone]) {
        [cell.detailTextLabel setText:@"127****2163"];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    if ([title isEqualToString:LDRCancel]) {
        LDRCancelAccuntController *vc = [[LDRCancelAccuntController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:LDRWechat]) {
        [self showAlert];
    }
    if ([title isEqualToString:LDRPhone]) {
        LDRChangePhoneController *vc = [[LDRChangePhoneController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
