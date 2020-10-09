//
//  LDRRefreshFooter.m
//  LDRenting
//
//  Created by MAC on 2020/8/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRefreshFooter.h"
#import <Lottie/Lottie.h>
@interface LDRRefreshFooter()
@property (weak, nonatomic) LOTAnimationView *loading;
@property (weak, nonatomic) UILabel *tipLabel;
@end
@implementation LDRRefreshFooter

#pragma mark - 重写方法
- (void)prepare{
    [super prepare];
    // 设置控件的高度
    self.mj_h = 50;
    LOTAnimationView *loading = [LOTAnimationView animationWithFilePath:[[NSBundle mainBundle] pathForResource:@"lf20_RZPIuU" ofType:@"json"]];
    loading.loopAnimation = YES;
    loading.animationSpeed = 1.0f;
    [self addSubview:loading];
    self.loading = loading;
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = LDR_TextGrayColor;
    tipLabel.font = LDRFont16;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews{
    [super placeSubviews];
    self.tipLabel.frame = self.bounds;
    self.loading.frame = CGRectMake(0, 0, 30, 30);
    self.loading.center = CGPointMake(self.mj_w/2, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];

}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];

}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
            self.tipLabel.text = @"";
            [self.loading stop];
            break;
        case MJRefreshStateRefreshing:
            self.tipLabel.text = @"";
            [self.loading play];
            break;
        case MJRefreshStateNoMoreData:
            self.tipLabel.text = @"到底了～";
            [self.loading stop];
            break;
        default:
            break;
    }
}


@end
