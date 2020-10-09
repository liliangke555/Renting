//
//  LDRAuthenticationController.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAuthenticationController.h"
#import "LDRInputInfoCell.h"
#import "LDRToIDCardCell.h"
#import "LDRDistinguishController.h"
#import "LDRAddLockSuccessController.h"
#import "LDRIdCardVerificationRequest.h"

static NSString * const LDRTOIDCARD = @"LDRTOIDCARD";
static NSString * const LDRUSERNAME = @"LDRUSERNAME";
static NSString * const LDRIDNUMBER = @"LDRIDNUMBER";
static NSString * const LDRPHONENUMBER = @"LDRPHONENUMBER";

static NSString * const sectionHeader = @"个人信息-请保证内容填写的真实性";
static CGFloat sectionHeaderHeight = 64;
static CGFloat tableRowHeight = 72;
static CGFloat bottomHeight = 100;

@interface LDRAuthenticationController ()<LDRDistingguishDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *idCardString;
@end

@implementation LDRAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"实人认证";
    self.tableView.rowHeight = tableRowHeight;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRToIDCardCell class]) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass([LDRToIDCardCell class])];

    self.tableView.tableFooterView = self.bottomView;
}
#pragma mark - Networking
- (void)loadIdCardData
{
    if (self.idCardString.length <= 0) {
        [LDRHUD showHUDWithMessage:@"请输入身份证号"];
        return;
    }
    if (self.nameString.length <= 0) {
        [LDRHUD showHUDWithMessage:@"请输入姓名"];
        return;
    }
    LDRWeakify(self);
    LDRIdCardVerificationRequest *request = [LDRIdCardVerificationRequest new];
    request.idCard = self.idCardString;
    request.name = self.nameString;
    [LDRHUD showLoadingInView:self.view];
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        
        [LDRHUD hideHUDForView:weakSelf.view];
        LDRAddLockSuccessController *vc = [[LDRAddLockSuccessController alloc] init];
        vc.houseName = weakSelf.houseName;
        vc.macString = weakSelf.macString;
        vc.userHouseRelationId = weakSelf.userHouseRelationId;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } failHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
    }];
}
#pragma mark - IBAction
- (void)agreementButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.nextButton.enabled = sender.isSelected;
}
- (void)nextStepAction:(UIButton *)sender
{
    [self loadIdCardData];
}
#pragma mark - LDRDistingguishDelegate
- (void)distinguishResultWithName:(NSString *)name idCardNo:(NSString *)idCardNo
{
    self.nameString = name;
    self.idCardString = idCardNo;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *key = dic[@"key"];
    NSString *title = dic[@"title"];
    if (![key isEqualToString:LDRTOIDCARD]) {
        LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
        cell.title = title;
        if ([title isEqualToString:@"姓名"]) {
            cell.detail = self.nameString;
        } else {
            cell.detail = self.idCardString;
        }
        LDRWeakify(self);
        [cell setDidEndEidting:^(NSString * _Nonnull string) {
            if ([title isEqualToString:@"姓名"]) {
                weakSelf.nameString = string;
            } else {
                weakSelf.idCardString = string;
            }
            [weakSelf.tableView reloadData];
        }];
        return cell;
    }
    LDRToIDCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRToIDCardCell class])];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionHeader;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    header.backgroundView.backgroundColor = LDR_BackgroundColor;
    [header.textLabel setTextColor:LDR_TextGrayColor];
    [header.textLabel setFont:LDRFont12];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *key = dic[@"key"];
    if ([key isEqualToString:LDRTOIDCARD]) {
        LDRDistinguishController *vc = [[LDRDistinguishController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeaderHeight;
}
#pragma mark - Getter

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, 0, LDR_WIDTH, bottomHeight);
        [_bottomView setBackgroundColor:LDR_BackgroundColor];
        
        UIButton *agree = [UIButton buttonWithTarget:self action:@selector(agreementButtonAction:)];
        [_bottomView addSubview:agree];
        [agree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_bottomView).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, 0, 0));
        }];
        [agree setImage:[UIImage imageNamed:@"square_normal"] forState:UIControlStateNormal];
        [agree setImage:[UIImage imageNamed:@"square_selected"] forState:UIControlStateSelected];
        [agree setTitle:@"  点击勾选《360租房隐私政策》" forState:UIControlStateNormal];
        [agree setTitleColor:LDR_TextDarkGrayColor forState:UIControlStateNormal];
        [agree.titleLabel setFont:LDRFont12];
        
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(nextStepAction:)];
        [_bottomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(agree.mas_bottom).mas_offset(LDRPadding);
            make.left.equalTo(_bottomView.mas_left).mas_offset(LDRPadding);
            make.height.mas_equalTo(LDRButtonHeight);
            make.width.mas_equalTo(LDR_WIDTH - LDRPadding - LDRPadding);
        }];
        [button setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
        button.enabled = NO;
        [button setTitle:LDRButtonNextStep forState:UIControlStateNormal];
        self.nextButton = button;
    }
    return _bottomView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[
            @{
                @"key":LDRTOIDCARD
            },
            @{
                @"details":@"",
                @"title":@"姓名",
                @"key":LDRUSERNAME
            },
            @{
                @"details":@"",
                @"title":@"身份证号码",
                @"key":LDRIDNUMBER
            },
//            @{
//                @"details":@"",
//                @"title":@"联系电话",
//                @"key":LDRPHONENUMBER
//            },
        ]];
    }
    return _dataSource;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
@end
