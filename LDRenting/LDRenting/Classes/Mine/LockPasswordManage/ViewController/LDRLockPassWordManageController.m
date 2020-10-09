//
//  LDRLockPassWordManageController.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockPassWordManageController.h"
#import "LDRHouseInfoEmptyView.h"
#import "LDRLockPassManageTableCell.h"
@interface LDRLockPassWordManageController ()
@property (nonatomic, strong) LDRHouseInfoEmptyView *emptyView;
@end

@implementation LDRLockPassWordManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"远程密码管理";
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    self.tableView.rowHeight = 98;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRLockPassManageTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRLockPassManageTableCell class])];
}
- (void)showDelete
{
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
    MMItemMake(@"确定", MMItemTypeNormal, block)];
    LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"提示" detail:@"密码生效中，确认删除？" isWarning:YES items:items];
    [alertView show];
}
- (void)showCheck
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRLockPassManageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRLockPassManageTableCell class])];
    cell.overstayed = indexPath.row % 2 == 0;
    LDRWeakify(self);
    [cell setDidClickCheck:^{
        [weakSelf showCheck];
    }];
    [cell setDidClickDelete:^{
        [weakSelf showDelete];
    }];
    return cell;
}
#pragma mark - DZNEmptyDataSetSource

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return LDR_BackgroundColor;
}
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyView;
}
#pragma mark - Getter
- (LDRHouseInfoEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[LDRHouseInfoEmptyView alloc] initWithTitle:@"你还没有添加远程密码" setImage:^(UIImageView * _Nonnull imageView) {
            [imageView setImage:[UIImage imageNamed:@"empty_icon"]];
        } buttonTitle:@"去添加" buttonAction:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _emptyView;
}
@end
