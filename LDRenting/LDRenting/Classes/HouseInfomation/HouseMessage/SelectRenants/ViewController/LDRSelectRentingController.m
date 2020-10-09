//
//  LDRSelectRentingController.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSelectRentingController.h"
#import "LDRMyReningHeaderView.h"
#import "LDRHouseInfoEmptyView.h"
#import "LDRAddRenantsViewController.h"
static CGFloat headerHeight = 198.0f;
@interface LDRSelectRentingController ()<LDRMyRentingHeaderDelegate>
@property (nonatomic, strong) LDRMyReningHeaderView *headerView;
@property (nonatomic, strong) LDRHouseInfoEmptyView *emptyView;
@end

@implementation LDRSelectRentingController

- (void)viewDidLoad {
    self.whiteBack = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(-LDRControllerRadius*2);
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
#pragma mark - LDRMyRentingHeaderDelegate
- (void)didToSearchText:(NSString *)text
{
    
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
- (LDRMyReningHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LDRMyReningHeaderView alloc] initWithTitle:@"选择租客"];
        [self.view insertSubview:_headerView atIndex:0];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(headerHeight + KStatusHeight);
        }];
        _headerView.delegate = self;
    }
    return _headerView;
}
- (LDRHouseInfoEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[LDRHouseInfoEmptyView alloc] initWithTitle:@"未搜索到该租客，您可以先添加租客" setImage:^(UIImageView * _Nonnull imageView) {
            [imageView setImage:[UIImage imageNamed:@"empty_renants"]];
        } buttonTitle:@"立即添加租客" buttonAction:^{
            LDRAddRenantsViewController *vc = [[LDRAddRenantsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _emptyView;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableBakcView clipCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:LDRControllerRadius];
    [self.tableBakcView setClipsToBounds:YES];
}
@end
