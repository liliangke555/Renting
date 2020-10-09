//
//  LDRHouseContractController.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseContractController.h"
#import "LDRContractAddressTableCell.h"
#import "LDRContractLandlordTableViewCell.h"
#import "LDRContractSignupManTableViewCell.h"
#import "LDRInputInfoCell.h"
#import "LDRCreateHousePhotoTableCell.h"
#import "LDRSelectRentingController.h"

static NSString *const LDRAddress = @"地址信息";
static NSString *const LDRLandlord = @"房东信息";
static NSString *const LDRSignup = @"选择签约租客";
static NSString *const LDRPayment = @"支付方式";
static NSString *const LDRContract = @"合同凭证";

@interface LDRHouseContractController ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LDRHouseContractController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"租房合同";
    [self bottomView];
    [self.tableBakcView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRContractAddressTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRContractAddressTableCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRContractLandlordTableViewCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRContractLandlordTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRContractSignupManTableViewCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRContractSignupManTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRCreateHousePhotoTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRCreateHousePhotoTableCell class])];
}
#pragma mark _ IBAction
- (void)buttonAction
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.dataSource objectAtIndex:section] objectForKey:@"detail"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"key"];
    if ([title isEqualToString:LDRAddress]) {
        LDRContractAddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRContractAddressTableCell class])];
        return cell;
    }
    if ([title isEqualToString:LDRLandlord]) {
        LDRContractLandlordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRContractLandlordTableViewCell class])];
        return cell;
    }
    if ([title isEqualToString:LDRSignup]) {
        LDRContractSignupManTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRContractSignupManTableViewCell class])];
        cell.signupMan = YES;
        return cell;
    }
    if ([title isEqualToString:LDRPayment]) {
        NSString *detail = [[[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"detail"] objectAtIndex:indexPath.row];
        LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
        cell.title = detail;
        if ([detail isEqualToString:@"租期开始"] || [detail isEqualToString:@"租期结束"] ||[detail isEqualToString:@"付款方式"]) {
            cell.enable = NO;
        } else {
            cell.enable = YES;
        }
        return cell;
    }
    if ([title isEqualToString:LDRContract]) {
        LDRCreateHousePhotoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRCreateHousePhotoTableCell class])];
        cell.titleString = @"纸质合同";
        cell.detailString = @"上传房屋纸质合同,最多支持9张";
        LDRWeakify(self);
        [cell setDidReliadTableView:^{
            [weakSelf.tableView reloadData];
        }];
        return cell;;
    }
    return [UITableViewCell new];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] objectForKey:@"key"];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:LDR_tableTitleColor];
    [header.textLabel setFont:LDRFont12];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"key"];
    if ([title isEqualToString:LDRSignup]) {
        LDRSelectRentingController *vc = [[LDRSelectRentingController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark - Getter
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        [_bottomView setBackgroundColor:LDR_BackgroundColor];
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction)];
        [_bottomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(_bottomView).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding+KBottomSafeHeight, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [button setTitle:@"提交" forState:UIControlStateNormal];
    }
    return _bottomView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@{@"key":LDRAddress,@"detail":@[@""]},@{@"key":LDRLandlord,@"detail":@[@""]},@{@"key":LDRSignup,@"detail":@[@""]},@{@"key":LDRPayment,@"detail":@[@"租期开始",@"租期结束",@"租金",@"付款方式",@"押金"]},@{@"key":LDRContract,@"detail":@[@""]},];
    }
    return _dataSource;
}
@end
