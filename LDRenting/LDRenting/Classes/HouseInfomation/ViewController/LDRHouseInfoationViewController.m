//
//  LDRHouseInfoationViewController.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseInfoationViewController.h"
#import "LDRHouseInfomationHeader.h"
#import "LDRSegment.h"
#import "LDRRentRecordsController.h"
#import "LDRHouseMessageController.h"
#import "LDRRenantsInfoController.h"
#import "LDRHouseSettingViewController.h"
static CGFloat const headerHeight = 146.0f;
@interface LDRHouseInfoationViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) LDRHouseInfomationHeader *headerView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LDRSegment *segment;
@property (nonatomic, strong) LDRRentRecordsController *rentRecords;
@property (nonatomic, strong) LDRHouseMessageController *houseMessage;
@property (nonatomic, strong) LDRRenantsInfoController *renantsInfo;
@end

@implementation LDRHouseInfoationViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    self.whiteBack = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"房屋详情";
    [self scrollView];
    [self addChildViewController:self.rentRecords];
    [self.scrollView addSubview:self.rentRecords.view];
    [self addChildViewController:self.houseMessage];
    [self.scrollView addSubview:self.houseMessage.view];
    [self addChildViewController:self.renantsInfo];
    [self.scrollView addSubview:self.renantsInfo.view];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.segment.contentOffX = scrollView.contentOffset.x / LDR_WIDTH;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //ScrollView中根据滚动距离来判断当前页数
    int page = (int)scrollView.contentOffset.x/LDR_WIDTH;
    // 设置页码
    self.segment.selectedIndex = page;
}

#pragma mark - Getter
- (LDRHouseInfomationHeader *)headerView
{
    if (!_headerView) {
        _headerView = [[LDRHouseInfomationHeader alloc] initWithTitle:@"大菠萝的家" detail:@"地址：摩根中心-B栋25层3401" leftAction:^{
            
        } rightAction:^{
            LDRHouseSettingViewController *vc = [[LDRHouseSettingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [self.view insertSubview:_headerView atIndex:0];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(headerHeight+KStatusHeight);
        }];
    }
    return _headerView;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.segment.mas_bottom);
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        [_scrollView setContentSize:CGSizeMake(3*LDR_WIDTH, 0)];
        _scrollView.delegate =self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
- (LDRSegment *)segment
{
    if (!_segment) {
        _segment = [LDRSegment segmentWithTitles:@[@"收租记录",@"房屋信息",@"租客信息"]];
        [self.view addSubview:_segment];
        [_segment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom).mas_offset(-LDRControllerRadius*2);
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(55);
        }];
        LDRWeakify(self);
        [_segment setDidChengeSelected:^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(index * LDR_WIDTH, 0) animated:YES];
        }];
    }
    return _segment;
}
- (LDRRentRecordsController *)rentRecords
{
    if (!_rentRecords) {
        _rentRecords = [[LDRRentRecordsController alloc] init];
    }
    return _rentRecords;
}
- (LDRHouseMessageController *)houseMessage
{
    if (!_houseMessage) {
        _houseMessage = [[LDRHouseMessageController alloc] init];
    }
    return _houseMessage;
}
- (LDRRenantsInfoController *)renantsInfo
{
    if (!_renantsInfo) {
        _renantsInfo = [[LDRRenantsInfoController alloc] init];
    }
    return _renantsInfo;
}
#pragma mark - Layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.segment clipCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:LDRControllerRadius];
    [self.segment setClipsToBounds:YES];
    self.rentRecords.view.frame = CGRectMake(0, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
    self.houseMessage.view.frame = CGRectMake(LDR_WIDTH, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
    self.renantsInfo.view.frame = CGRectMake(LDR_WIDTH * 2, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
}
@end
