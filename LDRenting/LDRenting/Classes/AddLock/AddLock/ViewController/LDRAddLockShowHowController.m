//
//  LDRAddLockShowHowController.m
//  LDRenting
//
//  Created by MAC on 2020/7/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddLockShowHowController.h"
#import "LDRAddLockShowCell.h"
#import "LDRScanQRcodeController.h"
#import "LDRBluetoothController.h"

@interface LDRAddLockShowHowController ()<UITableViewDelegate,UITableViewDataSource,LDRScanQRDelegate>

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LDRAddLockShowHowController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = LDRAddLockViewTitle;
    [self.view setBackgroundColor:LDR_BackgroundColor];
    [self bottomView];
    [self tableView];
}

#pragma mark - IBAction

- (void)agreementButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.addButton.enabled = sender.isSelected;
}
- (void)addButtonAction:(UIButton *)sender
{
    
    LDRScanQRcodeController *vc = [[LDRScanQRcodeController alloc] init];
    vc.delegate = self;
    [[LDRRootConfig sharedRootConfig] presentNavogationViewController:vc];
    
//    [self toBlueToothViewWithString:nil];
}

#pragma mark - LDRScanQRDelegate
- (void)didScanQRCompletion:(NSString *)string isMac:(BOOL)isMac
{
    if (isMac) {
        [self toBlueToothViewWithString:string];
    } else {
        [LDRHUD showHUDWithMessage:@"请扫描门锁二维码"];
    }
}
- (void)didClickNoQRCode
{
    [self toBlueToothViewWithString:nil];
}
- (void)toBlueToothViewWithString:(NSString *)string
{
    LDRBluetoothController *vc = [[LDRBluetoothController alloc] init];
    vc.scanQRCode = string;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRAddLockShowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRAddLockShowCell class])];
    if (indexPath.row == 0) {
        cell.bigTitleLabel.text = LDRAddLockSetpOne;
        cell.detailLabel.text = LDRAddLockSetpOneDetails;
        cell.showImageView.image = [UIImage imageNamed:@"add_step_one"];
    } else {
        cell.bigTitleLabel.text = LDRAddLockSetpTwo;
        cell.detailLabel.text = LDRAddLockSetpTwoDetails;
        cell.showImageView.image = [UIImage imageNamed:@"add_step_two"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 201.0f;
    }
    return 278.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return LDRAddLockSetpNote;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:LDR_TextLightGrayColor];
    [header.textLabel setFont:LDRFont12];
    [header.textLabel setTextAlignment:NSTextAlignmentCenter];
}

#pragma mark - Getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, LDR_WIDTH, 0.1);
        _tableView.tableHeaderView = view;
        [_tableView setBackgroundColor:LDR_BackgroundColor];
        [_tableView setSeparatorColor:LDR_BackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRAddLockShowCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LDRAddLockShowCell class])];
    }
    return _tableView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(116 + KBottomSafeHeight);
        }];
        [_bottomView setBackgroundColor:LDR_BackgroundColor];
        
        UIButton *agreeButton = [UIButton buttonWithTarget:self action:@selector(agreementButtonAction:)];
        [_bottomView addSubview:agreeButton];
        [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomView.mas_left).mas_offset(LDRPadding);
            make.top.equalTo(_bottomView.mas_top).mas_offset(8);
            make.height.mas_equalTo(LDRPadding);
        }];
        [agreeButton setImage:[UIImage imageNamed:@"square_normal"] forState:UIControlStateNormal];
        [agreeButton setImage:[UIImage imageNamed:@"square_selected"] forState:UIControlStateSelected];
        [agreeButton.titleLabel setFont:LDRFont12];
        [agreeButton setTitleColor:LDR_TextDarkGrayColor forState:UIControlStateNormal];
        [agreeButton setTitle:LDRAddLockSetpCompletion forState:UIControlStateNormal];
        
        UIButton *addButton = [UIButton mainButtonWithTarget:self action:@selector(addButtonAction:)];
        [_bottomView addSubview:addButton];
        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_bottomView).insets(UIEdgeInsetsMake(0, 16, 0, 16));
            make.top.equalTo(agreeButton.mas_bottom).mas_offset(30);
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [addButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
        addButton.enabled = NO;
        [addButton setTitle:LDRButtonAddNow forState:UIControlStateDisabled];
        [addButton setTitle:LDRButtonAddNow forState:UIControlStateNormal];
        self.addButton = addButton;
    }
    return _bottomView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
