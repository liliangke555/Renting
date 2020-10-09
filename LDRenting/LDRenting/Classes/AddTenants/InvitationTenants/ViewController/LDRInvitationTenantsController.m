//
//  LDRInvitationTenantsController.m
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRInvitationTenantsController.h"
#import "LDRInputInfoCell.h"
#import "LDRInvitationWechatCell.h"
#import "LDRBottomPoliceView.h"
#import "LDRSelectHouseController.h"
#import "LDRToWechatInvitationController.h"
#import "LDRToMessageInvitationController.h"
static CGFloat const bottomHeight = 153.0f;
static NSString * const LDRTenantsInfo = @"租客信息";
static NSString * const LDRSelectedType = @"请选择分享至租客的方式";
static NSString * const LDRAddToHouse = @"选择租客添加到房屋";
@interface LDRInvitationTenantsController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) LDRBottomPoliceView *bottomView;
@end

@implementation LDRInvitationTenantsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"邀请租客";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInvitationWechatCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInvitationWechatCell class])];
    [self bottomView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.dataSource objectAtIndex:section][@"detail"];
    return [array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.section];
    NSString *key = dic[@"key"];
    if ([key isEqualToString:LDRTenantsInfo]) {
        LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
        cell.title = [dic[@"detail"] objectAtIndex:indexPath.row][@"title"];
        return cell;
    }
    if ([key isEqualToString:LDRSelectedType]) {
        LDRInvitationWechatCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInvitationWechatCell class])];
        return cell;
    }
    if ([key isEqualToString:LDRAddToHouse]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell.textLabel setTextColor:LDR_TextBalckColor];
            [cell.textLabel setFont:LDRFont16];
            [cell.detailTextLabel setTextColor:LDR_TextGrayColor];
            [cell.detailTextLabel setFont:LDRFont16];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.textLabel.text = [dic[@"detail"] objectAtIndex:indexPath.row][@"title"];
        cell.detailTextLabel.text = @"请选择";
        return cell;
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.dataSource objectAtIndex:indexPath.section][@"key"];
    if ([key isEqualToString:LDRAddToHouse]) {
        LDRSelectHouseController *vc = [[LDRSelectHouseController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.dataSource objectAtIndex:section][@"key"];
    return key;
}
#pragma mark - Getter
- (LDRBottomPoliceView *)bottomView
{
    if (!_bottomView) {
        LDRWeakify(self);
        _bottomView = [[LDRBottomPoliceView alloc] initWithButtonTitle:LDRButtonNextStep action:^{
            LDRToWechatInvitationController *vc = [[LDRToWechatInvitationController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
//            LDRToMessageInvitationController *vc = [[LDRToMessageInvitationController alloc] init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(bottomHeight+KBottomSafeHeight);
        }];
        _bottomView.enable = YES;
    }
    return _bottomView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
            @{
                @"key":LDRTenantsInfo,
                @"detail":@[@{@"title":@"姓名"},@{@"title":@"联系电话"}],
            },
            @{
                @"key":LDRSelectedType,
                @"detail":@[@{@"titleOne":@"微信邀请",
                            @"detailOne":@"分享小程序给微信好友",
                            @"title":@"短信邀请",
                            @"title":@"发送短信连接至租客"}],
            },
            @{
                @"key":LDRAddToHouse,
                @"detail":@[@{@"title":@"房屋选择"}],
            }
        ];
    }
    return _dataSource;
}

- (void)viewDidLayoutSubviews
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, bottomHeight+KBottomSafeHeight, 0));
    }];
}
@end
