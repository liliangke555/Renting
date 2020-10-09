//
//  LDRLandlordOpenDoorManageController.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLandlordOpenDoorManageController.h"
#import "LDRLandlordOpenDoorHeaderView.h"
@interface LDRLandlordOpenDoorManageController ()
@property (nonatomic, strong)LDRLandlordOpenDoorHeaderView *headerView;
@end

@implementation LDRLandlordOpenDoorManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self headerView];
}
#pragma mark - Setter
- (void)setOpenType:(LDROffLineOpenType)openType
{
    _openType = openType;
    if (openType == LDROffLineOpenTypeFinger) {
        self.navigationItem.title = @"指纹管理";
        self.headerView.titleString = @"指纹开门权限";
        [self.headerView.imageView setImage:[UIImage imageNamed:@"fingerprint_green_icon"]];
    } else if (openType == LDROffLineOpenTypeICCard) {
        self.navigationItem.title = @"IC卡管理";
        self.headerView.titleString = @"IC卡开门权限";
        [self.headerView.imageView setImage:[UIImage imageNamed:@"iccard_main_icon"]];
    } else {
        self.navigationItem.title = @"本地密码管理";
        self.headerView.titleString = @"密码开门权限";
        [self.headerView.imageView setImage:[UIImage imageNamed:@"password_main_icon"]];
    }
}
#pragma mark - Getter
- (LDRLandlordOpenDoorHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LDRLandlordOpenDoorHeaderView alloc] init];
        [self.view addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(64);
        }];
        [_headerView.layer setCornerRadius:LDRRadius];
    }
    return _headerView;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(LDRPadding);
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
@end
