//
//  LDRSelectHouseController.m
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSelectHouseController.h"
#import "LDRSelectHouseTableCell.h"
#import "LDRAllRentHouseRequest.h"
@interface LDRSelectHouseController ()

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) LDRRentHouseModel *selectedModel;
@end

@implementation LDRSelectHouseController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor]];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择房屋";
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.bottom.equalTo(self.button.mas_top).mas_offset(-LDRPadding);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRSelectHouseTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRSelectHouseTableCell class])];
    
    LDRWeakify(self);
    self.tableView.mj_header = [LDRRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 0;
        [weakSelf reloadAllRentHouse];
    }];
    self.tableView.mj_footer = [LDRRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf reloadAllRentHouse];
    }];
}
#pragma mark - Networking
- (void)reloadAllRentHouse
{
    LDRWeakify(self);
    LDRAllRentHouseRequest *request = [LDRAllRentHouseRequest new];
    request.current = self.currentPage;
    request.publishStatus = 0;
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        LDRAllRentHouseModel *model = response.data;
        if (weakSelf.currentPage == 0) {
            weakSelf.dataSource = [NSMutableArray arrayWithArray:model.records];
        } else {
            [weakSelf.dataSource addObjectsFromArray:model.records];
        }
        if (model.total < LDRRequestSize) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        weakSelf.currentPage ++;
        [weakSelf.tableView reloadData];
    } failHandler:^(BaseResponse *response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - IBAction
- (void)buttonAction:(UIButton *)sender
{
    if (self.didSelectedHouse) {
        self.didSelectedHouse(self.selectedModel);
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRSelectHouseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRSelectHouseTableCell class])];
    LDRRentHouseModel *model = [self.dataSource objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRRentHouseModel *model = [self.dataSource objectAtIndex:indexPath.row];
    self.selectedModel = model;
}
#pragma mark - Getter
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction:)];
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, LDRPadding, LDRPadding + KBottomSafeHeight, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [_button setTitle:@"确认" forState:UIControlStateNormal];
    }
    return _button;
}
@end
