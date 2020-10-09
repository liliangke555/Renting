//
//  LDRCreateHouseGuideController.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCreateHouseGuideController.h"
#import "LDRCreateHouseInfoController.h"
static CGFloat const imageHeight = 698;
static CGFloat const bottomHeight = 80;
@interface LDRCreateHouseGuideController ()
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageBckView;
@end

@implementation LDRCreateHouseGuideController

- (void)viewDidLoad {
    self.whiteBack = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHex:0x2A313AFF]];
    [self buttonView];
    [self imageBckView];
    
}
#pragma mark - IBAction
- (void)nextStepAction:(UIButton *)sender
{
    LDRCreateHouseInfoController *vc = [[LDRCreateHouseInfoController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Getter
- (UIView *)imageBckView
{
    if (!_imageBckView) {
        _imageBckView = [[UIView alloc] init];
        [self.scrollView addSubview:_imageBckView];
        _imageBckView.frame = CGRectMake(0, 0, LDR_WIDTH, imageHeight);
        UIImageView *topImage = [[UIImageView alloc] init];
        [_imageBckView addSubview:topImage];
        [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageBckView.mas_top).mas_offset(KTopBarSafeHeight);
            make.centerX.equalTo(_imageBckView);
            make.width.mas_equalTo(LDR_WIDTH);
        }];
        [topImage setContentMode:UIViewContentModeCenter];
        [topImage setImage:[UIImage imageNamed:@"create_house_guide"]];
        
        UIImageView *bottomImage = [[UIImageView alloc] init];
        [_imageBckView addSubview:bottomImage];
        [bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topImage.mas_bottom);
            make.centerX.equalTo(_imageBckView);
            make.width.mas_equalTo(LDR_WIDTH);
            make.bottom.equalTo(_imageBckView.mas_bottom);
        }];
        [bottomImage setContentMode:UIViewContentModeCenter];
        [bottomImage setImage:[UIImage imageNamed:@"create_house_guide2"]];
    }
    return _imageBckView;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            if ((LDR_HEIGHT - bottomHeight-KBottomSafeHeight - KStatusBarHeight) > imageHeight) {
                make.height.mas_equalTo(imageHeight);
            } else {
                make.bottom.equalTo(self.view.mas_bottom).mas_offset(-bottomHeight-KBottomSafeHeight);
            }
        }];
        [_scrollView setContentSize:CGSizeMake(0, imageHeight)];
    }
    return _scrollView;
}
- (UIView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[UIView alloc] init];
        [_buttonView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_buttonView];
        [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(nextStepAction:)];
        [_buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_buttonView.mas_top).mas_offset(LDRPadding);
            make.left.right.equalTo(_buttonView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [button setTitle:LDRButtonNextStep forState:UIControlStateNormal];
    }
    return _buttonView;
}
@end
