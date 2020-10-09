//
//  LDRWatchingHouseController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRWatchingHouseController.h"
#import "LDRWatchingHouseTableCell.h"
@interface LDRWatchingHouseController ()

@end

@implementation LDRWatchingHouseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRWatchingHouseTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRWatchingHouseTableCell class])];
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无看房记录";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRWatchingHouseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRWatchingHouseTableCell class])];
    cell.noticeType = indexPath.row % 3;
    return cell;
}
@end
