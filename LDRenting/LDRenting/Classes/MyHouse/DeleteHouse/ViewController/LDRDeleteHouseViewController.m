//
//  LDRDeleteHouseViewController.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRDeleteHouseViewController.h"

@interface LDRDeleteHouseViewController ()<UITextFieldDelegate>

@end

@implementation LDRDeleteHouseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"删除房屋";
    [self.view setBackgroundColor:LDR_BackgroundColor];
    [self setUpView];
}
- (void)showDeleteAlert
{
    LDRWeakify(self);
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            
        } else {
            [weakSelf showResetAlert];
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
                      MMItemMake(@"继续删除", MMItemTypeNormal, block)];
    LDRAlterView *alert = [[LDRAlterView alloc] initWithTitle:@"删除房屋" detail:@"1.无法连接到门锁，是否继续删除房屋\n2.请自行在门锁端完成门锁恢复出厂设置，长按RESET键，语音提示后输入密码完成清除门锁端信息，数据清除后只能使用钥匙开门\n3.如未恢复出厂设置，已有开门方式在有效期内仍可开门进入" isWarning:YES items:items];
    [alert show];
}
- (void)showResetAlert
{
    LDRWeakify(self);
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            
        } else {
            [weakSelf showSuccess];
        }
    };
    NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
                      MMItemMake(@"继续删除", MMItemTypeNormal, block)];
    LDRAlterView *alert = [[LDRAlterView alloc] initWithTitle:@"门锁将进行初始化操作" detail:@"门锁初始化过程中，请保持蓝牙连接，初\n始化完成后，门锁和房屋会一并删除，门\n锁只能用钥匙开门" isWarning:YES items:items];
    [alert show];
}
- (void)showSuccess
{
    LDRAlterView *alert = [[LDRAlterView alloc] initWithConfirmTitle:@"门锁成功删除" detail:nil];
    [alert show];

}
#pragma mark - IBAction
- (void)codeButtonAction:(UIButton *)sender
{
    
}
- (void)bindButtonAction:(UIButton *)sender
{
    [self showDeleteAlert];
}
#pragma mark - SetUPView
- (void)setUpView
{
    MASViewAttribute *lastAttribute = self.view.mas_top;
    //欢迎语
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastAttribute).mas_offset(16);
        make.left.equalTo(self.view.mas_left).mas_offset(LDRPadding);
        make.width.mas_equalTo(80);
    }];
    [label setFont:LDRFont16];
    [label setText:@"手机号码"];
    [label setTextColor:LDR_TextBalckColor];
    lastAttribute = label.mas_bottom;
    
    //手机号输入框
    UITextField *textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.left.equalTo(label.mas_right).mas_offset(LDRPadding);
        make.right.equalTo(self.view.mas_right).mas_offset(-LDRPadding);
    }];
    [textField setFont:LDRFont16];
    textField.delegate = self;
    [textField setKeyboardType:UIKeyboardTypePhonePad];
    textField.placeholder = @"请输入手机号";
    lastAttribute = textField.mas_bottom;
    
    
    UILabel *label1 = [[UILabel alloc] init];
    [self.view addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastAttribute).mas_offset(36);
        make.left.equalTo(self.view.mas_left).mas_offset(LDRPadding);
        make.width.mas_equalTo(80);
    }];
    [label1 setFont:LDRFont16];
    [label1 setText:@"验证码"];
    [label1 setTextColor:LDR_TextBalckColor];
    lastAttribute = label1.mas_bottom;
    //验证码输入框
    UITextField *codeTextField = [[UITextField alloc] init];
    [self.view addSubview:codeTextField];
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1);
        make.left.equalTo(label1.mas_right).mas_offset(LDRPadding);
        make.right.equalTo(self.view.mas_right).mas_offset(-LDRPadding);
    }];
    [codeTextField setFont:LDRFont16];
    [codeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    codeTextField.placeholder = @"请输入验证码";
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
//    self.codeButton = codeButton;
    
    UIButton *loginButton = [UIButton buttonWithTarget:self action:@selector(bindButtonAction:)];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
        make.top.equalTo(lastAttribute).mas_offset(48);
        make.height.mas_equalTo(48);
    }];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_TextLightGrayColor] forState:UIControlStateHighlighted];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
    [loginButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:LDRFont14];
    [loginButton setTitle:@"确认" forState:UIControlStateNormal];
    [loginButton.layer setCornerRadius:LDRRadius];
//    loginButton.enabled = NO;
    [loginButton setClipsToBounds:YES];
//    self.bindButton = loginButton;
    lastAttribute = loginButton.mas_bottom;
    
    UILabel *label2 = [[UILabel alloc] init];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastAttribute).mas_offset(24);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
    }];
    [label2 setFont:LDRFont12];
    [label2 setText:@"注：删除房屋将会删除门锁，需要手机号验证，请谨慎操作"];
    [label2 setNumberOfLines:0];
    [label2 setTextColor:LDR_TextGrayColor];
    lastAttribute = label1.mas_bottom;
}

@end
