//
//  LDRProfitBonusController.m
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRProfitBonusController.h"
#import "LDRProfitBonusHeader.h"
#import "LDRProBonusDetailsCell.h"
#import "LDRExplainAlertView.h"
#import "LDRAgentEarningsPageListRequest.h"
static CGFloat headerHeight = 102.0f;
@interface LDRProfitBonusController ()
@property (nonatomic, strong) LDRProfitBonusHeader *headerView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic) NSInteger currentPage;
@end

@implementation LDRProfitBonusController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    self.whiteBack = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
    UIView *view= [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 0, 0.1);
    [self.tableView setTableHeaderView:view];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRProBonusDetailsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRProBonusDetailsCell class])];
    [self.tableView reloadData];
    [self headerView];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(-LDRControllerRadius*2);
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    LDRWeakify(self);
    self.tableView.mj_header = [LDRRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 0;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [LDRRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - Networking
- (void)loadData
{
    LDRWeakify(self);
    LDRAgentEarningsPageListRequest *request = [LDRAgentEarningsPageListRequest new];
    request.current = self.currentPage;
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        LDRMyProfitList *list = response.data;
        if (weakSelf.currentPage == 0) {
            weakSelf.dataSource = [NSMutableArray arrayWithArray:list.records];
        } else {
            [weakSelf.dataSource addObjectsFromArray:list.records];
        }
        if (list.total < LDRRequestSize) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        weakSelf.currentPage ++;
        [weakSelf.tableView reloadData];
    } failHandler:^(BaseResponse *response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
- (void)showAlertView
{
    LDRExplainAlertView *view = [[LDRExplainAlertView alloc] initWithTitle:@"360金融推广收益说明" details:@"说明：\n1.您的收益来源于您的房屋出租后，租客注册成为我们合作伙伴产品的用户，并由此产生的获客收益，请放心收取\n2.您的收益提现功能正在开发中，敬请期待，您也可以联系我们的客服人员操作提现，详询: 4000545666"];
    view.attachedView = self.view;
    [view show];
}
#pragma mark  - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRProBonusDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRProBonusDetailsCell class])];
    return cell;
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无收益数据";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
#pragma mark - Getter
- (LDRProfitBonusHeader *)headerView
{
    if (!_headerView) {
        _headerView = [[LDRProfitBonusHeader alloc] init];
        [self.view insertSubview:_headerView atIndex:0];
        _headerView.frame = CGRectMake(0, 0, LDR_WIDTH, headerHeight + KNavBarAndStatusBarHeight);
        LDRWeakify(self);
        [_headerView setDidClickHelp:^{
            [weakSelf showAlertView];
        }];
    }
    return _headerView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
    }
    return _dataSource;
}
#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [self.tableBakcView clipCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:LDRControllerRadius];
    [self.tableBakcView setClipsToBounds:YES];
}

@end
