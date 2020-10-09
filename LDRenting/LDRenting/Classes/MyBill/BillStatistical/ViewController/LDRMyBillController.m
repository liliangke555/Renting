//
//  LDRMyBillController.m
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyBillController.h"
#import "LDRMyBillSectionView.h"
#import "LDRMyBillDetailsCell.h"
#import "LDRMyBillEmptyCell.h"
#import "ZJPickerView.h"
#import "LDRMyBillTotalView.h"
#import "LDRIncomeExpenditureDetailsRequest.h"
#import "LDRSelectHouseController.h"
#import "LDRAllRentHouseRequest.h"
static CGFloat topHeight = 99.0f;
static CGFloat titleTopHeight = 25.0f;
static CGFloat sectionHeight = 34.0f;
static CGFloat const headerHeight = 168.0f;
static NSString *LDRBILLTOTAL = @"账单共计";
static NSString *LDRBILLDETILS = @"收支详情";
@interface LDRMyBillController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *tableBakcView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, strong) LDRMyBillTotalView *totalHeaderView;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UILabel *houseLabel;
@property (nonatomic, strong) LDRMybillModel *billModel;
@property (nonatomic, strong) NSMutableArray *houseData;
@end

@implementation LDRMyBillController

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
    self.navigationItem.title = @"账单统计";
    self.billModel = [[LDRMybillModel alloc] init];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM"];
    NSString *DateTime = [formatter stringFromDate:date];
    self.timeString = DateTime;
    [self setupView];
    
    [self reloadBillData];
    [self reloadHouseData];
}
#pragma mark - SetupView
- (void)setupView
{
    UIImageView *backImage = [[UIImageView alloc] init];
    [self.view insertSubview:backImage atIndex:0];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [backImage setImage:[UIImage imageNamed:@"background_icon"]];
    
    UILabel *allLabel = [[UILabel alloc] init];
    [self.view addSubview:allLabel];
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).mas_offset(LDRPadding);
        make.top.equalTo(self.view.mas_top).mas_offset(titleTopHeight + KNavBarAndStatusBarHeight);
    }];
    [allLabel setTextColor:LDR_BackgroundColor];
    [allLabel setFont:LDRFont20];
    [allLabel setText:@"全部"];
    allLabel.userInteractionEnabled = YES;
    [allLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allLabelAction:)]];
    self.allLabel = allLabel;
    
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(allLabel.mas_left);
            make.top.equalTo(allLabel.mas_bottom).mas_offset(LDRRadius);
    }];
    [label setTextColor:LDR_BackgroundColor];
    [label setFont:LDRFont12];
    [label setText:@"共0套房"];
    self.houseLabel = label;
    
    UIImageView *downImageView = [[UIImageView alloc] init];
    [self.view addSubview:downImageView];
    [downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).mas_offset(-LDRPadding);
        make.bottom.equalTo(allLabel.mas_bottom);
    }];
    [downImageView setImage:[UIImage imageNamed:@"white_down_icon"]];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableBakcView.mas_top);
        make.right.equalTo(self.view);
    }];
    [imageView setImage:[UIImage imageNamed:@"mybill_header_back"]];
    
    LDRWeakify(self);
    self.totalHeaderView.timeString = self.timeString;
    [self.totalHeaderView setDidClickTimeAction:^(UIButton * _Nonnull sender) {
        [weakSelf showTimeSelector];
    }];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, LDRPadding)];
    [self.tableView setTableHeaderView:view];
    [self.tableView reloadData];
}
#pragma mark - Networking
- (void)reloadBillData
{
    LDRIncomeExpenditureDetailsRequest *request = [LDRIncomeExpenditureDetailsRequest new];
    request.houseId = @"";
    request.month = self.timeString;
    LDRWeakify(self);
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        weakSelf.billModel = [response.data firstObject];
        weakSelf.dataSource = weakSelf.billModel.userCashbookDetailsRespVos;
        weakSelf.totalHeaderView.totalMony = [NSString stringWithFormat:@"%.2f",[weakSelf.billModel.income floatValue]];
        weakSelf.totalHeaderView.numberString = [NSString stringWithFormat:@"%ld",weakSelf.dataSource.count];
        [weakSelf.tableView reloadData];
    } failHandler:^(BaseResponse *response) {
        
    }];
}
- (void)reloadHouseData
{
    LDRWeakify(self);
    LDRAllRentHouseRequest *request = [LDRAllRentHouseRequest new];
    request.current = 0;
    request.publishStatus = 0;
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        LDRAllRentHouseModel *model = response.data;
        [weakSelf.houseLabel setText:[NSString stringWithFormat:@"共%ld套房",model.total]];
        weakSelf.houseData = [NSMutableArray arrayWithArray:model.records];
    } failHandler:^(BaseResponse *response) {
    }];
}
#pragma mark - IBAction
- (void)allLabelAction:(UITapGestureRecognizer *)sender
{/*
    LDRWeakify(self);
    [ZJNormalPickerView zj_showStringPickerWithTitle:@"请选择" dataSource:@[@"大菠萝的家",@"小菠萝的家",@"中菠萝的家",@"金菠萝的家",@"绿菠萝的家",@"大、蓝菠萝的家",@"花菠萝的家"] defaultSelValue:nil resultBlock:^(id selectValue, NSInteger index) {
        [weakSelf.allLabel setText:selectValue];
    }];*/
    LDRWeakify(self);
    LDRSelectHouseController *vc = [[LDRSelectHouseController alloc] init];
    [vc setDidSelectedHouse:^(LDRRentHouseModel * _Nonnull model) {
        [weakSelf.allLabel setText:model.houseName];
    }];
    vc.dataSource = self.houseData;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)showTimeSelector
{
    LDRWeakify(self);
    [ZJDatePickerView zj_showDatePickerWithTitle:nil dateType:ZJDatePickerModeYM defaultSelValue:self.timeString minDate:nil maxDate:[NSDate date] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        weakSelf.timeString = selectValue;
        weakSelf.totalHeaderView.timeString= selectValue;
        [weakSelf reloadBillData];
    } cancelBlock:^{
        
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count]<= 0 ? 1 : [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource count] <= 0) {
        LDRMyBillEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRMyBillEmptyCell class])];
        return cell;;
    }
    LDRMybillDetailModel *detailModel = [self.dataSource objectAtIndex:indexPath.row];
    LDRMyBillDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRMyBillDetailsCell class])];
    cell.house = detailModel.houseName;
    cell.income = detailModel.bookingType;
    cell.time = detailModel.bookDate;
    cell.note = detailModel.memo;
    cell.money = [NSString stringWithFormat:@"%.2f",[detailModel.bookMoney floatValue]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *string = LDRBILLDETILS;
    NSString *icon = @"mybill_details_icon";
    LDRMyBillSectionView *view = [[LDRMyBillSectionView alloc] init];
    [view.titleLabel setText:string];
    [view.imageView setImage:[UIImage imageNamed:icon]];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}
#pragma mark - Getter
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}
#pragma mark - Getter

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableBakcView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.totalHeaderView.mas_bottom);
            make.bottom.left.right.equalTo(self.tableBakcView).insets(UIEdgeInsetsZero);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setBackgroundColor:LDR_BackgroundColor];
        [_tableView setSeparatorColor:LDR_BackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRMyBillDetailsCell class]) bundle:nil]
             forCellReuseIdentifier:NSStringFromClass([LDRMyBillDetailsCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRMyBillEmptyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LDRMyBillEmptyCell class])];
    }
    return _tableView;
}
- (UIView *)tableBakcView
{
    if (!_tableBakcView) {
        _tableBakcView = [[UIView alloc] init];
        _tableBakcView.frame = CGRectMake(LDRPadding, topHeight + KNavBarAndStatusBarHeight, LDR_WIDTH - LDRPadding, LDR_HEIGHT - (topHeight + KNavBarAndStatusBarHeight));
        _tableBakcView.backgroundColor = LDR_BackgroundColor;
        [self.view addSubview:_tableBakcView];
        
        [_tableBakcView clipCorners:UIRectCornerTopLeft radius:LDRRadius];
        [_tableBakcView setClipsToBounds:YES];
    }
    return _tableBakcView;
}
- (LDRMyBillTotalView *)totalHeaderView
{
    if (!_totalHeaderView) {
        _totalHeaderView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LDRMyBillTotalView class])
                                                          owner:nil
                                                        options:nil] lastObject];
        [self.tableBakcView addSubview:_totalHeaderView];
        [_totalHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.tableBakcView).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(headerHeight);
        }];
    }
    return _totalHeaderView;
}
#pragma mark - Layout

@end
