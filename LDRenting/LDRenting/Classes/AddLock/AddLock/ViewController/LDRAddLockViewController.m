//
//  LDRAddLockViewController.m
//  LDRenting
//
//  Created by MAC on 2020/7/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddLockViewController.h"
#import "LDRAddLockShowHowController.h"
#import "LDRAddLockSuccessController.h"

static CGFloat const imageWidth = 372;
static CGFloat const imageHeight = 578;
static CGFloat const bottomHeight = 160;
static CGFloat const topHeight = 22;
@interface LDRAddLockViewController ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation LDRAddLockViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    self.whiteBack = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHex:0x212A35FF]];
    [self.backImageView setImage:[UIImage imageNamed:@"addlock_background"]];
    [self buttonView];
}
#pragma mark -
- (void)showMiniView
{
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 1) {
        }
    };
    NSArray *items =@[MMItemMake(LDRAlterCancle, MMItemTypeNormal, block),
                      MMItemMake(LDRAlterYes, MMItemTypeNormal, block)];
    LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:LDRAlterTitleMiniPragma
                                                         detail:LDRAlterDetailsMiniPragma
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alertView show];
}
#pragma mark - IBAction
- (void)buyNowButtonAction:(UIButton *)sender
{
//    [self showMiniView];
    
    LDRAddLockSuccessController *vc = [[LDRAddLockSuccessController alloc] init];
    vc.houseName = @"是因为他";
    vc.userHouseRelationId = @"45989817538383872";
    vc.macString = @"D818432DACE0";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addButtonAction:(UIButton *)sender
{
    LDRAddLockShowHowController *vc = [[LDRAddLockShowHowController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - SetupView

#pragma mark - Getter

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).mas_offset(topHeight+KStatusBarHeight);
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            if ((LDR_HEIGHT - bottomHeight-KBottomSafeHeight - topHeight - KStatusBarHeight) > imageHeight) {
                make.height.mas_equalTo(imageHeight);
            } else {
                make.bottom.equalTo(self.view.mas_bottom).mas_offset(-bottomHeight-KBottomSafeHeight);
            }
        }];
        [_scrollView setContentSize:CGSizeMake(0, imageHeight)];
    }
    return _scrollView;
}

- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.centerX.equalTo(self.scrollView);
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageHeight);
        }];
        [_backImageView setContentMode:UIViewContentModeCenter];
    }
    return _backImageView;
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
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(buyNowButtonAction:)];
        [_buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_buttonView.mas_top).mas_offset(topHeight);
            make.left.right.equalTo(_buttonView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [button setTitle:LDRButtonBuyNow forState:UIControlStateNormal];
        
        UIButton *viceButton = [UIButton viceButtonWithTarget:self action:@selector(addButtonAction:)];
        [_buttonView addSubview:viceButton];
        [viceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_bottom).mas_offset(LDRPadding);
            make.left.right.equalTo(_buttonView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [viceButton setTitle:LDRButtonHaveAddNow forState:UIControlStateNormal];
    }
    return _buttonView;
}

@end
