//
//  LDRLockRecordController.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockRecordController.h"
#import "LDRSegment.h"
#import "LDROpenDoorRecordController.h"
#import "LDRNotificationRecordController.h"
#import "LDRCallPoliceRecordController.h"
@interface LDRLockRecordController ()<UIScrollViewDelegate>
@property (nonatomic, strong) LDRSegment *segment;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LDROpenDoorRecordController *openDoor;
@property (nonatomic, strong) LDRNotificationRecordController *notifi;
@property (nonatomic, strong) LDRCallPoliceRecordController *callPolice;
@end

@implementation LDRLockRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHex:0x00000019];
    self.navigationItem.title = @"门锁记录";
    self.openDoor = [[LDROpenDoorRecordController alloc] init];
    
    self.notifi = [[LDRNotificationRecordController alloc] init];
    self.callPolice = [[LDRCallPoliceRecordController alloc] init];
    
    [self addChildViewController:self.openDoor];
    [self.scrollView addSubview:self.openDoor.view];
    [self addChildViewController:self.callPolice];
    [self.scrollView addSubview:self.callPolice.view];
    [self addChildViewController:self.notifi];
    [self.scrollView addSubview:self.notifi.view];
    
    [self scrollView];
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
        _segment = [LDRSegment segmentWithTitles:@[@"开门记录",@"报警记录",@"通知记录"]];
        [self.view addSubview:_segment];
        [_segment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).mas_offset(0.5f);
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
    self.openDoor.view.frame = CGRectMake(0, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
    self.callPolice.view.frame = CGRectMake(LDR_WIDTH, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
    self.notifi.view.frame = CGRectMake(LDR_WIDTH * 2, 0, LDR_WIDTH, CGRectGetHeight(self.scrollView.frame));
}
@end
