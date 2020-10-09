//
//  LDRRentRecordsController.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRentRecordsController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "LDRHouseInfoEmptyView.h"
#import "LDRMyBillDetailsCell.h"
@interface LDRRentRecordsController ()<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LDRHouseInfoEmptyView *emptyView;
@property (nonatomic, strong) UIButton *button;
@end

@implementation LDRRentRecordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableView];
    [self button];
}
#pragma mark - IBAction
- (void)buttonAction:(UIButton *)sender
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRMyBillDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRMyBillDetailsCell class])];
    cell.cellType = LDRBillCellRentRecords;
    cell.house = @"大菠萝的家";
    cell.income = indexPath.row % 3 == 0;
    cell.time = @"2020-09-12";
    cell.note = @"房租收缴";
    cell.money = [NSString stringWithFormat:@"%u",arc4random() % 10000];
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
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource =self;
        [_tableView setBackgroundColor:LDR_BackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRMyBillDetailsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRMyBillDetailsCell class])];
    }
    return _tableView;
}
- (LDRHouseInfoEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[LDRHouseInfoEmptyView alloc] initWithTitle:@"暂无收支记录" setImage:^(UIImageView * _Nonnull imageView) {
            [imageView setImage:[UIImage imageNamed:@"empty_icon"]];
        } buttonTitle:@"记一笔" buttonAction:^{
            
        }];
    }
    return _emptyView;
}
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithTarget:self action:@selector(buttonAction:)];
        [self.view insertSubview:_button aboveSubview:self.tableView];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).mas_offset(-24-KBottomSafeHeight);
            make.right.equalTo(self.view.mas_right).mas_offset(-24.0f);
            make.width.height.mas_equalTo(44);
        }];
        [_button setImage:[UIImage imageNamed:@"houseifno_rentrecords_button"] forState:UIControlStateNormal];
    }
    return _button;
}
@end
