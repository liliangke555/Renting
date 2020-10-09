//
//  LDRCreateHouseInfoController.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCreateHouseInfoController.h"
#import "LDRInputInfoCell.h"
#import "LDRCreateHousePhotoTableCell.h"
#import "LDRHouseConfigTableCell.h"
#import "LDRMapViewController.h"
@interface LDRCreateHouseInfoController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIView *buttonView;
@end

@implementation LDRCreateHouseInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"房屋信息";
//    self.tableView.rowHeight = 64;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRCreateHousePhotoTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRCreateHousePhotoTableCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHouseConfigTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHouseConfigTableCell class])];
}
#pragma mark - IBAction
- (void)loactionAction:(UIButton *)sender
{
    LDRMapViewController *vc = [[LDRMapViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)bottomButtonAction:(UIButton *)sender
{
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section][@"detail"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [[self.dataSource objectAtIndex:indexPath.section][@"detail"] objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"房屋照片"]) {
        LDRCreateHousePhotoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRCreateHousePhotoTableCell class])];
        LDRWeakify(self);
        [cell setDidReliadTableView:^{
            [weakSelf.tableView reloadData];
        }];
        return cell;
    }
    if ([title isEqualToString:@"房屋配置"]) {
        LDRHouseConfigTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHouseConfigTableCell class])];
        [cell.titleLabel setText:title];
        return cell;
    }
    
    LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    cell.title = title;
    if ([title isEqualToString:@"户型"] || [title isEqualToString:@"朝向"] || [title isEqualToString:@"支付方式"]) {
        cell.enable = NO;
        cell.placehold = @"请选择";
    } else {
        cell.enable = YES;
        cell.placehold = @"请输入";
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [self.dataSource objectAtIndex:section][@"key"];
    return title;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (section != 0) {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:LDR_tableTitleColor];
        [header.textLabel setFont:LDRFont12];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        NSString *title = [self.dataSource objectAtIndex:section][@"key"];
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).mas_offset(LDRPadding);
            make.left.equalTo(view.mas_left).mas_offset(LDRPadding);
        }];
        [label setText:title];
        [label setTextColor:LDR_tableTitleColor];
        [label setFont:LDRFont12];
        
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(loactionAction:)];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).mas_offset(24);
            make.left.right.equalTo(view).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(32);
            make.bottom.equalTo(view.mas_bottom).mas_offset(-LDRPadding);
        }];
        [button setTitle:@"帮我定位" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"hlep_loaction_icon"] forState:UIControlStateNormal];
        return view;
    }
    return nil;
}
#pragma mark - Getter
- (UIView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[UIView alloc] init];
        [self.view addSubview:_buttonView];
        [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(bottomButtonAction:)];
        [_buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_buttonView.mas_top).mas_offset(LDRPadding);
            make.left.right.equalTo(_buttonView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
            make.bottom.equalTo(_buttonView.mas_bottom).mas_offset(-LDRPadding - KBottomSafeHeight);
        }];
        [button setTitle:@"提交" forState:UIControlStateNormal];
    }
    return _buttonView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@{@"key":@"地址信息",
                          @"detail":@[@"帮我定位",@"行政区",@"所在小区",@"详细地址",@"所在楼层",@"总楼层",],},
                        @{@"key":@"房屋信息",
                          @"detail":@[@"房屋名称",@"户型",@"朝向",@"面积",@"租金",@"支付方式",@"房屋照片",@"房屋配置"],}
        ];
    }
    return _dataSource;
}
- (void)viewDidLayoutSubviews
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.buttonView.mas_top);
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
@end
