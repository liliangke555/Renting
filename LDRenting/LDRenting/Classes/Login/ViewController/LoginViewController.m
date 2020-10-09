//
//  LoginViewController.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LoginViewController.h"
#import "LDRLoginTextField.h"
#import "LDRCodeResignView.h"
#import "LDRBindPhoneViewController.h"
#import "LDRSliderAlertView.h"
#import "LDRSliderVerifyRequest.h"
#import "LDRPhoneCodeLoginRequest.h"


static NSInteger const maxSecond = 60;
@interface LoginViewController ()<LDRLoginTextFieldDelegate>

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *phoneDetailLabel;
@property (nonatomic, strong) LDRLoginTextField *textField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *changeButton;

@property (nonatomic, strong) UIButton *agreementButton;
@property (nonatomic, strong) LDRCodeResignView *codeView;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:true];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setTranslucent:false];
    [self removeTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"login_back"] action:@selector(backAction:)];
    [self setupView];
    __weak typeof(self)weakSelf = self;
    [self.codeView setCodeResignCompleted:^(NSString * _Nonnull content) {
        NSLog(@"--- %@",content);
        [weakSelf codeLoginwithCode:content];
    }];
    [self.codeView setCodeResignUnCompleted:^(NSString * _Nonnull content) {
        NSLog(@"--un- %@",content);
    }];
//    [self setLoginType:_loginType];
    if (self.loginType == LDRLoginTypePhoneNumber) {
        [self.loginButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.phoneDetailLabel setText:@"未注册手机验证后自动创建登录"];
        [self.phoneLabel setText:@"手机号验证登录"];
        [self.agreementButton setAttributedTitle:[@"登录注册代表同意《360租房用户使用协协议》、《隐私政策》" getPriceAttribute]
        forState:UIControlStateNormal];
        self.loginButton.enabled = NO;
    } else {
        [self.loginButton setTitle:@"同意协议并一键登录" forState:UIControlStateNormal];
        [self.phoneDetailLabel setText:@"未注册手机验证后自动创建登录"];
        [self.phoneLabel setText:@"手机号验证登录"];
        [self.agreementButton setAttributedTitle:[@"登录注册代表同意《中国移动认证服务条款》、《360租房用户使用协协议》、《隐私政策》" getPriceAttribute]
                                        forState:UIControlStateNormal];
        self.loginButton.enabled = YES;
    }
    if (self.loginType == LDRLoginTypeCode) {
        [self didVerificationCode:self.loginButton];
    }
    
    if (self.loginType == LDRLoginTypeOneClick) {
    }
}
#pragma mark - IBAction
/// 返回按钮事件
/// @param sender button
- (void)backAction:(UIButton *)sender
{
    if ([self.navigationController.viewControllers count] <= 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/// 登录按钮事件
/// @param sender button
- (void)loginButtonAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (self.loginType == LDRLoginTypePhoneNumber) {
        NSString *phone = [self.textField.text removeSpaceAndNewline];
        if (![phone isMobileNumber]) {
            [LDRHUD showHUDWithMessage:@"请输入正确的手机号" toView:self.view];
            return;
        }
        [self showSliderAlert];
        
    }  else if (self.loginType == LDRLoginTypeOneClick) {
        

    }
}
/// 更换为 手机号验证登录按钮事件
/// @param sender button
- (void)changeButtonAction:(UIButton *)sender
{
//    self.loginType = ;
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.loginType = LDRLoginTypePhoneNumber;
    [self.navigationController pushViewController:vc animated:YES];
}
/// 用户协议按钮事件
/// @param sender button
- (void)agreementButtonAction:(UIButton *)sender
{
    
}
/// 苹果登录按钮事件
/// @param sender button
- (void)appleButtonAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self.navigationController pushViewController:[LDRBindPhoneViewController new] animated:YES];
}

/// 微信登录按钮事件
/// @param sender button
- (void)wechatButtonAction:(UIButton *)sender
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatSuccess:) name:LDRWechatLoginSuccess object:nil];
    [self.view endEditing:YES];
//    [self.navigationController pushViewController:[LDRBindPhoneViewController new] animated:YES];
//    [self sendWXAuthReq];
}

#pragma mark - NEtworking
- (void)codeLoginwithCode:(NSString *)code
{
    [self.view endEditing:YES];
    LDRWeakify(self);
    [LDRHUD showLoadingInView:self.view];
    LDRPhoneCodeLoginRequest *request = [LDRPhoneCodeLoginRequest new];
    request.phoneNumber = self.phoneNember;
    request.verificationCode = code;
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        LDRLoginSuccessModel *model = response.data;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:model.accessToken forKey:LDRSessionId];
        [user setObject:@YES forKey:LDRLoginState];
        [user synchronize];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        });
        [LDRHUD hideHUDForView:weakSelf.view];
    } failHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
    }];
}
- (void)sliderVerifyWithData:(NSDictionary *)data
{
    [LDRHUD showLoadingInView:self.view];
    NSString *phone = [self.textField.text removeSpaceAndNewline];
    LDRSliderVerifyRequest *request = [LDRSliderVerifyRequest new];
    request.appKey = LDRAliSliderKey;
    request.scene = LDRAliSliderScene;
    request.phoneNumber = phone;
    request.sessionId = data[@"csessionid"];
    request.sig = data[@"sig"];
    request.token = data[@"nc_token"];
    request.slideUsage = 1;
    LDRWeakify(self);
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.phoneNember = phone;
        vc.loginType = LDRLoginTypeCode;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } failHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
    }];
}
#pragma mark - Private

- (void)showSliderAlert
{
    LDRWeakify(self);
    [LDRHUD showLoadingInView:self.view];
    LDRSliderAlertView *alertView = [[LDRSliderAlertView alloc] init];
    [alertView setDidSuccessCallBack:^(NSDictionary * _Nonnull dic) {
        [weakSelf sliderVerifyWithData:dic];
    }];
    alertView.showCompletionBlock = ^(LDRPopupView * _Nonnull popView, BOOL isShow) {
        if (isShow) {
            [LDRHUD hideHUDForView:weakSelf.view];
            [MMPopupWindow sharedWindow].touchWildToHide = YES;
        }
    };
    alertView.hideCompletionBlock = ^(LDRPopupView * _Nonnull popView, BOOL isHide) {
        [LDRHUD hideHUDForView:weakSelf.view];
        [MMPopupWindow sharedWindow].touchWildToHide = NO;
    };
}
/// 点击获取验证码事件
/// @param sender button
- (void)didVerificationCode:(UIButton *)sender
{
    if (sender.isSelected) {
        [sender setTitleColor:LDR_TextLightGrayColor forState:UIControlStateSelected];
        [self startTimer];
        return;
    }

    [sender setTitleColor:LDR_TextLightGrayColor forState:UIControlStateSelected];
    sender.selected = !sender.isSelected;
    [self startTimer];
}
/// 倒计时结束 后
- (void)timerEnd
{
    self.textField.alpha = 0.0f;
    self.textField.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.codeView.alpha = 0.0f;
        self.textField.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.codeView.hidden = YES;
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.selected = NO;
        [self.loginButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeView removeText];
        self.codeView.hidden = YES;
    }];
}
/// 开始倒计时
- (void)startTimer
{
    __block NSInteger second = maxSecond;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
//                [self timerEnd];
                [self.loginButton setTitle:@"重新获验证码" forState:UIControlStateSelected];
                [self.loginButton setTitleColor:LDR_MainGreenColor forState:UIControlStateSelected];
                dispatch_cancel(timer);
            } else {
                [self.loginButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获验证码",second] forState:UIControlStateSelected];
                second --;
            }
        });
    });
    dispatch_resume(timer);
    _timer = timer;
}
- (void)removeTimer
{
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
}
#pragma mark - LDRLoginTextFieldDelegate

- (void)didChangeEditing:(LDRLoginTextField *)textField
{
    self.loginButton.enabled = NO;
}
- (void)didEndEditingCompletion:(LDRLoginTextField *)textField
{
    self.loginButton.enabled = YES;
}

#pragma mark - Setter


#pragma mark - SetupView

/// 设置界面UI
- (void)setupView
{
    //背景图片
    UIImageView *backImageView = [[UIImageView alloc] init];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [backImageView setImage:[UIImage imageNamed:LDRLoginBackIcon]];
    
    MASViewAttribute *lastAttribute = self.view.mas_top;
    
    //欢迎语
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        if (KIs_iPhoneX) {
            make.top.equalTo(lastAttribute).mas_offset(16 + 88);
        } else {
            make.top.equalTo(lastAttribute).mas_offset(16 + 64);
        }
        make.left.right.equalTo(self.view);
    }];
    [label setFont:LDRBoldFont24];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"欢迎登录360租房"];
    [label setTextColor:LDR_TextBalckColor];
    lastAttribute = label.mas_bottom;
    
    // headerImageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastAttribute).mas_offset(40);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(80);
    }];
    [imageView setImage:[UIImage imageNamed:@"login_header"]];
    [imageView.layer setCornerRadius:40];
    [imageView setClipsToBounds:YES];
    lastAttribute = imageView.mas_bottom;
    
    // 手机号 Label
    UILabel *phoneLabel = [[UILabel alloc] init];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastAttribute).mas_offset(16);
        make.left.right.equalTo(self.view);
    }];
    [phoneLabel setFont:LDRBoldFont20];
    [phoneLabel setTextAlignment:NSTextAlignmentCenter];
    self.phoneLabel = phoneLabel;
    [phoneLabel setTextColor:LDR_TextBalckColor];
    lastAttribute = phoneLabel.mas_bottom;
    
    // 手机号说明 label
    UILabel *phoneDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:phoneDetailLabel];
    [phoneDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastAttribute).mas_offset(8);
        make.left.right.equalTo(self.view);
    }];
    [phoneDetailLabel setFont:LDRFont12];
    [phoneDetailLabel setTextAlignment:NSTextAlignmentCenter];
    self.phoneDetailLabel = phoneDetailLabel;
    [phoneDetailLabel setTextColor:LDR_TextGrayColor];
    lastAttribute = phoneDetailLabel.mas_bottom;

    if (self.loginType == LDRLoginTypePhoneNumber) {
        //手机号输入框
        LDRLoginTextField *textField = [[LDRLoginTextField alloc] init];
        [self.view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
            make.top.equalTo(lastAttribute).mas_offset(30);
            make.height.mas_equalTo(48);
        }];
//        textField.hidden = YES;
        self.textField = textField;
        [textField setFont:LDRFont16];
        textField.ldrDelegate = self;
        [textField setKeyboardType:UIKeyboardTypePhonePad];
        textField.placeholder = @"请输入手机号";
        lastAttribute = textField.mas_bottom;
    }
    if (self.loginType == LDRLoginTypeCode) {
        LDRCodeResignView *codeView = [[LDRCodeResignView alloc] initWithCodeBits:6];
        [self.view addSubview:codeView];
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
            make.top.equalTo(lastAttribute).mas_offset(30);
            make.height.mas_equalTo(48);
        }];
        self.codeView = codeView;
        lastAttribute = codeView.mas_bottom;
    }
    
    
    UIButton *loginButton = [UIButton buttonWithTarget:self action:@selector(loginButtonAction:)];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastAttribute).mas_offset(24);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
        make.height.mas_equalTo(48);
    }];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_TextLightGrayColor] forState:UIControlStateHighlighted];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenColor] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_GrayColor] forState:UIControlStateSelected];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:LDRFont14];
    [loginButton setTitle:@"同意协议并一键登录" forState:UIControlStateNormal];
    [loginButton.layer setCornerRadius:LDRRadius];
    [loginButton setClipsToBounds:YES];
    self.loginButton = loginButton;
    loginButton.enabled = YES;
    lastAttribute = loginButton.mas_bottom;
    
    if (self.loginType != LDRLoginTypePhoneNumber && self.loginType != LDRLoginTypeCode) {
        UIButton *changeButton = [UIButton buttonWithTarget:self action:@selector(changeButtonAction:)];
        [self.view addSubview:changeButton];
        [changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
            make.top.equalTo(lastAttribute).mas_offset(24);
            make.height.mas_equalTo(48);
        }];
        [changeButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_GrayColor] forState:UIControlStateNormal];
        [changeButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateHighlighted];
        [changeButton setTitleColor:LDR_TextDarkGrayColor forState:UIControlStateNormal];
        [changeButton.titleLabel setFont:LDRFont14];
        [changeButton setTitle:@"更换手机号登录" forState:UIControlStateNormal];
        [changeButton.layer setCornerRadius:LDRRadius];
        [changeButton setClipsToBounds:YES];
        self.changeButton = changeButton;
        lastAttribute = changeButton.mas_bottom;
    }
    
    UIButton *agreementButton = [UIButton buttonWithTarget:self action:@selector(agreementButtonAction:)];
    [self.view addSubview:agreementButton];
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
        make.top.equalTo(lastAttribute).mas_offset(32);
        make.height.mas_equalTo(40);
    }];
    [agreementButton.titleLabel setFont:LDRFont12];
    [agreementButton.titleLabel setNumberOfLines:0];
    [agreementButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [agreementButton setAttributedTitle:[@"登录注册代表同意《360租房用户使用协议》、《隐私政策》" getPriceAttribute] forState:UIControlStateNormal];
    self.agreementButton = agreementButton;
    
    if (self.loginType == LDRLoginTypePhoneNumber) {
        UIButton *wechatButton = [UIButton buttonWithTarget:self action:@selector(wechatButtonAction:)];
        [self.view addSubview:wechatButton];
        [wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).mas_offset(-74);
            make.right.equalTo(self.view.mas_centerX).mas_offset(-8);
            make.width.height.mas_equalTo(40);
        }];
        [wechatButton setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
        
        UIButton *appleButton = [UIButton buttonWithTarget:self action:@selector(appleButtonAction:)];
        [self.view addSubview:appleButton];
        [appleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).mas_offset(-74);
            make.left.equalTo(self.view.mas_centerX).mas_offset(8);
            make.width.height.mas_equalTo(40);
        }];
        [appleButton setImage:[UIImage imageNamed:@"login_apple"] forState:UIControlStateNormal];
    }
}
#pragma mark - Layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
-(void)dealloc
{
    NSLog(@"--%@--销毁",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LDRWechatLoginSuccess object:self];
}
@end
