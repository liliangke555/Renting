//
//  LDRHouseSettingViewController.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseSettingViewController.h"
#import "LDRCreateHouseInfoController.h"
#import "LDRDeleteHouseViewController.h"
@interface LDRHouseSettingViewController ()

@end

@implementation LDRHouseSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"房屋设置";
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
}
#pragma mark -
- (void)deleteHouse
{
//    LDRAlterView *alert = [[LDRAlterView alloc] initWithConfirmTitle:@"删除失败" detail:@"该房屋正在出租中，无法删除"];
//    [alert show];
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            
        } else {
            LDRDeleteHouseViewController *vc = [[LDRDeleteHouseViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
                      MMItemMake(@"确定", MMItemTypeNormal, block)];
    LDRAlterView *alert = [[LDRAlterView alloc] initWithTitle:@"删除确认" detail:@"如果删除该房屋，那么该房屋关联的\n数据均会被删除，确定要删除吗" isWarning:YES items:items];
    [alert show];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.textLabel setFont:LDRFont16];
        [cell.textLabel setTextColor:LDR_TextBalckColor];
    }
    if (indexPath.row == 0) {
        [cell.textLabel setText:@"编辑房屋"];
    } else {
        [cell.textLabel setText:@"删除房屋"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        LDRCreateHouseInfoController *vc = [[LDRCreateHouseInfoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self deleteHouse];
    }
}

@end
