//
//  LDRHouseMessageController.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseMessageController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "LDRHouseInfoEmptyView.h"
#import "LDRCreateHouseGuideController.h"
#import "LDRHouseContractTableCell.h"
#import "LDRHoseBaseInfoTableCell.h"
#import "LDRHousePhotoTableCell.h"
#import "LDRHouseConfigBackTableCell.h"
#import "LDRHouseContractController.h"

static NSString * const LDRContract = @"合同信息";
static NSString * const LDRBaseInfo = @"基本信息";
static NSString * const LDRphoto = @"房屋图片";
static NSString * const LDRConfig = @"房屋配置";

@interface LDRHouseMessageController ()<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate,
LDRAlertDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LDRHouseInfoEmptyView *emptyView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LDRHouseMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableView];
    [self reloadViewLayout];
}
- (void)reloadViewLayout
{
    if (self.dataSource.count > 0) {
        [self bottomView];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
    } else {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
}
#pragma mark - IBAction
- (void)buttonAction
{
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            
        } else {
            
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
                      MMItemMake(@"确定", MMItemTypeNormal, block)];
    LDRAlterView *alert = [[LDRAlterView alloc] initWithTitle:@"房屋上架确认" detail:@"是否将该房屋上架到360好房" agreeString:@"我承诺房源真实并同意" agreement:@"《360租房房源推广协议》" items:items];
    alert.attachedView = self.parentViewController.view;
    alert.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    alert.delegate = self;
    [alert show];
}
#pragma mark - LDRAlertDelegate
- (void)checkAgreement
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    if ([title isEqualToString:LDRContract]) {
        LDRHouseContractTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHouseContractTableCell class])];
        cell.signUp = NO;
        return cell;
    }
    if ([title isEqualToString:LDRBaseInfo]) {
        LDRHoseBaseInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHoseBaseInfoTableCell class])];
        return cell;
    }
    if ([title isEqualToString:LDRphoto]) {
        LDRHousePhotoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHousePhotoTableCell class])];
        return cell;
    }
    if ([title isEqualToString:LDRConfig]) {
        LDRHouseConfigBackTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHouseConfigBackTableCell class])];
        return cell;
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    if ([title isEqualToString:LDRContract]) {
        LDRHouseContractController *vc = [[LDRHouseContractController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource =self;
        [_tableView setBackgroundColor:LDR_BackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHouseContractTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHouseContractTableCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHoseBaseInfoTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHoseBaseInfoTableCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHousePhotoTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHousePhotoTableCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHouseConfigBackTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRHouseConfigBackTableCell class])];
    }
    return _tableView;
}
- (LDRHouseInfoEmptyView *)emptyView
{
    if (!_emptyView) {
        LDRWeakify(self);
        _emptyView = [[LDRHouseInfoEmptyView alloc] initWithTitle:@"还未添加房屋信息" setImage:^(UIImageView * _Nonnull imageView) {
            [imageView setImage:[UIImage imageNamed:@"empty_icon"]];
        } buttonTitle:@"去完善" buttonAction:^{
            LDRCreateHouseGuideController *vc = [[LDRCreateHouseGuideController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _emptyView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[LDRContract,LDRBaseInfo,LDRphoto,LDRConfig];
    }
    return _dataSource;
}
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
        [button setTitle:@"上架" forState:UIControlStateNormal];
    }
    return _bottomView;
}
@end
