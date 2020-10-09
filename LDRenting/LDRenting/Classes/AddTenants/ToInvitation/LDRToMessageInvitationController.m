//
//  LDRToMessageInvitationController.m
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRToMessageInvitationController.h"
#import "LDRAddTenantsController.h"
static CGFloat const bottomLayout = 179.0f;
@interface LDRToMessageInvitationController ()

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation LDRToMessageInvitationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加成功";
}
#pragma mark - IBAction
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
    NSString *title = @"邀请租客";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRBoldFont18,
        NSForegroundColorAttributeName:LDR_TextBalckColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
// MARK: 空白页显示详细描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"系统已自动下发短信至租客，待租客确认\n并激活账号后，您可为租客设置开门权限";
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
        [_bottomView setBackgroundColor:LDR_BackgroundColor];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        UIButton *button = [UIButton viceButtonWithTarget:self action:@selector(backAction:)];
        [_bottomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_bottomView).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
            make.bottom.equalTo(_bottomView.mas_bottom).mas_offset(-bottomLayout-KBottomSafeHeight);
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
