//
//  LDRLockOtherSettingController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockOtherSettingController.h"
#import "LDRSetVolumeTableCell.h"
@interface LDRLockOtherSettingController ()

@end

@implementation LDRLockOtherSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"其他设置";
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    [self.tableView setRowHeight:56];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRSetVolumeTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRSetVolumeTableCell class])];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell.textLabel setTextColor:LDR_TextBalckColor];
        [cell.textLabel setFont:LDRFont16];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"设备名称"];
            [cell.detailTextLabel setText:@"SAMRTLOCK-09Q9"];
            [cell.detailTextLabel setFont:LDRFont16];
            [cell.detailTextLabel setTextColor:LDR_TextBalckColor];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        } else {
            [cell.textLabel setText:@"更多信息"];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"音量设置"];
        } else {
            LDRSetVolumeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass( [LDRSetVolumeTableCell class])];
            return cell;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"门锁启用禁用"];

        } else {
            [cell.textLabel setText:@"同步门锁时间"];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"设备版本"];
            [cell.detailTextLabel setText:@"检查版本"];
            [cell.detailTextLabel setFont:LDRFont16];
            [cell.detailTextLabel setTextColor:LDR_TextGrayColor];
        } else {
            [cell.textLabel setText:@"恢复出厂设置"];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            return 100;
        }
    }
    return 56;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        UIView *view = [[UIView alloc] init];
        UIView *line = [[UIView alloc] init];
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.right.equalTo(view).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(0.5f);
        }];
        [line setBackgroundColor:LDR_TextLightGrayColor];
        return view;
    }
    return nil;
}
@end
