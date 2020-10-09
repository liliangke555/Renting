//
//  LDRHomeTableViewAgente.m
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeTableViewAgente.h"
#import "LDRHomeNoLoginSectionView.h"
#import "LDRHomeMessageTableViewCell.h"
#import "LDRHomeHouseManagerCell.h"
#import "LDRHomeEmptyDataCell.h"
#import "LDRHomeHouseInfoCell.h"
#import "LDRHomeNavigationBar.h"
#import "LDRMessageBannerView.h"
#import "LDRHomeMessageBannderView.h"

static NSString *const LDRTOP = @"LDRTOP";
static NSString *const LDRMID = @"LDRMID";
static NSString *const LDRBOTTOM = @"LDRBOTTOM";

@interface LDRHomeTableViewAgente ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) LDRMessageBannerView *banner;
@end

@implementation LDRHomeTableViewAgente

#pragma mark - IBAction

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navForm changeBackgroundColorWithContentoff:scrollView.contentOffset];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [self.dataSource objectAtIndex:section];
    NSString *key = [dic objectForKey:@"key"];
    if ([key isEqualToString:LDRTOP] && self.isLogin) {
        return 1;
    }
    if ([key isEqualToString:LDRBOTTOM] && self.isLogin) {
        return 3+1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.section];
    NSString *key = [dic objectForKey:@"key"];
    if ([key isEqualToString:LDRTOP]) {
        if (indexPath.row == 0 && self.isLogin) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                [cell setBackgroundColor:[UIColor colorWithHex:0xFEFCEEFF]];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                LDRMessageBannerView *banner = [[LDRMessageBannerView alloc] initWithFrame:CGRectMake(16, 0, LDR_WIDTH - 50, 44)];
                banner.timeInterval = 3.0f;
                self.banner = banner;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell addSubview:banner];
            }
            self.banner.bannerArray = self.messageArray;
            return cell;
        }
        LDRHomeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHomeMessageTableViewCell class])];
        [cell setImageToImageView:^(UIImageView * _Nonnull imageView) {
            if (indexPath.row == 0) {
                [imageView setImage:[UIImage imageNamed:LDRNoLoginMessageIconOne]];
            } else {
                [imageView setImage:[UIImage imageNamed:LDRNoLoginMessageIconTwo]];
            }
        }];
        return cell;
    }
    if ([key isEqualToString:LDRMID]) {
        if (indexPath.row == 0) {
            LDRHomeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHomeMessageTableViewCell class])];
            [cell setImageToImageView:^(UIImageView * _Nonnull imageView) {
                [imageView setImage:[UIImage imageNamed:LDRNoLoginMessageNoSever]];
            }];
            cell.titleString = LDRHomeNoservice;
            return cell;
        }
        if (indexPath.row == 1) {
            LDRHomeHouseManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHomeHouseManagerCell class])];
            cell.houseNumber = [NSString stringWithFormat:@"%ld",self.model.houseCount];
            cell.tenantNumber = [NSString stringWithFormat:@"%ld",self.model.tenantCount];
            LDRWeakify(self);
            [cell didClickHouse:^{
                if ([weakSelf.form respondsToSelector:@selector(didClickHouse)]) {
                    [weakSelf.form didClickHouse];
                }
                
                        } clickTenant:^{
                            if ([weakSelf.form respondsToSelector:@selector(didClickTenant)]) {
                                [weakSelf.form didClickTenant];
                            }
                        }];
            return cell;
        }
    }
    if ([key isEqualToString:LDRBOTTOM]) {
        if (indexPath.row == 3) {
            LDRHomeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHomeMessageTableViewCell class])];
            [cell setImageToImageView:^(UIImageView * _Nonnull imageView) {
                [imageView setImage:[UIImage imageNamed:@"home_message_bottom"]];
            }];
            cell.titleString = nil;
            return cell;
        } else  {
            if (self.isLogin) {
                LDRHomeHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHomeHouseInfoCell class])];
                return cell;
            }
            LDRHomeEmptyDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRHomeEmptyDataCell class])];
            return cell;;
        }
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.section];
    NSString *key = [dic objectForKey:@"key"];
    if ([key isEqualToString:LDRTOP]) {
        if (indexPath.row == 0 && self.isLogin) {
            if ([self.form respondsToSelector:@selector(toNoticeView)]) {
                [self.form toNoticeView];
            }
        }
        [[LDRRootConfig sharedRootConfig] toLogin];
    }
}
#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
//        if (self.isLogin) {
//            return 0.0f;
//        }
        return 24.0f;
    }
    return 0.1f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return LDRHomeMyWallet;
    }
    if (section == 2) {
        return LDRHomeHousingTrends;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (section != 0) {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:LDR_TextBalckColor];
        [header.textLabel setFont:LDRFont18];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1f;
    }
    return 44;
}
#pragma mark - Setter
- (void)setModel:(LDRCashbookIndexCountModel *)model
{
    _model = model;
}
#pragma mark - Getter

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
            @{
                @"key":LDRTOP,
            },
            @{
                @"key":LDRMID,
            },
            @{
                @"key":LDRBOTTOM,
            }
        ];
    }
    return _dataSource;
}

@end
