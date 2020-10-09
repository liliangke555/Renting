//
//  LDRHouseInfoController.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseInfoController.h"
#import "LDRInputInfoCell.h"
#import "LDRSelectLocationCell.h"
#import "LDRHouseInfoFooterView.h"
#import "LDRAuthenticationController.h"
#import "LDRMapViewController.h"
#import "LDRAddHouseAddRequest.h"
#import "LDRCheckUserRealPeopleRequest.h"
#import "LDRAddLockSuccessController.h"
static NSString * const LDRINPUT = @"LDRINPUT";
static NSString * const LDRLOCATION = @"LDRLOCATION";
static NSString * const LDRBUTTON = @"LDRBUTTON";
static CGFloat tableRowHeight = 64;
static CGFloat bottomHeight = 280;
@interface LDRHouseInfoController ()<UITableViewDelegate,UITableViewDataSource,LDRMapViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) LDRHouseInfoFooterView *bottomView;
@property (nonatomic, copy) NSString *addressString;
@property (nonatomic, copy) NSString *houseName;
@property (nonatomic, strong) AMapPOI *manpoi;
@property (nonatomic, strong) UIButton *nextStep;
@property (nonatomic, strong) LDRAddHouseModel *addModel;
@end

@implementation LDRHouseInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"房屋信息";
    [self.view setBackgroundColor:LDR_BackgroundColor];
    self.tableView.tableFooterView = self.bottomView;
}
#pragma mark - Networking
- (void)addHouse
{
    if (self.houseName.length <= 0) {
        [LDRHUD showHUDWithMessage:@"请输入房屋名称"];
        return;
    }
    if (self.houseName.length > 8) {
        [LDRHUD showHUDWithMessage:@"房屋名称不可大于8个字"];
        return;
    }
    if (self.addressString.length <= 0) {
        [LDRHUD showHUDWithMessage:@"请选择房屋位置"];
        return;
    }
    LDRWeakify(self);
    [LDRHUD showLoadingInView:self.view];
    LDRAddHouseAddRequest *request = [LDRAddHouseAddRequest new];
    request.address = self.addressString;
    request.houseName = self.houseName;
    request.latitude = @(self.manpoi.location.latitude);
    request.longitude = @(self.manpoi.location.longitude);
    request.mac = self.macString;
    request.region = self.manpoi.adcode;
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        LDRAddHouseModel *model = response.data;
        weakSelf.addModel = model;
        [weakSelf loadRealPeople];
    } failHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
    }];
}
- (void)loadRealPeople
{
    LDRWeakify(self);
    LDRCheckUserRealPeopleRequest *request = [LDRCheckUserRealPeopleRequest new];
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
        LDRCheckRealModel *model = response.data;
        if (model.isRealPeople) {
            LDRAddLockSuccessController *vc = [[LDRAddLockSuccessController alloc] init];
            vc.houseName = weakSelf.houseName;
            vc.macString = weakSelf.macString;
            vc.userHouseRelationId = weakSelf.addModel.userHouseRelationId;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else {
            LDRAuthenticationController *vc = [[LDRAuthenticationController alloc] init];
            vc.houseName = weakSelf.houseName;
            vc.macString = weakSelf.macString;
            vc.userHouseRelationId = weakSelf.addModel.userHouseRelationId;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    } failHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
    }];
}
#pragma mark - IBAction

- (void)nextStep:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self addHouse];
}
#pragma mark - LDRMapViewDelegate
- (void)didSelectedAddress:(AMapPOI *)mapPOI
{
    self.manpoi = mapPOI;
    self.addressString = [NSString stringWithFormat:@"%@%@%@%@%@",mapPOI.province,mapPOI.city,mapPOI.district,mapPOI.address,mapPOI.name];
    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *key = dic[@"key"];
    NSString *title = dic[@"title"];
    if ([key isEqualToString:LDRINPUT]) {
        LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
        cell.title = title;
        cell.detail = self.houseName;
        LDRWeakify(self);
        [cell setDidEndEidting:^(NSString * _Nonnull string) {
            weakSelf.houseName = string;
        }];
        return cell;
    }
    if ([key isEqualToString:LDRLOCATION]) {
        LDRSelectLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRSelectLocationCell class])];
        cell.title = title;
        cell.details = self.addressString;
        return cell;
    }
    if ([key isEqualToString:LDRBUTTON]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(nextStep:)];
            [cell.contentView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell).with.insets(UIEdgeInsetsMake(8, 16, 8, 16));
            }];
            [button setTitle:title forState:UIControlStateNormal];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            self.nextStep = button;
        }
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *key = dic[@"key"];
    if ([key isEqualToString:LDRLOCATION]) {
        [self.view endEditing:YES];
        LDRMapViewController *vc = [[LDRMapViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - Getter

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = tableRowHeight;
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, LDR_WIDTH, 0.1);
        _tableView.tableHeaderView = view;
        [_tableView setBackgroundColor:LDR_BackgroundColor];
        [_tableView setSeparatorColor:LDR_BackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRSelectLocationCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRSelectLocationCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[
            @{
                @"details":@"",
                @"title":@"房屋名称",
                @"key":LDRINPUT
            },
            @{
                @"details":@"",
                @"title":@"房屋位置",
                @"key":LDRLOCATION
            },
            @{
                @"details":@"",
                @"title":@"下一步",
                @"key":LDRBUTTON
            },
        ]];
    }
    return _dataSource;
}

- (LDRHouseInfoFooterView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LDRHouseInfoFooterView class])
          owner:nil
        options:nil] lastObject];
        _bottomView.frame = CGRectMake(0, 0, LDR_WIDTH, bottomHeight);
    }
    return _bottomView;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
}

@end
