//
//  LDRCallPoliceNotificationController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCallPoliceNotificationController.h"
#import "LDRCallPoliceNoticeTableCell.h"
@interface LDRCallPoliceNotificationController ()

@end

@implementation LDRCallPoliceNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRCallPoliceNoticeTableCell class]) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass([LDRCallPoliceNoticeTableCell class])];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRCallPoliceNoticeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRCallPoliceNoticeTableCell class])];
    return cell;
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无报警记录";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

@end
