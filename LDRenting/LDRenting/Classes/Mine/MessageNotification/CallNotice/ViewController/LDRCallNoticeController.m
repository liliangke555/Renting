//
//  LDRCallNoticeController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCallNoticeController.h"
#import "LDRCallNoticeTableCell.h"
@interface LDRCallNoticeController ()

@end

@implementation LDRCallNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRCallNoticeTableCell class]) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass([LDRCallNoticeTableCell class])];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRCallNoticeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRCallNoticeTableCell class])];
    return cell;
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无催缴记录";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

@end
