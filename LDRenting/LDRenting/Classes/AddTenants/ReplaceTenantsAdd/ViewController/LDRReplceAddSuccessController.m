//
//  LDRReplceAddSuccessController.m
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRReplceAddSuccessController.h"
#import "LDRAddTenantsController.h"
#import "LDRRenantsInfomationController.h"
static CGFloat const bottomLayout = 107.0f;
@interface LDRReplceAddSuccessController ()
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LDRReplceAddSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"邀请租客";
    [self bottomView];
}
#pragma mark - IBAction
- (void)mianButtonAction:(UIButton *)sender
{
    LDRRenantsInfomationController *vc = [[LDRRenantsInfomationController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)backAction:(UIButton *)sender
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LDRAddTenantsController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"successful_icon"];
}
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"租客添加成功";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRBoldFont18,
        NSForegroundColorAttributeName:LDR_TextBalckColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
// MARK: 空白页显示详细描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"去设置租客的开门权限吧";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont12,
        NSForegroundColorAttributeName:LDR_TextGrayColor,
        NSParagraphStyleAttributeName:paragraph
    };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
#pragma mark - Getter
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        [_bottomView setBackgroundColor:LDR_BackgroundColor];
        
        UIButton *mainButton = [UIButton mainButtonWithTarget:self action:@selector(mianButtonAction:)];
        [_bottomView addSubview:mainButton];
        [mainButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_bottomView).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [mainButton setTitle:@"设置开门权限" forState:UIControlStateNormal];
        
        UIButton *button = [UIButton viceButtonWithTarget:self action:@selector(backAction:)];
        [_bottomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mainButton.mas_bottom).mas_offset(25);
            make.left.right.bottom.equalTo(_bottomView).insets(UIEdgeInsetsMake(0, LDRPadding, bottomLayout+KBottomSafeHeight, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [button setTitle:@"返回" forState:UIControlStateNormal];
    }
    return _bottomView;
}
- (void)viewDidLayoutSubviews
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

@end
