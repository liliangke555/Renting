//
//  LDRFeedBackController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRFeedBackController.h"
#import "LDRFeedBackTypeTableCell.h"
#import "LDRFeedBackTextTableCell.h"
static NSString * const LDRFeedBackType = @"选择反馈类型";
static NSString * const LDRFeedBackDetail = @"填写反馈内容";
@interface LDRFeedBackController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIButton *button;
@end

@implementation LDRFeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"意见反馈";
    self.dataSource = @[LDRFeedBackType,LDRFeedBackDetail];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.button.mas_top).mas_equalTo(-LDRPadding);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRFeedBackTypeTableCell class]) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass([LDRFeedBackTypeTableCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRFeedBackTextTableCell class]) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass([LDRFeedBackTextTableCell class])];
}
- (void)buttonAction:(UIButton *)sender
{
    [LDRHUD showSuccessfulWithMessage:@"提交成功" view:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.dataSource objectAtIndex:indexPath.section];
    if ([title isEqualToString:LDRFeedBackType]) {
        LDRFeedBackTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRFeedBackTypeTableCell class])];
        if (indexPath.row == 0) {
            cell.titleString = @"门锁问题";
            cell.typeString = @"门锁功能异常";
        } else {
            cell.titleString = @"其他功能问题";
            cell.typeString = @"其他功能建议";
        }
        return cell;
    }
    LDRFeedBackTextTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRFeedBackTextTableCell class])];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
#pragma mark - Getter
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction:)];
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, LDRPadding, LDRPadding+KBottomSafeHeight, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [_button setTitle:@"提交" forState:UIControlStateNormal];
    }
    return _button;
}
@end
