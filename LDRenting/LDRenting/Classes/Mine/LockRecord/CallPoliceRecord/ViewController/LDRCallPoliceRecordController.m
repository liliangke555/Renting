//
//  LDRCallPoliceRecordController.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCallPoliceRecordController.h"
#import "LDRLockRecordViewCell.h"

@interface LDRCallPoliceRecordController ()

@end

@implementation LDRCallPoliceRecordController

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
    NSString *title = @"暂无报警记录";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont16,
        NSForegroundColorAttributeName:LDR_TextGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

@end
