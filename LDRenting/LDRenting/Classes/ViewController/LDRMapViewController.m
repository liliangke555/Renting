//
//  LDRMapViewController.m
//  LDRenting
//
//  Created by MAC on 2020/8/5.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMapViewController.h"
#import "LDRMapTableView.h"
#import "LDRMapAddressTableCell.h"
#import "LDRMapScrollView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
static NSString * const mapAppKey = @"62e93f6e55f2a4f2c831eeaf668a3d26";
static CGFloat searchBarHeight = 44;
static CGFloat topHeight = 112;
static NSString *searchType = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
@interface LDRMapViewController ()<
MAMapViewDelegate,
AMapSearchDelegate,
AMapLocationManagerDelegate,
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate,
DZNEmptyDataSetSource>
@property (nonatomic, strong) AMapSearchAPI *searchAPI;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
// 大头针
@property (nonatomic, strong) UIImageView *pinView;
@property (nonatomic, assign) CLLocationCoordinate2D lastLocation;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

@property (nonatomic, strong) LDRMapTableView *tableView;
@property (nonatomic, strong) UIView *tableBackView;
@property (nonatomic, strong) LDRMapScrollView *scrollView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIImageView *navigationImageView;

@property (nonatomic) NSInteger selectedIndex;
@end

@implementation LDRMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AMapServices sharedServices].apiKey = mapAppKey;
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    self.searchAPI = [[AMapSearchAPI alloc] init];
    self.searchAPI.delegate = self;
    [self scrollView];
    [self searchBar];
    [self mapView];
    [self tableView];
    [self navigationImageView];
    [self configLocationManager];
    [self creatPinView];
    
    LDRWeakify(self);
    self.tableView.mj_header = [LDRRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.selectedIndex = 0;
    }];
}
-(void)configLocationManager {

    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //设置不允许系统暂停定位
//    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    //设置允许在后台定位
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    //设置定位超时时间
    [self.locationManager setLocationTimeout:15];
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:15];
    //设置开启虚拟定位风险监测，可以根据需要开启
//    [self.locationManager setDetectRiskOfFakeLocation:NO];
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:nil];
    [self.mapView setZoomLevel:17.5];
    LDRWeakify(self);
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        weakSelf.location = location;
        // 停止定位
        [weakSelf.locationManager stopUpdatingLocation];
        // 发起周边搜索
        [weakSelf searchAround];
    }];
}
#pragma mark--创建大头针
- (void)creatPinView
{
    self.pinView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    self.pinView.image = [UIImage imageNamed:@"map_loaction"];
    self.pinView.center = CGPointMake(self.mapView.frame.size.width * 0.5, (self.mapView.frame.size.height ) * 0.5);
    self.pinView.hidden = NO;
    [self.mapView addSubview:self.pinView];
}
- (void)searchAround
{
    // 初始化搜索
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
    request.types = searchType;
    request.sortrule = 0;
    request.requireExtension = YES;
    NSLog(@"周边搜索");
    //发起周边搜索
    [self.tableView.mj_header beginRefreshing];
    [self.searchAPI AMapPOIAroundSearch:request];
}
#pragma mark--移动地图的时候点击事件
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    if (!wasUserAction) {
        return;
    }
    CGPoint center = CGPointMake(self.mapView.bounds.size.width * 0.5, self.mapView.bounds.size.height * 0.5);
    CLLocationCoordinate2D coor2d = [mapView convertPoint:center toCoordinateFromView:self.mapView];
    self.lastLocation = coor2d;
    
    // ReGEO解析
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:coor2d.latitude longitude:coor2d.longitude];
    [self.searchAPI AMapReGoecodeSearch:request];
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *requests = [[AMapPOIAroundSearchRequest alloc] init];
    requests.location = [AMapGeoPoint locationWithLatitude:coor2d.latitude longitude:coor2d.longitude];
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    requests.types = searchType;
    requests.sortrule = 0;
    requests.requireExtension = YES;
    NSLog(@"周边再次搜索");
    //发起周边搜索
    [self.tableView.mj_header beginRefreshing];
    [self.searchAPI AMapPOIAroundSearch:requests];
    
}
#pragma mark--实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    NSLog(@"周边搜索回调");
    [self.tableView.mj_header endRefreshing];
    self.addressArray = [NSMutableArray arrayWithArray:response.pois];
    [self.tableView reloadData];
//    if(response.pois.count == 0) {
//        return;
//    }
}

#pragma mark - UISearchBarDelegate

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
//    request.keywords = searchBar.text;
//    [self.searchAPI AMapPOIKeywordsSearch:request];
//}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView.mj_header beginRefreshing];
    [searchBar resignFirstResponder];
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.types = searchType;
    request.sortrule = 0;
    request.requireExtension = YES;
    request.keywords = searchBar.text;
    [self.searchAPI AMapPOIKeywordsSearch:request];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.scrollView setContentOffset:CGPointMake(0, LDR_HEIGHT/2.0f) animated:YES];
}
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    searchBar.text = @"";
//    [searchBar becomeFirstResponder];
//    [self.mapView setCenterCoordinate:self.location.coordinate animated:YES];
//    [self searchAround];
//}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.addressArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRMapAddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRMapAddressTableCell class])];
    AMapPOI *poi = [self.addressArray objectAtIndex:indexPath.row];
    cell.addessString = poi.name;
    cell.road = poi.address;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:poi.location.latitude longitude:poi.location.longitude];
    CLLocationDistance meters=[self.location distanceFromLocation:location];
    cell.distance = meters;
    cell.selected = self.selectedIndex == indexPath.row;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapPOI *poi = [self.addressArray objectAtIndex:indexPath.row];
    CLLocationCoordinate2D coor2d = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
    [self.mapView setCenterCoordinate:coor2d animated:YES];
    self.selectedIndex = indexPath.row;
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
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat scrollViewMaxY = LDR_HEIGHT/2.0f;
        if (scrollView.tag == 102) {
            if (scrollView.contentOffset.y >=  scrollViewMaxY) {
                scrollView.contentOffset = CGPointMake(0, scrollViewMaxY);
                self.tableView.canScroll = YES;
            } else {
//                if (!self.tableView.isCanScroll) {
//                    self.tableView.contentOffset = CGPointZero;
//                }
                if (self.tableView.contentOffset.y <= 0) {
                    self.tableView.canScroll = NO;
                    self.tableView.contentOffset = CGPointZero;
                }
            }
            
            self.mapView.frame = CGRectMake(0, 0, LDR_WIDTH, (LDR_HEIGHT / 2.0 + KNavBarAndStatusBarHeight + topHeight) - scrollView.contentOffset.y);
            self.pinView.center = CGPointMake(self.mapView.frame.size.width * 0.5, (self.mapView.frame.size.height ) * 0.5);
            CGFloat top = 44 * scrollView.contentOffset.y / (LDR_HEIGHT/2.0f);
            self.searchBar.frame = CGRectMake(0, top+8, LDR_WIDTH, searchBarHeight);
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tableBackView.mas_top).mas_offset(searchBarHeight+top+LDRPadding);
            }];
        } else {
            if (scrollView.contentOffset.y <= 0) {
                self.tableView.canScroll = NO;
//                scrollView.contentOffset = CGPointZero;
            } else {
                if (self.tableView.isCanScroll) {
                    self.scrollView.contentOffset = CGPointMake(0, scrollViewMaxY);
                } else {
                    scrollView.contentOffset = CGPointZero;
                }
            }
        }
    });
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if (scrollView.tag == 102) {
//        NSLog(@"--%f",scrollView.contentOffset.y);
//        if (scrollView.contentOffset.y == 0) {
//            /* 滚动指定段的指定row  到 指定位置*/
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//        }
//    }
}
- (void)closeAddress:(UIButton *)sender
{
    [self.searchBar resignFirstResponder];
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    [self.tableView setContentOffset:CGPointZero animated:YES];
    self.tableView.canScroll = NO;
}
#pragma mark - Getter
- (LDRMapTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[LDRMapTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.tableBackView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.tableBackView).insets(UIEdgeInsetsZero);
            make.top.equalTo(self.tableBackView.mas_top).mas_offset(searchBarHeight+LDRPadding);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableView.tableHeaderView = view;
        _tableView.backgroundColor = LDR_BackgroundColor;
        _tableView.tag = 101;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.canScroll = NO;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRMapAddressTableCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRMapAddressTableCell class])];
    }
    return _tableView;
}
- (UIView *)tableBackView
{
    if (!_tableBackView) {
        _tableBackView = [[UIView alloc] init];
        [self.scrollView addSubview:_tableBackView];
        _tableBackView.frame = CGRectMake(0, LDR_HEIGHT/2.0f, LDR_WIDTH, LDR_HEIGHT - topHeight - KNavBarAndStatusBarHeight);
        
        [_tableBackView setBackgroundColor:LDR_BackgroundColor];
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(closeAddress:)];
        [_tableBackView insertSubview:button atIndex:0];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableBackView.mas_top).mas_offset(LDRPadding);
            make.centerX.equalTo(_tableBackView);
            make.width.mas_equalTo(58);
            make.height.mas_equalTo(28);
        }];
//        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"map_down"] forState:UIControlStateNormal];
        [_tableBackView.layer setCornerRadius:12.0f];
        [_tableBackView setClipsToBounds:YES];
    }
    return _tableBackView;
}
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        [self.tableBackView addSubview:_searchBar];
        _searchBar.frame = CGRectMake(0, 8, LDR_WIDTH, searchBarHeight);
        UIImageView *barImageView = [[[_searchBar.subviews firstObject] subviews] firstObject];
        barImageView.layer.borderColor = LDR_BackgroundColor.CGColor;
        barImageView.layer.borderWidth = 1;
        _searchBar.delegate = self;
        [_searchBar setPlaceholder:@"搜索地点"];
    }
    return _searchBar;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[LDRMapScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(KNavBarAndStatusBarHeight + topHeight, 0, 0, 0));
        }];
        [_scrollView setContentSize:CGSizeMake(LDR_WIDTH, LDR_HEIGHT/2.0f + (LDR_HEIGHT - topHeight - KNavBarAndStatusBarHeight))];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.tag = 102;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (MAMapView *)mapView
{
    if (!_mapView) {
        ///初始化地图
        MAMapView *mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, LDR_WIDTH, LDR_HEIGHT / 2.0 + topHeight + KNavBarAndStatusBarHeight)];//
        ///把地图添加至view
        [self.view addSubview:mapView];
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        mapView.showsUserLocation = YES;
        mapView.userTrackingMode = MAUserTrackingModeFollow;
        mapView.delegate = self;
        mapView.mapType = MAMapTypeStandard;
        mapView.showsCompass = NO;
        mapView.showsScale = NO;
        _mapView = mapView;
    }
    return _mapView;
}
- (UIImageView *)navigationImageView
{
    if (!_navigationImageView) {
        _navigationImageView = [[UIImageView alloc] init];
        [self.view insertSubview:_navigationImageView aboveSubview:self.mapView];
        [_navigationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(topHeight+KNavBarAndStatusBarHeight);
        }];
        [_navigationImageView setImage:[UIImage imageNamed:@"map_navigation"]];
        UIButton *cancelButton = [UIButton buttonWithTarget:self action:@selector(cancelAction:)];
        [self.view insertSubview:cancelButton aboveSubview:_navigationImageView];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).mas_offset(LDRPadding);
            make.top.equalTo(self.view.mas_top).mas_offset(KStatusHeight+LDRPadding);
        }];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:LDR_BackgroundColor forState:UIControlStateNormal];
        
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction:)];
        [self.view insertSubview:button aboveSubview:_navigationImageView];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).mas_offset(-LDRPadding);
            make.top.equalTo(self.view.mas_top).mas_offset(KStatusHeight+LDRPadding);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(34);
        }];
        [button setTitle:@"确定" forState:UIControlStateNormal];
    }
    return _navigationImageView;
}
- (void)cancelAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)buttonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectedAddress:)]) {
        [self.delegate didSelectedAddress:self.addressArray[self.selectedIndex]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
