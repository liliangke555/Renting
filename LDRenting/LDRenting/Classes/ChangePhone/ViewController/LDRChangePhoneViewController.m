//
//  ViewController.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRChangePhoneViewController.h"
#import "LDRInputInfoCell.h"
@interface LDRChangePhoneViewController ()

@end

@implementation LDRChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改手机号";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    
}
- (void)changeButtonAction:(UIButton *)sender
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    [cell setTitle:@"手机号码"];
    [cell setDidEndEidting:^(NSString * _Nonnull string) {
            
    }];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(changeButtonAction:)];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(view).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding));
        make.centerY.equalTo(view);
        make.height.mas_equalTo(LDRButtonHeight);
    }];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    return view;
}
@end
