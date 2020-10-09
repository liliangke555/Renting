//
//  LDRRenantsInfoController.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRenantsInfoController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "LDRHouseInfoEmptyView.h"
@interface LDRRenantsInfoController ()<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LDRHouseInfoEmptyView *emptyView;
@end

@implementation LDRRenantsInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
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
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        [_tableView setBackgroundColor:LDR_BackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource =self;
    }
    return _tableView;
}

- (LDRHouseInfoEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[LDRHouseInfoEmptyView alloc] initWithTitle:@"暂无租客信息" setImage:^(UIImageView * _Nonnull imageView) {
            [imageView setImage:[UIImage imageNamed:@"empty_renants"]];
        } buttonTitle:nil buttonAction:nil];
    }
    return _emptyView;
}
@end
