//
//  LDRBaseTableViewController.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewController.h"

@interface LDRBaseTableViewController ()

@end

@implementation LDRBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LDR_BackgroundColor;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    [self tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

#pragma mark - DZNEmptyDataSetSource

// MARK: 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_icon"];
}

// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无记录";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
#pragma mark - Getter

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.tableBakcView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableBakcView).with.insets(UIEdgeInsetsZero);
        }];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        [_tableView setTableHeaderView:view];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.autoHideMjFooter = YES;
        [_tableView setBackgroundColor:LDR_BackgroundColor];
        [_tableView setSeparatorColor:LDR_BackgroundColor];
    }
    return _tableView;
}
- (UIView *)tableBakcView
{
    if (!_tableBakcView) {
        _tableBakcView = [[UIView alloc] init];
        _tableBakcView.backgroundColor = LDR_BackgroundColor;
        [self.view addSubview:_tableBakcView];
//        [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
//        }];
    }
    return _tableBakcView;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

@end
