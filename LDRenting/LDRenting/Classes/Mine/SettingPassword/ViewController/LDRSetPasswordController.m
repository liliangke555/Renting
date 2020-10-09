//
//  LDRSetPasswordController.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSetPasswordController.h"
#import "LDRSetPasswordHeaderView.h"
#import "LDRInputInfoCell.h"
#import "LDRSetPassTypeTableCell.h"
#import "ZJDatePickerView.h"
#import "LDRLockPassWordManageController.h"

typedef NS_ENUM(NSUInteger, LDRPassType) {
    LDRPassTypeOnce,
    LDRPassTypeManyTimes,
    LDRPassTypeTimeLimit,
};

static CGFloat headerHeight = 90;

static NSString *const LDRSETPASSType = @"请选择远程密码类型";
static NSString *const LDRSETPASSName = @"设置使用人姓名";
static NSString *const LDRSETPASSManyTimes = @"设置多次远程密码";
static NSString *const LDRSETPASSTimeLimit = @"设置限时远程密码";
@interface LDRSetPasswordController ()
@property (nonatomic, strong) LDRSetPasswordHeaderView *headerView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) LDRPassType passType;
@property (nonatomic, copy) NSString *starTime;
@property (nonatomic, copy) NSString *endTime;
@end

@implementation LDRSetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self headerView];
    [self button];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.button.mas_top).mas_offset(LDRPadding);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRSetPassTypeTableCell class]) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass([LDRSetPassTypeTableCell class])];
}
- (void)showTimeSelectorWithStart:(BOOL)isStart
{
    LDRWeakify(self);
    [ZJDatePickerView zj_showDatePickerWithTitle:nil dateType:ZJDatePickerModeYMDHM defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        if (isStart) {
            weakSelf.starTime = selectValue;
        } else {
            weakSelf.endTime = selectValue;
        }
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }];
}
#pragma mark - IBAction
- (void)buttonAction:(UIButton *)sender
{
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
    MMItemMake(@"复制文本", MMItemTypeNormal, block)];
    if (self.passType == LDRPassTypeOnce) {
        LDRAlterView *alertView = [[LDRAlterView alloc] initWithInputTitle:@"一次性密码设置成功" detail:@"1.首次添加请在门锁上先输入\n 00# ，  等待门锁告知添加成功\n2.输入密码即可完成开门  " items:items placeholder:@"密码只能使用一次" handler:^(NSString * _Nonnull text) {
            
        }];
        [alertView show];
    } else if (self.passType == LDRPassTypeManyTimes) {
        LDRAlterView *alertView = [[LDRAlterView alloc] initWithInputTitle:@"多次密码设置成功" detail:@"1.首次添加请在门锁上先输入\n 00# ，  等待门锁告知添加成功\n2.输入密码即可完成开门  " items:items placeholder:@"密码只能使用N次" handler:^(NSString * _Nonnull text) {
            
        }];
        [alertView show];
    } else {
        LDRAlterView *alertView = [[LDRAlterView alloc] initWithInputTitle:@"限时密码设置成功" detail:@"1.首次添加请在门锁上先输入\n 00# ，  等待门锁告知添加成功\n2.输入密码即可完成开门  " items:items placeholder:[NSString stringWithFormat:@"密码只能在%@至%@时间段内使用",self.starTime,self.endTime] handler:^(NSString * _Nonnull text) {
            
        }];
        alertView.inputView.text = @"124555";
        [alertView show];
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *title = [self.dataSource objectAtIndex:section];
    if ([title isEqualToString:LDRSETPASSManyTimes] || [title isEqualToString:LDRSETPASSTimeLimit]) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.dataSource objectAtIndex:indexPath.section];
    if ([title isEqualToString:LDRSETPASSName]) {
        LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
        cell.title = @"姓名";
        return cell;
    }
    if ([title isEqualToString:LDRSETPASSType]) {
        LDRSetPassTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRSetPassTypeTableCell class])];
        LDRWeakify(self);
        [cell setDidChangeType:^(NSInteger passType) {
            weakSelf.passType = passType;
        }];
        return cell;
    }
    if ([title isEqualToString:LDRSETPASSManyTimes]) {
        if (indexPath.row == 0) {
            LDRSetPassTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRSetPassTypeTableCell class])];
            LDRWeakify(self);
            cell.setPassNum = YES;
            [cell setDidChangeType:^(NSInteger index) {
//                weakSelf.passType = passType;
            }];
            
            return cell;
        } else {
            LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
            cell.title = @"次数";
            cell.rightString = @"次";
            return cell;
        }
    }
    if ([title isEqualToString:LDRSETPASSTimeLimit]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            [cell.textLabel setFont:LDRFont16];
            [cell.textLabel setTextColor:LDR_TextBalckColor];
            [cell.detailTextLabel setFont:LDRFont16];
            [cell.detailTextLabel setTextColor:LDR_TextBalckColor];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"开始时间"];
            [cell.detailTextLabel setText:self.starTime];
        } else {
            [cell.textLabel setText:@"结束时间"];
            [cell.detailTextLabel setText:self.endTime];
        }
        return cell;
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.dataSource objectAtIndex:indexPath.section];
    if ([title isEqualToString:LDRSETPASSTimeLimit]) {
        [self showTimeSelectorWithStart:indexPath.row == 0];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [self.dataSource objectAtIndex:section];
    
    return title;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:LDR_tableTitleColor];
    [header.textLabel setFont:LDRFont12];
}
#pragma mark - Setter
- (void)setPassType:(LDRPassType)passType
{
    _passType = passType;
    if (passType == LDRPassTypeOnce) {
        [self.dataSource removeObject:LDRSETPASSTimeLimit];
        [self.dataSource removeObject:LDRSETPASSManyTimes];
    } else if (passType == LDRPassTypeManyTimes) {
        [self.dataSource removeObject:LDRSETPASSTimeLimit];
        [self.dataSource insertObject:LDRSETPASSManyTimes atIndex:1];
    } else {
        [self.dataSource removeObject:LDRSETPASSManyTimes];
        [self.dataSource insertObject:LDRSETPASSTimeLimit atIndex:1];
    }
    [self.tableView reloadData];
}
#pragma mark - Getter
- (LDRSetPasswordHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LDRSetPasswordHeaderView class]) owner:nil options:nil] lastObject];
        [self.view addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(headerHeight);
        }];
        LDRWeakify(self);
        [_headerView setDidClickButton:^{
            LDRLockPassWordManageController *vc = [[LDRLockPassWordManageController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headerView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:LDRSETPASSType];
        [_dataSource addObject:LDRSETPASSName];
    }
    return _dataSource;
}
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction:)];
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, LDRPadding, LDRPadding+KBottomSafeHeight, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [_button setTitle:@"确认" forState:UIControlStateNormal];
    }
    return _button;
}
@end
