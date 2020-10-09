//
//  LDRAddRenantsViewController.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddRenantsViewController.h"
#import "LDRInputInfoCell.h"
@interface LDRAddRenantsViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation LDRAddRenantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加租客";
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.height.mas_equalTo(250);
    }];
    
    UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableBakcView.mas_bottom).mas_offset(LDRPadding);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
        make.height.mas_equalTo(LDRButtonHeight);
    }];
    [button setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
    [button setTitle:@"立即添加" forState:UIControlStateNormal];
    button.enabled = NO;
    self.button = button;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
}
- (void)buttonAction
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    if (indexPath.row == 0) {
        cell.title = @"租客姓名";
    } else {
        cell.title = @"租客手机号";
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"输入租客信息";
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:LDR_tableTitleColor];
    [header.textLabel setFont:LDRFont12];
}

@end
