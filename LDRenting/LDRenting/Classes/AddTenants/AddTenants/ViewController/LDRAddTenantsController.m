//
//  LDRAddTenantsController.m
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddTenantsController.h"
#import "LDRAddTenantsCell.h"
#import "LDRInvitationTenantsController.h"
#import "LDRReplaceAddController.h"
static NSString * const LDRinvitation = @"invitation";
static NSString * const LDRregister = @"register";
@interface LDRAddTenantsController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LDRAddTenantsController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"添加租客";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRAddTenantsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRAddTenantsCell class])];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    
    LDRAddTenantsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRAddTenantsCell class])];
    cell.title = dic[@"title"];
    cell.detail = dic[@"detail"];
    [cell.bigImageView setImage:[UIImage imageNamed:dic[@"image"]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    NSString *key = dic[@"key"];
    if ([key isEqualToString:LDRinvitation]) {
        LDRInvitationTenantsController *vc = [[LDRInvitationTenantsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([key isEqualToString:LDRregister]) {
        LDRReplaceAddController *vc = [[LDRReplaceAddController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Getter
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
            @{
                @"key":LDRinvitation,
                @"title":@"租客邀请",
                @"detail":@"房东填写租客基本信息后，通过短信/微信分享邀请链接至租客，由租客进行实人认证和账号激活",
                @"image":@"addtenants_invitation",
            },
            @{
                @"key":LDRregister,
                @"title":@"替租客登记",
                @"detail":@"房东用自己手机替租客登记信息并帮助租客作实人认证，建议针对未使用微信的老人或儿童，采用此方式激活",
                @"image":@"addtenants_register",
            }
                       ];
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
