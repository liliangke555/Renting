//
//  LDRICCardManagerController.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRICCardManagerController.h"
#import "LDRFingerprintPermissionCell.h"
#import "LDRFingerprintCell.h"
@interface LDRICCardManagerController ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LDRICCardManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"IC卡管理";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRFingerprintPermissionCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRFingerprintPermissionCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRFingerprintCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRFingerprintCell class])];
}

#pragma mark - IBAction
- (void)bottomButtonAction:(UIButton *)sender
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        LDRFingerprintPermissionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRFingerprintPermissionCell class])];
        [cell setTitle:@"IC开门权限"];
        [cell setImageUrl:@"iccard_main_icon"];
        return cell;
    }
    LDRFingerprintCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRFingerprintCell class])];
    cell.nameString = [self.dataSource objectAtIndex:indexPath.row];
    [cell setImageUrl:@"iccard_open"];
    [cell setDidClickDelete:^{
            
    }];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];

    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    [label setTextColor:LDR_TextGrayColor];
    [label setFont:LDRFont12];
    [label setText:@"  tips：每个用户最多只能添加一张IC卡  "];
    
    UIView *lineView = [[UIView alloc] init];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(LDRPadding);
        make.right.equalTo(label.mas_left);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(1.0f);
    }];
    [lineView setBackgroundColor:[UIColor colorWithHex:0xD8DDE6FF]];
    UIView *lineView1 = [[UIView alloc] init];
    [view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right);
        make.right.equalTo(view.mas_right).mas_offset(-LDRPadding);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(1.0f);
    }];
    [lineView1 setBackgroundColor:[UIColor colorWithHex:0xD8DDE6FF]];
    return view;
}
#pragma mark - Getter
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView setBackgroundColor:LDR_BackgroundColor];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(bottomButtonAction:)];
        [_bottomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bottomView.mas_top).mas_offset(LDRPadding);
            make.left.right.equalTo(_bottomView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
            make.bottom.equalTo(_bottomView.mas_bottom).mas_offset(-LDRPadding-KBottomSafeHeight);
        }];
        [button setTitle:@"添加IC卡" forState:UIControlStateNormal];
        [button setImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
        [button setEnabled:NO];
    }
    return _bottomView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"指纹开门权限",@"大菠萝的IC卡1"];
    }
    return _dataSource;
}
-(void)viewDidLayoutSubviews
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

@end
