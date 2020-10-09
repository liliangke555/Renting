//
//  LDRMessageNotificationController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMessageNotificationController.h"
#import "LDRSegment.h"
#import "LDRWatchingHouseController.h"
#import "LDRCallPoliceNotificationController.h"
#import "LDRCallNoticeController.h"
@interface LDRMessageNotificationController ()<UIScrollViewDelegate>
@property (nonatomic, strong) LDRSegment *segment;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) LDRWatchingHouseController *watchingHouse;
@property (nonatomic, strong) LDRCallPoliceNotificationController *callOfPolice;
@property (nonatomic, strong) LDRCallNoticeController *callNotice;

@end

@implementation LDRMessageNotificationController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor]];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息通知";
    [self scrollView];
    
    self.watchingHouse = [[LDRWatchingHouseController alloc] init];
    [self addChildViewController:self.watchingHouse];
    [self.scrollView addSubview:self.watchingHouse.view];
    
    self.callOfPolice = [[LDRCallPoliceNotificationController alloc] init];
    [self addChildViewController:self.callOfPolice];
    [self.scrollView addSubview:self.callOfPolice.view];
    
    self.callNotice = [[LDRCallNoticeController alloc] init];
    [self addChildViewController:self.callNotice];
    [self.scrollView addSubview:self.callNotice.view];
    
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.segment.contentOffX = scrollView.contentOffset.x / LDR_WIDTH;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //ScrollView中根据滚动距离来判断当前页数
    int page = (int)scrollView.contentOffset.x/LDR_WIDTH;
    // 设置页码
    self.segment.selectedIndex = page;
}
#pragma mark - Getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.segment.mas_bottom);
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        [_scrollView setContentSize:CGSizeMake(3*LDR_WIDTH, 0)];
        _scrollView.delegate =self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
- (LDRSegment *)segment
{
    if (!_segment) {
        _segment = [LDRSegment segmentWithTitles:@[@"看房通知",@"报警通知",@"催缴记录"]];
        [self.view addSubview:_segment];
        [_segment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(62);
        }];
        LDRWeakify(self);
        [_segment setDidChengeSelected:^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(index * LDR_WIDTH, 0) animated:YES];
        }];
    }
    return _segment;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.watchingHouse.view.frame = CGRectMake(0, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
    self.callOfPolice.view.frame = CGRectMake(LDR_WIDTH, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
    self.callNotice.view.frame = CGRectMake(LDR_WIDTH * 2, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
}
@end
