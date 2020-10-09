//
//  LDRBindPhoneViewController.m
//  LDRenting
//
//  Created by MAC on 2020/7/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBindPhoneViewController.h"
#import "LDRLoginTextField.h"
#import "NSString+LDRString.h"

static NSInteger const maxSecond = 60;

@interface LDRBindPhoneViewController ()<LDRLoginTextFieldDelegate>

@property (nonatomic, strong) LDRLoginTextField *textField;
@property (nonatomic, strong) LDRLoginTextField *codeTextField;
@property (nonatomic, strong) UIButton *bindButton;
@property (nonatomic, strong) UIButton *agreementButton;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation LDRBindPhoneViewController

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
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"login_back"] action:@selector(backAction:)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUpView];
}

#pragma mark - IBAction
/// 返回按钮事件
/// @param sender button
- (void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/// 绑定并登录按钮
/// @param sender button
- (void)bindButtonAction:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:LDRLoginState];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 用户协议按钮
/// @param sender button
- (void)agreementButtonAction:(UIButton *)sender
{
    
}

/// 发送验证码按钮
/// @param sender button
- (void)codeButtonAction:(UIButton *)sender
{
    if ([self.textField.text length] <= 0) {
        return;
    }
    [self startTimer];
}
#pragma mark - Private

/// 开始倒计时
- (void)startTimer
{
    self.codeButton.enabled = NO;
    __block NSInteger second = maxSecond;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
//                [self timerEnd];
                [self.codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                [self.codeButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
                self.codeButton.enabled = YES;
                dispatch_cancel(timer);
            } else {
                [self.codeButton setTitle:[NSString stringWithFormat:@"%ld秒",second] forState:UIControlStateDisabled];
                second --;
            }
        });
    });
    dispatch_resume(timer);
    _timer = timer;
}
#pragma mark - LDRLoginTextFieldDelegate
- (void)didChangeEditing:(LDRLoginTextField *)textField
{
    self.bindButton.enabled = NO;
}
- (void)didEndEditingCompletion:(LDRLoginTextField *)textField
{
    if ([self.textField.text length] == 13 && [self.codeTextField.text length] == 7) {
        self.bindButton.enabled = YES;
    }
}
#pragma mark - SetUPView
- (void)setUpView
{
    //背景图片
    UIImageView *backImageView = [[UIImageView alloc] init];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    [backImageView setImage:[UIImage imageNamed:@"login_background"]];
    
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
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
    }];
    [label setFont:LDRBoldFont24];
    [label setText:@"绑定手机号"];
    [label setTextColor:LDR_TextBalckColor];
    lastAttribute = label.mas_bottom;
    
    //手机号输入框
    LDRLoginTextField *textField = [[LDRLoginTextField alloc] init];
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
        make.top.equalTo(lastAttribute).mas_offset(46);
        make.height.mas_equalTo(48);
    }];
    self.textField = textField;
    [textField setFont:LDRFont16];
    textField.ldrDelegate = self;
    [textField setKeyboardType:UIKeyboardTypePhonePad];
    textField.placeholder = @"请输入手机号";
    lastAttribute = textField.mas_bottom;
    
    //验证码输入框
    LDRLoginTextField *codeTextField = [[LDRLoginTextField alloc] init];
    [self.view addSubview:codeTextField];
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
        make.top.equalTo(lastAttribute).mas_offset(30);
        make.height.mas_equalTo(48);
    }];
    self.textField = textField;
    [codeTextField setFont:LDRFont16];
    codeTextField.ldrDelegate = self;
    [codeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    codeTextField.placeholder = @"请输入验证码";
    codeTextField.maxLen = 7;
    self.codeTextField = codeTextField;
    lastAttribute = codeTextField.mas_bottom;
    
    UIButton *codeButton = [UIButton buttonWithTarget:self action:@selector(codeButtonAction:)];
    [self.view addSubview:codeButton];
    [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeTextField.mas_right);
        make.centerY.equalTo(codeTextField);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(76);
    }];
    [codeButton  setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    [codeButton setTitleColor:LDR_TextLightGrayColor forState:UIControlStateDisabled];
    [codeButton.titleLabel setFont:LDRFont12];
    [codeButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [codeButton.layer setCornerRadius:12];
    [codeButton.layer setBorderWidth:0.5f];
    [codeButton.layer setBorderColor:LDR_MainGreenColor.CGColor];
    self.codeButton = codeButton;
    
    UIButton *loginButton = [UIButton buttonWithTarget:self action:@selector(bindButtonAction:)];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
        make.top.equalTo(lastAttribute).mas_offset(32);
        make.height.mas_equalTo(48);
    }];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_TextLightGrayColor] forState:UIControlStateHighlighted];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:LDRFont14];
    [loginButton setTitle:@"同意协议并绑定" forState:UIControlStateNormal];
    [loginButton.layer setCornerRadius:LDRRadius];
    loginButton.enabled = NO;
    [loginButton setClipsToBounds:YES];
    self.bindButton = loginButton;
    lastAttribute = loginButton.mas_bottom;
    
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
