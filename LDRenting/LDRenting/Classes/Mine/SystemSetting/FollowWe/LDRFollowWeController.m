//
//  LDRFollowWeController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRFollowWeController.h"

@interface LDRFollowWeController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LDRFollowWeController


- (void)viewDidLoad {
    self.whiteBack = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关注公众号";
    UIImageView *backImageView = [[UIImageView alloc] init];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [backImageView setImage:[UIImage imageNamed:@"follow_background"]];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(20+KNavBarAndStatusBarHeight);
//        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
//    }];
    imageView.frame = CGRectMake(0, 0, LDR_WIDTH, 566);
    [imageView setImage:[UIImage imageNamed:@"follow_qrcode"]];
    [imageView setContentMode:UIViewContentModeCenter];
    self.imageView = imageView;
    
    UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, LDRPadding + KBottomSafeHeight, 40));
        make.height.mas_equalTo(LDRButtonHeight);
    }];
    [button setTitle:@"保存二维码" forState:UIControlStateNormal];
}
- (void)buttonAction
{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
        [LDRHUD showHUDWithMessage:@"保存失败"];
    }else{
        msg = @"保存图片成功" ;
        [LDRHUD showSuccessfulWithMessage:@"保存成功" view:self.view];
    }
}
#pragma mark - Getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(KNavBarAndStatusBarHeight, 0, LDRPadding + KBottomSafeHeight + LDRButtonHeight +LDRPadding, 0));
        }];
        [_scrollView setContentSize:CGSizeMake(0, 566)];
    }
    return _scrollView;
}

@end
