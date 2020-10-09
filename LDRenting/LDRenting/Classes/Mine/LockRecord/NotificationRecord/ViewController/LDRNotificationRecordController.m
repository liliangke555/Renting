//
//  LDRNotificationRecordController.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRNotificationRecordController.h"
#import "LDRLockRecordViewCell.h"

@interface LDRNotificationRecordController ()

@end

@implementation LDRNotificationRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding + KBottomSafeHeight, LDRPadding));
    }];
    
    [self.tableBakcView.layer setShadowOffset:CGSizeZero];
    [self.tableBakcView.layer setShadowRadius:LDRShadowBottomRaius];
    [self.tableBakcView.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.tableBakcView.layer setShadowOpacity:1.0f];
    [self.tableBakcView.layer setCornerRadius:LDRShadowRadius];
    
    [self.tableView.layer setShadowOffset:CGSizeZero];
    [self.tableView.layer setShadowRadius:LDRShadowRadius];
    [self.tableView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.tableView.layer setShadowOpacity:1.0f];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRLockRecordViewCell class]) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass([LDRLockRecordViewCell class])];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRLockRecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRLockRecordViewCell class])];
    cell.recordType = LDRLockRecordTypeNotification;
    cell.last = indexPath.row == 2;
    cell.titleString = @"电池电量不足";
    cell.timeString = @"2020-09-09 09:09:09";
    return cell;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无通知记录";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

@end
