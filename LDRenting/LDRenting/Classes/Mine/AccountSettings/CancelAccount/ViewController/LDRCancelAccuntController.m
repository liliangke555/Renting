//
//  LDRCancelAccuntController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCancelAccuntController.h"

@interface LDRCancelAccuntController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation LDRCancelAccuntController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账号注销";
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.topMargin.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.button.mas_top).mas_equalTo(-LDRPadding);
    }];
}
- (void)buttonAction:(UIButton *)sender
{
    
}
#pragma mark - DZNEmptyDataSetSource

// MARK: 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_warnning"];
}

// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"将173****6595所绑定的账号注销";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRBoldFont18,
        NSForegroundColorAttributeName:LDR_TextBalckColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
// MARK: 空白页显示详细描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"注意，注销后账号所有信息将无法恢复";
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
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64.f;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 32.0f;
}
#pragma mark - Getter
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton viceButtonWithTarget:self action:@selector(buttonAction:)];
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, LDRPadding, LDRPadding + KBottomSafeHeight, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [_button setTitleColor:[UIColor colorWithHex:0xF25441FF] forState:UIControlStateNormal];
        [_button setTitle:@"确认注销" forState:UIControlStateNormal];
    }
    return _button;
}
@end
